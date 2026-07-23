; ModuleID = 'C:/Users/cocol/Ruby_Proj/workspace/conv1/conv1/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: argmemonly noinline willreturn
define void @apatb_conv1_1d_ir([32 x float]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="2" %inputs, [32 x float]* noalias nocapture nonnull "fpga.decayed.dim.hint"="16" %outputs, [2 x [5 x float]]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="16" %weights, float* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="16" %bias) local_unnamed_addr #0 {
entry:
  %0 = bitcast [32 x float]* %inputs to [2 x [32 x float]]*
  %inputs_copy = alloca [2 x [32 x float]], align 512
  %1 = bitcast [32 x float]* %outputs to [16 x [32 x float]]*
  %outputs_copy = alloca [16 x [32 x float]], align 512
  %2 = bitcast [2 x [5 x float]]* %weights to [16 x [2 x [5 x float]]]*
  %weights_copy = alloca [16 x [2 x [5 x float]]], align 512
  %3 = bitcast float* %bias to [16 x float]*
  %bias_copy = alloca [16 x float], align 512
  call fastcc void @copy_in([2 x [32 x float]]* nonnull %0, [2 x [32 x float]]* nonnull align 512 %inputs_copy, [16 x [32 x float]]* nonnull %1, [16 x [32 x float]]* nonnull align 512 %outputs_copy, [16 x [2 x [5 x float]]]* nonnull %2, [16 x [2 x [5 x float]]]* nonnull align 512 %weights_copy, [16 x float]* nonnull %3, [16 x float]* nonnull align 512 %bias_copy)
  call void @apatb_conv1_1d_hw([2 x [32 x float]]* %inputs_copy, [16 x [32 x float]]* %outputs_copy, [16 x [2 x [5 x float]]]* %weights_copy, [16 x float]* %bias_copy)
  call void @copy_back([2 x [32 x float]]* %0, [2 x [32 x float]]* %inputs_copy, [16 x [32 x float]]* %1, [16 x [32 x float]]* %outputs_copy, [16 x [2 x [5 x float]]]* %2, [16 x [2 x [5 x float]]]* %weights_copy, [16 x float]* %3, [16 x float]* %bias_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([2 x [32 x float]]* noalias readonly, [2 x [32 x float]]* noalias align 512, [16 x [32 x float]]* noalias readonly, [16 x [32 x float]]* noalias align 512, [16 x [2 x [5 x float]]]* noalias readonly, [16 x [2 x [5 x float]]]* noalias align 512, [16 x float]* noalias readonly, [16 x float]* noalias align 512) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0a2a32f32([2 x [32 x float]]* align 512 %1, [2 x [32 x float]]* %0)
  call fastcc void @onebyonecpy_hls.p0a16a32f32([16 x [32 x float]]* align 512 %3, [16 x [32 x float]]* %2)
  call fastcc void @onebyonecpy_hls.p0a16a2a5f32([16 x [2 x [5 x float]]]* align 512 %5, [16 x [2 x [5 x float]]]* %4)
  call fastcc void @onebyonecpy_hls.p0a16f32([16 x float]* align 512 %7, [16 x float]* %6)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a2a32f32([2 x [32 x float]]* noalias align 512 %dst, [2 x [32 x float]]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x [32 x float]]* %dst, null
  %1 = icmp eq [2 x [32 x float]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a2a32f32([2 x [32 x float]]* nonnull %dst, [2 x [32 x float]]* nonnull %src, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a2a32f32([2 x [32 x float]]* %dst, [2 x [32 x float]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [2 x [32 x float]]* %src, null
  %1 = icmp eq [2 x [32 x float]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [2 x [32 x float]], [2 x [32 x float]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [2 x [32 x float]], [2 x [32 x float]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a32f32([32 x float]* %dst.addr, [32 x float]* %src.addr, i64 32)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a32f32([32 x float]* %dst, [32 x float]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [32 x float]* %src, null
  %1 = icmp eq [32 x float]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [32 x float], [32 x float]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [32 x float], [32 x float]* %src, i64 0, i64 %for.loop.idx2
  %3 = load float, float* %src.addr, align 4
  store float %3, float* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a16a32f32([16 x [32 x float]]* noalias align 512 %dst, [16 x [32 x float]]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x [32 x float]]* %dst, null
  %1 = icmp eq [16 x [32 x float]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a16a32f32([16 x [32 x float]]* nonnull %dst, [16 x [32 x float]]* nonnull %src, i64 16)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a16a32f32([16 x [32 x float]]* %dst, [16 x [32 x float]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [16 x [32 x float]]* %src, null
  %1 = icmp eq [16 x [32 x float]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [16 x [32 x float]], [16 x [32 x float]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [16 x [32 x float]], [16 x [32 x float]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a32f32([32 x float]* %dst.addr, [32 x float]* %src.addr, i64 32)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a16a2a5f32([16 x [2 x [5 x float]]]* noalias align 512 %dst, [16 x [2 x [5 x float]]]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x [2 x [5 x float]]]* %dst, null
  %1 = icmp eq [16 x [2 x [5 x float]]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a16a2a5f32([16 x [2 x [5 x float]]]* nonnull %dst, [16 x [2 x [5 x float]]]* nonnull %src, i64 16)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a16a2a5f32([16 x [2 x [5 x float]]]* %dst, [16 x [2 x [5 x float]]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [16 x [2 x [5 x float]]]* %src, null
  %1 = icmp eq [16 x [2 x [5 x float]]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [16 x [2 x [5 x float]]], [16 x [2 x [5 x float]]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [16 x [2 x [5 x float]]], [16 x [2 x [5 x float]]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a2a5f32([2 x [5 x float]]* %dst.addr, [2 x [5 x float]]* %src.addr, i64 2)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a2a5f32([2 x [5 x float]]* %dst, [2 x [5 x float]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [2 x [5 x float]]* %src, null
  %1 = icmp eq [2 x [5 x float]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [2 x [5 x float]], [2 x [5 x float]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [2 x [5 x float]], [2 x [5 x float]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a5f32([5 x float]* %dst.addr, [5 x float]* %src.addr, i64 5)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5f32([5 x float]* %dst, [5 x float]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [5 x float]* %src, null
  %1 = icmp eq [5 x float]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x float], [5 x float]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x float], [5 x float]* %src, i64 0, i64 %for.loop.idx2
  %3 = load float, float* %src.addr, align 4
  store float %3, float* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a16f32([16 x float]* noalias align 512 %dst, [16 x float]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x float]* %dst, null
  %1 = icmp eq [16 x float]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a16f32([16 x float]* nonnull %dst, [16 x float]* nonnull %src, i64 16)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a16f32([16 x float]* %dst, [16 x float]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [16 x float]* %src, null
  %1 = icmp eq [16 x float]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [16 x float], [16 x float]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [16 x float], [16 x float]* %src, i64 0, i64 %for.loop.idx2
  %3 = load float, float* %src.addr, align 4
  store float %3, float* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([2 x [32 x float]]* noalias, [2 x [32 x float]]* noalias readonly align 512, [16 x [32 x float]]* noalias, [16 x [32 x float]]* noalias readonly align 512, [16 x [2 x [5 x float]]]* noalias, [16 x [2 x [5 x float]]]* noalias readonly align 512, [16 x float]* noalias, [16 x float]* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a2a32f32([2 x [32 x float]]* %0, [2 x [32 x float]]* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0a16a32f32([16 x [32 x float]]* %2, [16 x [32 x float]]* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0a16a2a5f32([16 x [2 x [5 x float]]]* %4, [16 x [2 x [5 x float]]]* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0a16f32([16 x float]* %6, [16 x float]* align 512 %7)
  ret void
}

declare void @apatb_conv1_1d_hw([2 x [32 x float]]*, [16 x [32 x float]]*, [16 x [2 x [5 x float]]]*, [16 x float]*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([2 x [32 x float]]* noalias, [2 x [32 x float]]* noalias readonly align 512, [16 x [32 x float]]* noalias, [16 x [32 x float]]* noalias readonly align 512, [16 x [2 x [5 x float]]]* noalias, [16 x [2 x [5 x float]]]* noalias readonly align 512, [16 x float]* noalias, [16 x float]* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a16a32f32([16 x [32 x float]]* %2, [16 x [32 x float]]* align 512 %3)
  ret void
}

declare void @conv1_1d_hw_stub([32 x float]* noalias nocapture nonnull readonly, [32 x float]* noalias nocapture nonnull, [2 x [5 x float]]* noalias nocapture nonnull readonly, float* noalias nocapture nonnull readonly)

define void @conv1_1d_hw_stub_wrapper([2 x [32 x float]]*, [16 x [32 x float]]*, [16 x [2 x [5 x float]]]*, [16 x float]*) #5 {
entry:
  call void @copy_out([2 x [32 x float]]* null, [2 x [32 x float]]* %0, [16 x [32 x float]]* null, [16 x [32 x float]]* %1, [16 x [2 x [5 x float]]]* null, [16 x [2 x [5 x float]]]* %2, [16 x float]* null, [16 x float]* %3)
  %4 = bitcast [2 x [32 x float]]* %0 to [32 x float]*
  %5 = bitcast [16 x [32 x float]]* %1 to [32 x float]*
  %6 = bitcast [16 x [2 x [5 x float]]]* %2 to [2 x [5 x float]]*
  %7 = bitcast [16 x float]* %3 to float*
  call void @conv1_1d_hw_stub([32 x float]* %4, [32 x float]* %5, [2 x [5 x float]]* %6, float* %7)
  call void @copy_in([2 x [32 x float]]* null, [2 x [32 x float]]* %0, [16 x [32 x float]]* null, [16 x [32 x float]]* %1, [16 x [2 x [5 x float]]]* null, [16 x [2 x [5 x float]]]* %2, [16 x float]* null, [16 x float]* %3)
  ret void
}

attributes #0 = { argmemonly noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
