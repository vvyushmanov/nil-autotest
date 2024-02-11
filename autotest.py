import subprocess
import pytest
import os
import glob

# Utility functions
def measure_memory_usage(cmd):
    process = subprocess.Popen(
        ['valgrind', '--tool=massif'] + cmd,
        stdout=subprocess.DEVNULL, 
        stderr=subprocess.DEVNULL
        )
    process.wait()
    massif_output = f"massif.out.{process.pid}"  
    return massif_output

def extract_max_heap_usage(massif_file):
    cmd = f"ms_print {massif_file} | awk '{{print $3}}' | grep '^[0-9]*,' | tr -d ',' | sort -n | tail -1"
    peak_heap = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.strip()
    return int(peak_heap)

def measure_and_report_heap_usage(cmd):
    massif_out_file = measure_memory_usage(cmd) 
    try:
        max_heap = extract_max_heap_usage(massif_out_file)
    finally:
        os.remove(massif_out_file)
    return max_heap

def parse_time(time_string):
    minutes, seconds = time_string[:-1].split('m')
    time_ms = (int(minutes) * 60 + float(seconds)) * 1000
    return time_ms

def measure_time(cmd):
    full_cmd = f"bash -c 'time {cmd}' 2>&1 | grep real | awk '{{print $2}}'"
    time = subprocess.run(full_cmd, 
                          shell=True, 
                          capture_output=True, 
                          text=True).stdout.strip()
    return int(parse_time(time))

# FIXTURES
@pytest.fixture
def assigner_max_heap():

    cmd = [
        'assigner',
        '-b', 'build/src/template.ll',
        '-p', './src/main-input.json',
        '-c', 'build/src/template.crct',
        '-t', 'build/src/template.tbl',
        '-e', 'pallas'
    ]

    return measure_and_report_heap_usage(cmd)

@pytest.fixture
def proof_generator_max_heap():

    cmd = [
        'proof-generator-single-threaded',
        '--circuit', 'build/src/template.crct', 
        '--assignment', 'build/src/template.tbl', 
        '--proof', 'build/proof.bin'
    ]

    return measure_and_report_heap_usage(cmd)

@pytest.fixture
def assigner_time():

    cmd = "assigner -b build/src/template.ll -p ./src/main-input.json -c build/src/template.crct -t build/src/template.tbl -e pallas"

    return measure_time(cmd)

@pytest.fixture
def proof_generator_time():

    cmd = "proof-generator-single-threaded --circuit  build/src/template.crct --assignment build/src/template.tbl --proof build/proof.bin"

    return measure_time(cmd)

@pytest.fixture
def proof_generator_verify():
    # Look for the "proof is verified" line in the output. If the line is found, `grep` returncode is 0, otherwise 1.
    cmd = "proof-generator-single-threaded --circuit  build/src/template.crct --assignment build/src/template.tbl --proof build/proof.bin | grep 'Proof is verified'"
    return subprocess.run(cmd, shell=True).returncode

# TESTS
def test_assert_assigner_heap(assigner_max_heap): 
    assert assigner_max_heap < 483000000, "Max heap usage is above 483000000!"

def test_assert_assigner_time(assigner_time):
    assert assigner_time < 220, "Execution time is above 220ms!"

def test_assert_proof_generator_heap(proof_generator_max_heap): 
    assert proof_generator_max_heap < 1180000, "Max heap usage is above 1180000!"

def test_assert_proof_generator_time(proof_generator_time):
    assert proof_generator_time < 260, "Execution time is above 260ms!"

def test_assert_proof_generator_verified(proof_generator_verify):
    assert proof_generator_verify == 0, "There was no \"proof verified\" line!"

# Code to execute before/after all tests
@pytest.fixture(scope="session", autouse=True)
def cleanup():
    # Execute before tests

    yield
    # Execute after all tests
    for file in glob.glob("massif.out.*"):
        if os.path.isfile(file):  
            try:
                os.remove(file)
            except OSError as e:
                print(f"Can't delete {file}: {e}")  
