; ModuleID = 'C:/Users/cocol/Ruby_Proj/workspace/LSTM/LSTM/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: noinline
define void @apatb_LSTM_ir([32 x float]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="32" %W_f, [32 x float]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="32" %U_f, float* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="32" %b_f, [32 x float]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="32" %W_i, [32 x float]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="32" %U_i, float* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="32" %b_i, [32 x float]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="32" %W_g, [32 x float]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="32" %U_g, float* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="32" %b_g, [32 x float]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="32" %W_o, [32 x float]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="32" %U_o, float* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="32" %b_o, [32 x float]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="8" %x, float* noalias nocapture nonnull "fpga.decayed.dim.hint"="32" %h, float* noalias nocapture nonnull "fpga.decayed.dim.hint"="32" %c) local_unnamed_addr #0 {
entry:
  %0 = bitcast [32 x float]* %W_f to [32 x [32 x float]]*
  %1 = call i8* @malloc(i64 4096)
  %W_f_copy = bitcast i8* %1 to [32 x [32 x float]]*
  %2 = bitcast [32 x float]* %U_f to [32 x [32 x float]]*
  %3 = call i8* @malloc(i64 4096)
  %U_f_copy = bitcast i8* %3 to [32 x [32 x float]]*
  %4 = bitcast float* %b_f to [32 x float]*
  %b_f_copy = alloca [32 x float], align 512
  %5 = bitcast [32 x float]* %W_i to [32 x [32 x float]]*
  %6 = call i8* @malloc(i64 4096)
  %W_i_copy = bitcast i8* %6 to [32 x [32 x float]]*
  %7 = bitcast [32 x float]* %U_i to [32 x [32 x float]]*
  %8 = call i8* @malloc(i64 4096)
  %U_i_copy = bitcast i8* %8 to [32 x [32 x float]]*
  %9 = bitcast float* %b_i to [32 x float]*
  %b_i_copy = alloca [32 x float], align 512
  %10 = bitcast [32 x float]* %W_g to [32 x [32 x float]]*
  %11 = call i8* @malloc(i64 4096)
  %W_g_copy = bitcast i8* %11 to [32 x [32 x float]]*
  %12 = bitcast [32 x float]* %U_g to [32 x [32 x float]]*
  %13 = call i8* @malloc(i64 4096)
  %U_g_copy = bitcast i8* %13 to [32 x [32 x float]]*
  %14 = bitcast float* %b_g to [32 x float]*
  %b_g_copy = alloca [32 x float], align 512
  %15 = bitcast [32 x float]* %W_o to [32 x [32 x float]]*
  %16 = call i8* @malloc(i64 4096)
  %W_o_copy = bitcast i8* %16 to [32 x [32 x float]]*
  %17 = bitcast [32 x float]* %U_o to [32 x [32 x float]]*
  %18 = call i8* @malloc(i64 4096)
  %U_o_copy = bitcast i8* %18 to [32 x [32 x float]]*
  %19 = bitcast float* %b_o to [32 x float]*
  %b_o_copy = alloca [32 x float], align 512
  %20 = bitcast [32 x float]* %x to [8 x [32 x float]]*
  %x_copy = alloca [8 x [32 x float]], align 512
  %21 = bitcast float* %h to [32 x float]*
  %h_copy = alloca [32 x float], align 512
  %22 = bitcast float* %c to [32 x float]*
  %c_copy = alloca [32 x float], align 512
  call fastcc void @copy_in([32 x [32 x float]]* nonnull %0, [32 x [32 x float]]* %W_f_copy, [32 x [32 x float]]* nonnull %2, [32 x [32 x float]]* %U_f_copy, [32 x float]* nonnull %4, [32 x float]* nonnull align 512 %b_f_copy, [32 x [32 x float]]* nonnull %5, [32 x [32 x float]]* %W_i_copy, [32 x [32 x float]]* nonnull %7, [32 x [32 x float]]* %U_i_copy, [32 x float]* nonnull %9, [32 x float]* nonnull align 512 %b_i_copy, [32 x [32 x float]]* nonnull %10, [32 x [32 x float]]* %W_g_copy, [32 x [32 x float]]* nonnull %12, [32 x [32 x float]]* %U_g_copy, [32 x float]* nonnull %14, [32 x float]* nonnull align 512 %b_g_copy, [32 x [32 x float]]* nonnull %15, [32 x [32 x float]]* %W_o_copy, [32 x [32 x float]]* nonnull %17, [32 x [32 x float]]* %U_o_copy, [32 x float]* nonnull %19, [32 x float]* nonnull align 512 %b_o_copy, [8 x [32 x float]]* nonnull %20, [8 x [32 x float]]* nonnull align 512 %x_copy, [32 x float]* nonnull %21, [32 x float]* nonnull align 512 %h_copy, [32 x float]* nonnull %22, [32 x float]* nonnull align 512 %c_copy)
  call void @apatb_LSTM_hw([32 x [32 x float]]* %W_f_copy, [32 x [32 x float]]* %U_f_copy, [32 x float]* %b_f_copy, [32 x [32 x float]]* %W_i_copy, [32 x [32 x float]]* %U_i_copy, [32 x float]* %b_i_copy, [32 x [32 x float]]* %W_g_copy, [32 x [32 x float]]* %U_g_copy, [32 x float]* %b_g_copy, [32 x [32 x float]]* %W_o_copy, [32 x [32 x float]]* %U_o_copy, [32 x float]* %b_o_copy, [8 x [32 x float]]* %x_copy, [32 x float]* %h_copy, [32 x float]* %c_copy)
  call void @copy_back([32 x [32 x float]]* %0, [32 x [32 x float]]* %W_f_copy, [32 x [32 x float]]* %2, [32 x [32 x float]]* %U_f_copy, [32 x float]* %4, [32 x float]* %b_f_copy, [32 x [32 x float]]* %5, [32 x [32 x float]]* %W_i_copy, [32 x [32 x float]]* %7, [32 x [32 x float]]* %U_i_copy, [32 x float]* %9, [32 x float]* %b_i_copy, [32 x [32 x float]]* %10, [32 x [32 x float]]* %W_g_copy, [32 x [32 x float]]* %12, [32 x [32 x float]]* %U_g_copy, [32 x float]* %14, [32 x float]* %b_g_copy, [32 x [32 x float]]* %15, [32 x [32 x float]]* %W_o_copy, [32 x [32 x float]]* %17, [32 x [32 x float]]* %U_o_copy, [32 x float]* %19, [32 x float]* %b_o_copy, [8 x [32 x float]]* %20, [8 x [32 x float]]* %x_copy, [32 x float]* %21, [32 x float]* %h_copy, [32 x float]* %22, [32 x float]* %c_copy)
  tail call void @free(i8* %1)
  tail call void @free(i8* %3)
  tail call void @free(i8* %6)
  tail call void @free(i8* %8)
  tail call void @free(i8* %11)
  tail call void @free(i8* %13)
  tail call void @free(i8* %16)
  tail call void @free(i8* %18)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x float]* readonly, [32 x float]* align 512, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x float]* readonly, [32 x float]* align 512, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x float]* readonly, [32 x float]* align 512, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x float]* readonly, [32 x float]* align 512, [8 x [32 x float]]* readonly, [8 x [32 x float]]* align 512, [32 x float]* readonly, [32 x float]* align 512, [32 x float]* readonly, [32 x float]* align 512) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %1, [32 x [32 x float]]* %0)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %3, [32 x [32 x float]]* %2)
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* align 512 %5, [32 x float]* %4)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %7, [32 x [32 x float]]* %6)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %9, [32 x [32 x float]]* %8)
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* align 512 %11, [32 x float]* %10)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %13, [32 x [32 x float]]* %12)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %15, [32 x [32 x float]]* %14)
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* align 512 %17, [32 x float]* %16)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %19, [32 x [32 x float]]* %18)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %21, [32 x [32 x float]]* %20)
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* align 512 %23, [32 x float]* %22)
  call fastcc void @onebyonecpy_hls.p0a8a32f32([8 x [32 x float]]* align 512 %25, [8 x [32 x float]]* %24)
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* align 512 %27, [32 x float]* %26)
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* align 512 %29, [32 x float]* %28)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %dst, [32 x [32 x float]]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [32 x [32 x float]]* %dst, null
  %1 = icmp eq [32 x [32 x float]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a32a32f32([32 x [32 x float]]* nonnull %dst, [32 x [32 x float]]* nonnull %src, i64 32)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a32a32f32([32 x [32 x float]]* %dst, [32 x [32 x float]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [32 x [32 x float]]* %src, null
  %1 = icmp eq [32 x [32 x float]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [32 x [32 x float]], [32 x [32 x float]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [32 x [32 x float]], [32 x [32 x float]]* %src, i64 0, i64 %for.loop.idx2
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
define internal fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* align 512 %dst, [32 x float]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [32 x float]* %dst, null
  %1 = icmp eq [32 x float]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a32f32([32 x float]* nonnull %dst, [32 x float]* nonnull %src, i64 32)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a8a32f32([8 x [32 x float]]* align 512 %dst, [8 x [32 x float]]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [8 x [32 x float]]* %dst, null
  %1 = icmp eq [8 x [32 x float]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a8a32f32([8 x [32 x float]]* nonnull %dst, [8 x [32 x float]]* nonnull %src, i64 8)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a8a32f32([8 x [32 x float]]* %dst, [8 x [32 x float]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [8 x [32 x float]]* %src, null
  %1 = icmp eq [8 x [32 x float]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [8 x [32 x float]], [8 x [32 x float]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [8 x [32 x float]], [8 x [32 x float]]* %src, i64 0, i64 %for.loop.idx2
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
define internal fastcc void @copy_out([32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x float]*, [32 x float]* readonly align 512, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x float]*, [32 x float]* readonly align 512, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x float]*, [32 x float]* readonly align 512, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x float]*, [32 x float]* readonly align 512, [8 x [32 x float]]*, [8 x [32 x float]]* readonly align 512, [32 x float]*, [32 x float]* readonly align 512, [32 x float]*, [32 x float]* readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %0, [32 x [32 x float]]* %1)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %2, [32 x [32 x float]]* %3)
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* %4, [32 x float]* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %6, [32 x [32 x float]]* %7)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %8, [32 x [32 x float]]* %9)
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* %10, [32 x float]* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %12, [32 x [32 x float]]* %13)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %14, [32 x [32 x float]]* %15)
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* %16, [32 x float]* align 512 %17)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %18, [32 x [32 x float]]* %19)
  call fastcc void @onebyonecpy_hls.p0a32a32f32([32 x [32 x float]]* %20, [32 x [32 x float]]* %21)
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* %22, [32 x float]* align 512 %23)
  call fastcc void @onebyonecpy_hls.p0a8a32f32([8 x [32 x float]]* %24, [8 x [32 x float]]* align 512 %25)
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* %26, [32 x float]* align 512 %27)
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* %28, [32 x float]* align 512 %29)
  ret void
}

declare i8* @malloc(i64) local_unnamed_addr

declare void @free(i8*) local_unnamed_addr

declare void @apatb_LSTM_hw([32 x [32 x float]]*, [32 x [32 x float]]*, [32 x float]*, [32 x [32 x float]]*, [32 x [32 x float]]*, [32 x float]*, [32 x [32 x float]]*, [32 x [32 x float]]*, [32 x float]*, [32 x [32 x float]]*, [32 x [32 x float]]*, [32 x float]*, [8 x [32 x float]]*, [32 x float]*, [32 x float]*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x float]*, [32 x float]* readonly align 512, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x float]*, [32 x float]* readonly align 512, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x float]*, [32 x float]* readonly align 512, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x [32 x float]]*, [32 x [32 x float]]* readonly, [32 x float]*, [32 x float]* readonly align 512, [8 x [32 x float]]*, [8 x [32 x float]]* readonly align 512, [32 x float]*, [32 x float]* readonly align 512, [32 x float]*, [32 x float]* readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* %26, [32 x float]* align 512 %27)
  call fastcc void @onebyonecpy_hls.p0a32f32([32 x float]* %28, [32 x float]* align 512 %29)
  ret void
}

declare void @LSTM_hw_stub([32 x float]* noalias nocapture nonnull readonly, [32 x float]* noalias nocapture nonnull readonly, float* noalias nocapture nonnull readonly, [32 x float]* noalias nocapture nonnull readonly, [32 x float]* noalias nocapture nonnull readonly, float* noalias nocapture nonnull readonly, [32 x float]* noalias nocapture nonnull readonly, [32 x float]* noalias nocapture nonnull readonly, float* noalias nocapture nonnull readonly, [32 x float]* noalias nocapture nonnull readonly, [32 x float]* noalias nocapture nonnull readonly, float* noalias nocapture nonnull readonly, [32 x float]* noalias nocapture nonnull readonly, float* noalias nocapture nonnull, float* noalias nocapture nonnull)

define void @LSTM_hw_stub_wrapper([32 x [32 x float]]*, [32 x [32 x float]]*, [32 x float]*, [32 x [32 x float]]*, [32 x [32 x float]]*, [32 x float]*, [32 x [32 x float]]*, [32 x [32 x float]]*, [32 x float]*, [32 x [32 x float]]*, [32 x [32 x float]]*, [32 x float]*, [8 x [32 x float]]*, [32 x float]*, [32 x float]*) #5 {
entry:
  call void @copy_out([32 x [32 x float]]* null, [32 x [32 x float]]* %0, [32 x [32 x float]]* null, [32 x [32 x float]]* %1, [32 x float]* null, [32 x float]* %2, [32 x [32 x float]]* null, [32 x [32 x float]]* %3, [32 x [32 x float]]* null, [32 x [32 x float]]* %4, [32 x float]* null, [32 x float]* %5, [32 x [32 x float]]* null, [32 x [32 x float]]* %6, [32 x [32 x float]]* null, [32 x [32 x float]]* %7, [32 x float]* null, [32 x float]* %8, [32 x [32 x float]]* null, [32 x [32 x float]]* %9, [32 x [32 x float]]* null, [32 x [32 x float]]* %10, [32 x float]* null, [32 x float]* %11, [8 x [32 x float]]* null, [8 x [32 x float]]* %12, [32 x float]* null, [32 x float]* %13, [32 x float]* null, [32 x float]* %14)
  %15 = bitcast [32 x [32 x float]]* %0 to [32 x float]*
  %16 = bitcast [32 x [32 x float]]* %1 to [32 x float]*
  %17 = bitcast [32 x float]* %2 to float*
  %18 = bitcast [32 x [32 x float]]* %3 to [32 x float]*
  %19 = bitcast [32 x [32 x float]]* %4 to [32 x float]*
  %20 = bitcast [32 x float]* %5 to float*
  %21 = bitcast [32 x [32 x float]]* %6 to [32 x float]*
  %22 = bitcast [32 x [32 x float]]* %7 to [32 x float]*
  %23 = bitcast [32 x float]* %8 to float*
  %24 = bitcast [32 x [32 x float]]* %9 to [32 x float]*
  %25 = bitcast [32 x [32 x float]]* %10 to [32 x float]*
  %26 = bitcast [32 x float]* %11 to float*
  %27 = bitcast [8 x [32 x float]]* %12 to [32 x float]*
  %28 = bitcast [32 x float]* %13 to float*
  %29 = bitcast [32 x float]* %14 to float*
  call void @LSTM_hw_stub([32 x float]* %15, [32 x float]* %16, float* %17, [32 x float]* %18, [32 x float]* %19, float* %20, [32 x float]* %21, [32 x float]* %22, float* %23, [32 x float]* %24, [32 x float]* %25, float* %26, [32 x float]* %27, float* %28, float* %29)
  call void @copy_in([32 x [32 x float]]* null, [32 x [32 x float]]* %0, [32 x [32 x float]]* null, [32 x [32 x float]]* %1, [32 x float]* null, [32 x float]* %2, [32 x [32 x float]]* null, [32 x [32 x float]]* %3, [32 x [32 x float]]* null, [32 x [32 x float]]* %4, [32 x float]* null, [32 x float]* %5, [32 x [32 x float]]* null, [32 x [32 x float]]* %6, [32 x [32 x float]]* null, [32 x [32 x float]]* %7, [32 x float]* null, [32 x float]* %8, [32 x [32 x float]]* null, [32 x [32 x float]]* %9, [32 x [32 x float]]* null, [32 x [32 x float]]* %10, [32 x float]* null, [32 x float]* %11, [8 x [32 x float]]* null, [8 x [32 x float]]* %12, [32 x float]* null, [32 x float]* %13, [32 x float]* null, [32 x float]* %14)
  ret void
}

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
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
