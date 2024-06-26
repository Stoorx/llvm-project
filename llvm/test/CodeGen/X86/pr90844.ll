; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=x86_64-unknown-unknown -mattr=+avx512f,-evex512 < %s | FileCheck %s

define void @PR90844() {
; CHECK-LABEL: PR90844:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovaps %xmm0, (%rax)
; CHECK-NEXT:    retq
entry:
  %0 = tail call <2 x i32> @llvm.fshl.v2i32(<2 x i32> poison, <2 x i32> poison, <2 x i32> <i32 8, i32 24>)
  %1 = and <2 x i32> %0, <i32 16711935, i32 -134152448>
  %2 = or disjoint <2 x i32> zeroinitializer, %1
  %3 = zext <2 x i32> %2 to <2 x i64>
  %4 = shl nuw <2 x i64> %3, <i64 32, i64 32>
  %5 = or disjoint <2 x i64> %4, zeroinitializer
  store <2 x i64> %5, ptr poison, align 16
  ret void
}
