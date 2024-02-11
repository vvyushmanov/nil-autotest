; ModuleID = '/opt/zkllvm-template/src/main.cpp'
source_filename = "/opt/zkllvm-template/src/main.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "assigner"

$_ZN3nil7crypto37algebra6fields17pallas_base_field12modulus_bitsE = comdat any

$_ZN3nil7crypto37algebra6fields17pallas_base_field11number_bitsE = comdat any

$_ZN3nil7crypto37algebra6fields17pallas_base_field10value_bitsE = comdat any

$_ZN3nil7crypto37algebra6fields16vesta_base_field12modulus_bitsE = comdat any

$_ZN3nil7crypto37algebra6fields16vesta_base_field11number_bitsE = comdat any

$_ZN3nil7crypto37algebra6fields16vesta_base_field10value_bitsE = comdat any

@_ZZN3nil7crypto314multiprecision8backends11window_bitsEmE5wsize = internal unnamed_addr constant [6 x [2 x i64]] [[2 x i64] [i64 1434, i64 7], [2 x i64] [i64 539, i64 6], [2 x i64] [i64 197, i64 4], [2 x i64] [i64 70, i64 3], [2 x i64] [i64 17, i64 2], [2 x i64] zeroinitializer], align 8
@_ZN3nil7crypto37algebra6fields17pallas_base_field12modulus_bitsE = weak_odr dso_local local_unnamed_addr constant i64 255, comdat, align 8
@_ZN3nil7crypto37algebra6fields17pallas_base_field11number_bitsE = weak_odr dso_local local_unnamed_addr constant i64 255, comdat, align 8
@_ZN3nil7crypto37algebra6fields17pallas_base_field10value_bitsE = weak_odr dso_local local_unnamed_addr constant i64 255, comdat, align 8
@_ZN3nil7crypto37algebra6fields16vesta_base_field12modulus_bitsE = weak_odr dso_local local_unnamed_addr constant i64 255, comdat, align 8
@_ZN3nil7crypto37algebra6fields16vesta_base_field11number_bitsE = weak_odr dso_local local_unnamed_addr constant i64 255, comdat, align 8
@_ZN3nil7crypto37algebra6fields16vesta_base_field10value_bitsE = weak_odr dso_local local_unnamed_addr constant i64 255, comdat, align 8

; Function Attrs: mustprogress nounwind
define dso_local noundef i64 @_ZN3nil7crypto314multiprecision8backends11window_bitsEm(i64 noundef %0) local_unnamed_addr #0 {
  br label %2

2:                                                ; preds = %2, %1
  %3 = phi i64 [ 5, %1 ], [ %7, %2 ]
  %4 = getelementptr inbounds [6 x [2 x i64]], ptr @_ZZN3nil7crypto314multiprecision8backends11window_bitsEmE5wsize, i64 0, i64 %3
  %5 = load i64, ptr %4, align 8, !tbaa !3
  %6 = icmp ugt i64 %5, %0
  %7 = add i64 %3, -1
  br i1 %6, label %2, label %8, !llvm.loop !7

8:                                                ; preds = %2
  %9 = getelementptr inbounds [2 x i64], ptr %4, i64 0, i64 1
  %10 = load i64, ptr %9, align 8, !tbaa !3
  %11 = add i64 1, %10
  ret i64 %11
}

; Function Attrs: mustprogress nounwind
define dso_local noundef zeroext i1 @_Z7is_samemm(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq i64 %0, %1
  ret i1 %3
}

; Function Attrs: circuit mustprogress nounwind
define dso_local noundef zeroext i1 @_Z15validate_numberm(i64 noundef private_input %0) local_unnamed_addr #1 {
  %2 = tail call noundef zeroext i1 @_Z7is_samemm(i64 noundef %0, i64 noundef 5)
  ret i1 %2
}

attributes #0 = { mustprogress nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { circuit mustprogress nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"frame-pointer", i32 2}
!2 = !{!"clang version 16.0.0 (https://github.com/NilFoundation/zkllvm-circifier.git 1b5d1ccdb41cfac9eeb64efe275f23054ffa2ed9)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"long", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = distinct !{!7, !8, !9}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{!"llvm.loop.unroll.disable"}
