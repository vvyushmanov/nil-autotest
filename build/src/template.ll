; ModuleID = 'llvm-link'
source_filename = "llvm-link"
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

; Function Attrs: nounwind
define dso_local void @free(ptr noundef %0) local_unnamed_addr #2 {
  tail call void @llvm.assigner.free(ptr %0)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.assigner.free(ptr) #3

; Function Attrs: nounwind allocsize(0)
define dso_local ptr @malloc(i64 noundef %0) local_unnamed_addr #4 {
  %2 = tail call ptr @llvm.assigner.malloc(i64 %0)
  ret ptr %2
}

; Function Attrs: nounwind
declare ptr @llvm.assigner.malloc(i64) #3

; Function Attrs: nounwind
define dso_local i64 @strlen(ptr noundef %0) local_unnamed_addr #2 {
  br label %2

2:                                                ; preds = %2, %1
  %3 = phi i64 [ 0, %1 ], [ %8, %2 ]
  %4 = getelementptr inbounds i8, ptr %0, i64 %3
  %5 = load i8, ptr %4, align 1, !tbaa !10
  %6 = sext i8 %5 to i32
  %7 = icmp ne i32 %6, 0
  %8 = add i64 %3, 1
  br i1 %7, label %2, label %9, !llvm.loop !13

9:                                                ; preds = %2
  ret i64 %3
}

; Function Attrs: nounwind
define dso_local i32 @strcmp(ptr noundef %0, ptr noundef %1) local_unnamed_addr #2 {
  br label %3

3:                                                ; preds = %25, %2
  %4 = phi ptr [ %0, %2 ], [ %26, %25 ]
  %5 = phi ptr [ %1, %2 ], [ %27, %25 ]
  %6 = load i8, ptr %4, align 1, !tbaa !10
  %7 = sext i8 %6 to i32
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %13, label %9

9:                                                ; preds = %3
  %10 = load i8, ptr %5, align 1, !tbaa !10
  %11 = sext i8 %10 to i32
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %28

13:                                               ; preds = %9, %3
  %14 = load i8, ptr %4, align 1, !tbaa !10
  %15 = sext i8 %14 to i32
  %16 = load i8, ptr %5, align 1, !tbaa !10
  %17 = sext i8 %16 to i32
  %18 = icmp ne i32 %15, %17
  br i1 %18, label %19, label %25

19:                                               ; preds = %13
  %20 = load i8, ptr %4, align 1, !tbaa !10
  %21 = sext i8 %20 to i32
  %22 = load i8, ptr %5, align 1, !tbaa !10
  %23 = sext i8 %22 to i32
  %24 = sub nsw i32 %21, %23
  br label %28

25:                                               ; preds = %13
  %26 = getelementptr inbounds i8, ptr %4, i32 1
  %27 = getelementptr inbounds i8, ptr %5, i32 1
  br label %3, !llvm.loop !14

28:                                               ; preds = %19, %9
  %29 = phi i32 [ %24, %19 ], [ 0, %9 ]
  ret i32 %29
}

; Function Attrs: nounwind
define dso_local i32 @strncmp(ptr noundef %0, ptr noundef %1, i64 noundef %2) local_unnamed_addr #2 {
  %4 = icmp ugt i64 %2, 0
  br i1 %4, label %5, label %33

5:                                                ; preds = %28, %3
  %6 = phi ptr [ %30, %28 ], [ %1, %3 ]
  %7 = phi ptr [ %29, %28 ], [ %0, %3 ]
  %8 = phi i64 [ %31, %28 ], [ %2, %3 ]
  %9 = load i8, ptr %7, align 1, !tbaa !10
  %10 = sext i8 %9 to i32
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %16, label %12

12:                                               ; preds = %5
  %13 = load i8, ptr %6, align 1, !tbaa !10
  %14 = sext i8 %13 to i32
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %16, label %33

16:                                               ; preds = %12, %5
  %17 = load i8, ptr %7, align 1, !tbaa !10
  %18 = sext i8 %17 to i32
  %19 = load i8, ptr %6, align 1, !tbaa !10
  %20 = sext i8 %19 to i32
  %21 = icmp ne i32 %18, %20
  br i1 %21, label %22, label %28

22:                                               ; preds = %16
  %23 = load i8, ptr %7, align 1, !tbaa !10
  %24 = sext i8 %23 to i32
  %25 = load i8, ptr %6, align 1, !tbaa !10
  %26 = sext i8 %25 to i32
  %27 = sub nsw i32 %24, %26
  br label %33

28:                                               ; preds = %16
  %29 = getelementptr inbounds i8, ptr %7, i32 1
  %30 = getelementptr inbounds i8, ptr %6, i32 1
  %31 = add i64 %8, -1
  %32 = icmp ugt i64 %31, 0
  br i1 %32, label %5, label %33, !llvm.loop !15

33:                                               ; preds = %28, %22, %12, %3
  %34 = phi i32 [ %27, %22 ], [ 0, %3 ], [ 0, %12 ], [ 0, %28 ]
  ret i32 %34
}

; Function Attrs: nounwind
define dso_local ptr @strcpy(ptr noundef %0, ptr noundef %1) local_unnamed_addr #2 {
  %3 = load i8, ptr %1, align 1, !tbaa !10
  store i8 %3, ptr %0, align 1, !tbaa !10
  %4 = sext i8 %3 to i32
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %6, label %14

6:                                                ; preds = %6, %2
  %7 = phi ptr [ %10, %6 ], [ %1, %2 ]
  %8 = phi ptr [ %9, %6 ], [ %0, %2 ]
  %9 = getelementptr inbounds i8, ptr %8, i32 1
  %10 = getelementptr inbounds i8, ptr %7, i32 1
  %11 = load i8, ptr %10, align 1, !tbaa !10
  store i8 %11, ptr %9, align 1, !tbaa !10
  %12 = sext i8 %11 to i32
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %6, label %14, !llvm.loop !16

14:                                               ; preds = %6, %2
  ret ptr %0
}

; Function Attrs: nounwind
define dso_local ptr @strncpy(ptr noundef %0, ptr noundef %1, i64 noundef %2) local_unnamed_addr #2 {
  %4 = icmp ugt i64 %2, 0
  br i1 %4, label %5, label %17

5:                                                ; preds = %12, %3
  %6 = phi ptr [ %14, %12 ], [ %1, %3 ]
  %7 = phi ptr [ %13, %12 ], [ %0, %3 ]
  %8 = phi i64 [ %15, %12 ], [ %2, %3 ]
  %9 = load i8, ptr %6, align 1, !tbaa !10
  store i8 %9, ptr %7, align 1, !tbaa !10
  %10 = sext i8 %9 to i32
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %17

12:                                               ; preds = %5
  %13 = getelementptr inbounds i8, ptr %7, i32 1
  %14 = getelementptr inbounds i8, ptr %6, i32 1
  %15 = add i64 %8, -1
  %16 = icmp ugt i64 %15, 0
  br i1 %16, label %5, label %17, !llvm.loop !17

17:                                               ; preds = %12, %5, %3
  %18 = phi i64 [ %2, %3 ], [ %8, %5 ], [ %15, %12 ]
  %19 = phi ptr [ %0, %3 ], [ %7, %5 ], [ %13, %12 ]
  %20 = icmp ugt i64 %18, 0
  br i1 %20, label %21, label %27

21:                                               ; preds = %21, %17
  %22 = phi ptr [ %24, %21 ], [ %19, %17 ]
  %23 = phi i64 [ %25, %21 ], [ %18, %17 ]
  store i8 0, ptr %22, align 1, !tbaa !10
  %24 = getelementptr inbounds i8, ptr %22, i32 1
  %25 = add i64 %23, -1
  %26 = icmp ugt i64 %25, 0
  br i1 %26, label %21, label %27, !llvm.loop !18

27:                                               ; preds = %21, %17
  ret ptr %0
}

attributes #0 = { mustprogress nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { circuit mustprogress nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #3 = { nounwind }
attributes #4 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }

!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2}

!0 = !{!"clang version 16.0.0 (https://github.com/NilFoundation/zkllvm-circifier.git 1b5d1ccdb41cfac9eeb64efe275f23054ffa2ed9)"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!4, !4, i64 0}
!4 = !{!"long", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = distinct !{!7, !8, !9}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{!"llvm.loop.unroll.disable"}
!10 = !{!11, !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = distinct !{!13, !8, !9}
!14 = distinct !{!14, !8, !9}
!15 = distinct !{!15, !8, !9}
!16 = distinct !{!16, !8, !9}
!17 = distinct !{!17, !8, !9}
!18 = distinct !{!18, !8, !9}
