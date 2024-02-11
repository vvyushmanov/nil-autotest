#!/usr/bin/env bash

# This script has all the commands from the tutorial,
# conveniently running in a Docker or Podman environment.
# You can run them with this script to get the job done quick,
# or enter them manually when you want to get into more detail.
# Besides that, each command is checked in CI, just to make sure that
# everything works for you when you run it yourself.

set -euo pipefail

# define dirs so that we can run scripts from any directory without shifting filesystem paths
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
REPO_ROOT="$SCRIPT_DIR/.."

# You can set image version as an environment variable before running this script:
# export TOOLCHAIN_VERSION=<custom version here>
# See all available versions at
# https://github.com/orgs/NilFoundation/packages/container/package/toolchain
# If unset, default value will be used:
echo "using nilfoundation/toolchain:${TOOLCHAIN_VERSION:=0.1.8}"

# podman is a safer option for using on CI machines
if ! command -v podman; then
    DOCKER="docker"
    DOCKER_OPTS=""
else
    DOCKER="podman"
    DOCKER_OPTS='--detach-keys= --userns=keep-id'
fi

# checking files that should be produced
# on all steps of the pipeline
check_file_exists() {
    FILE1="${1}"
    if [ ! -e "$FILE1" ]
    then
        echo "File $FILE1 was not created" >&2
        exit 1
    else
        echo "File $FILE1 created successfully"
        ls -hal "$FILE1"
    fi
}

run_toolchain() {
    cd $REPO_ROOT
    # silently stop the existing container if it's running already
    $DOCKER rm nil-tolchain 2>/dev/null || true
    $DOCKER run -it --rm \
        --name nil-tolchain \
        --volume $(pwd):/opt/zkllvm-template \
        --user $(id -u ${USER}):$(id -g ${USER}) \
        ghcr.io/nilfoundation/toolchain:${TOOLCHAIN_VERSION}
}


# Deprecated.
# Python scripts will be moved to the main image, nilfoundation/toolchain
run_proof_market_toolchain() {
    cd $REPO_ROOT
    # create files for storing credentials, so that they would persist
    # after stopping a container
    touch .config/config.ini .config/.user .config/.secret
    # silently stop the existing container if it's running already
    $DOCKER stop proof-market 2>/dev/null || true
    $DOCKER run -it --rm \
        --name proof-market \
        --volume $(pwd):/opt/zkllvm-template \
        --volume $(pwd)/.config:/.config/ \
        --volume $(pwd)/.config:/root/.config/ \
        --volume $(pwd)/.config/.user:/proof-market-toolchain/scripts/.user \
        --volume $(pwd)/.config/.secret:/proof-market-toolchain/scripts/.secret \
        --user $(id -u ${USER}):$(id -g ${USER}) \
      ghcr.io/nilfoundation/toolchain:${TOOLCHAIN_VERSION}
}

# Compile source code into a circuit
# https://github.com/nilfoundation/toolchain/#step-1-compile-a-circuit
compile() {
    if [ "$USE_DOCKER" = true ] ; then
        cd "$REPO_ROOT"
        $DOCKER run $DOCKER_OPTS \
          --rm \
          --platform=linux/amd64 \
          --user $(id -u ${USER}):$(id -g ${USER}) \
          --volume $(pwd):/opt/zkllvm-template \
          ghcr.io/nilfoundation/toolchain:${TOOLCHAIN_VERSION} \
          sh -c "bash ./scripts/run.sh compile"
        cd -
    else
        rm -rf "$REPO_ROOT/build"
        mkdir -p "$REPO_ROOT/build"
        cd "$REPO_ROOT/build"
        cmake -DCIRCUIT_ASSEMBLY_OUTPUT=TRUE ..
        VERBOSE=1 make template
        cd -
        check_file_exists "$REPO_ROOT/build/src/template.ll"
    fi
}

# Run assigner to produce a circuit file and an assignment table.
# The proof-generator CLI uses these files to compute a proof.
run_assigner() {
    if [ "$USE_DOCKER" = true ] ; then
        cd "$REPO_ROOT"
        $DOCKER run $DOCKER_OPTS \
          --rm \
          --platform=linux/amd64 \
          --user $(id -u ${USER}):$(id -g ${USER}) \
          --volume $(pwd):/opt/zkllvm-template \
          ghcr.io/nilfoundation/toolchain:${TOOLCHAIN_VERSION} \
          sh -c "bash ./scripts/run.sh run_assigner"
        cd -
    else
        cd "$REPO_ROOT/build"
        assigner \
          -b src/template.ll \
          -i ../src/main-input.json \
          -c template.crct \
          -t template.tbl \
          -e pallas
        cd -
        check_file_exists "$REPO_ROOT/build/template.crct"
        check_file_exists "$REPO_ROOT/build/template.tbl"
    fi
  }


# Build circuit parameter / gate argument files.
# They should be deployed on-chain and provided as inputs to the
# EVM Placeholder Verifier.
build_circuit_params() {
    if [ "$USE_DOCKER" = true ] ; then
        cd "$REPO_ROOT"
        $DOCKER run $DOCKER_OPTS \
          --rm \
          --platform=linux/amd64 \
          --user $(id -u ${USER}):$(id -g ${USER}) \
          --volume $(pwd):/opt/zkllvm-template \
          ghcr.io/nilfoundation/toolchain:${TOOLCHAIN_VERSION} \
          sh -c "bash ./scripts/run.sh build_circuit_params"
        cd -
    else
        cd "$REPO_ROOT/build"
        transpiler \
          -m gen-gate-argument \
          -i ../src/main-input.json \
          -t template.tbl \
          -c template.crct \
          -o template \
          --optimize-gates
        check_file_exists "$REPO_ROOT/build/template/gate_argument.sol"
        check_file_exists "$REPO_ROOT/build/template/linked_libs_list.json"
        check_file_exists "$REPO_ROOT/build/template/public_input.json"

        transpiler \
          -m gen-circuit-params \
          -i ../src/main-input.json \
          -t template.tbl \
          -c template.crct \
          -o template
        check_file_exists "$REPO_ROOT/build/template/circuit_params.json"
        cd -
    fi
  }

# Use the Proof Market toolchain to pack circuit into a statement
# that can later be used to produce a proof locally or sent to the
# Proof Market.
# https://github.com/nilfoundation/toolchain/#step-2-build-a-circuit-statement
build_statement() {
    if [ "$USE_DOCKER" = true ] ; then
        cd "$REPO_ROOT"
        $DOCKER run $DOCKER_OPTS \
          --rm \
          --platform=linux/amd64 \
          --user $(id -u ${USER}):$(id -g ${USER}) \
          --volume $(pwd):/opt/zkllvm-template \
          --volume $(pwd)/.config:/.config/ \
          --volume $(pwd)/.config:/root/.config/ \
          --volume $(pwd)/.config:/proof-market-toolchain/.config/ \
          ghcr.io/nilfoundation/toolchain:${TOOLCHAIN_VERSION}  \
          sh -c "bash /opt/zkllvm-template/scripts/run.sh build_statement"
        cd -
    else
        cd /opt/zkllvm-template/
        python3 \
            /proof-market-toolchain/scripts/prepare_statement.py \
            --circuit "$REPO_ROOT/build/src/template.ll" \
            --name template \
            --type placeholder-zkllvm \
            --private \
            --output "$REPO_ROOT/build/template.json"
        check_file_exists "$REPO_ROOT/build/template.json"
    fi
}

# Prove the circuit with particular input.
# See the input files at:
# ./src/main-input.json
# https://github.com/nilfoundation/toolchain/#step-3-produce-and-verify-a-proof-locally
prove() {
    if [ "$USE_DOCKER" = true ] ; then
        cd "$REPO_ROOT"

        mkdir -p $REPO_ROOT/build/template
        # workaround for https://github.com/nilfoundation/toolchain/issues/61
        mkdir -p .config
        touch .config/config.ini
        $DOCKER run $DOCKER_OPTS \
          --rm \
          --platform=linux/amd64 \
          --user $(id -u ${USER}):$(id -g ${USER}) \
          --volume $(pwd):/opt/zkllvm-template \
          --volume $(pwd)/.config:/.config/ \
          --volume $(pwd)/.config:/root/.config/ \
          --volume $(pwd)/.config:/opt/nil-toolchain/.config/ \
          ghcr.io/nilfoundation/toolchain:${TOOLCHAIN_VERSION} \
          sh -c "bash /opt/zkllvm-template/scripts/run.sh prove"
        cd -
    else
        cd "$REPO_ROOT"
        proof-generator \
            --circuit="$REPO_ROOT/build/template.crct" \
            --assignment-table="$REPO_ROOT/build/template.tbl" \
            --proof="$REPO_ROOT/build/template/proof.bin"
        check_file_exists "$REPO_ROOT/build/template/proof.bin"
    fi
}

verify() {
  if [ "$USE_DOCKER" = true ] ; then
      cd "$REPO_ROOT"
      $DOCKER run $DOCKER_OPTS \
          --rm \
          --volume $(pwd):/opt/zkllvm-template \
          --volume $(pwd)/build/template:/opt/evm-placeholder-verification/contracts/zkllvm/template \
          ghcr.io/nilfoundation/evm-placeholder-verification:latest \
          sh -c "bash /opt/zkllvm-template/scripts/run.sh verify"
      cd -
  else
      cd /opt/evm-placeholder-verification
      npx hardhat deploy
      npx hardhat verify-circuit-proof --test template
  fi
}

run_all() {
    compile
    run_assigner
    prove
    build_circuit_params
}

USE_DOCKER=false
SUBCOMMAND=run_all

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--docker) USE_DOCKER=true ;;
        -v|--verbose) set -x ;;
        all) SUBCOMMAND=run_all ;;
        compile) SUBCOMMAND=compile ;;
        run_assigner) SUBCOMMAND=run_assigner ;;
        build_constraint) SUBCOMMAND=run_assigner ;; # keeping old command name for compatibilty
        build_circuit_params) SUBCOMMAND=build_circuit_params ;;
        build_statement) SUBCOMMAND=build_statement ;;
        prove) SUBCOMMAND=prove ;;
        verify) SUBCOMMAND=verify ;;
        run_toolchain) SUBCOMMAND=run_toolchain ;;
        run_proof_market_toolchain) SUBCOMMAND=run_proof_market_toolchain ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

echo "Running ${SUBCOMMAND}"
$SUBCOMMAND
