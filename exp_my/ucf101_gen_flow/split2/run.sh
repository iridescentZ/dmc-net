# Copyright (c) Facebook, Inc. and its affiliates.
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

#! /bin/bash

expdir=ucf101_gen_flow/split2
representation=mv

# exp/ucf101_gen_flow/split2/run.sh; ./exp/ucf101_gen_flow/split2/run_combine.sh 2>&1 | tee ./exp/ucf101_gen_flow/split2/acc.log

python train.py \
	--lr 0.01 \
	--batch-size 45 \
	--arch resnet18 \
	--arch_estimator DenseNetTiny \
	--data-name ucf101 \
	--representation ${representation} \
	--data-root /projects/eventnet/dataset/UCF101/fb/mpeg4_videos \
 	--flow-root /projects/eventnet/dataset/UCF101/fb/TSN_input \
	--train-list /projects/LSDE/work03/FB/data_preprocess/datalists/ucf101_split2_train.txt \
	--test-list /projects/LSDE/work03/FB/data_preprocess/datalists/ucf101_split2_test.txt \
	--weights ./exp/ucf101_coviar/ucf101_flow/split2/_flow_model_best.pth.tar \
	--model-prefix exp/${expdir}/ \
	--lr-steps 20 35 45 \
	--lr-mse 10 \
	--lr_mse_mult 1 \
	--use_databn 0 \
	--epochs 50 \
	--epoch-thre 1 \
	--flow_ds_factor 16 \
	--gen_flow_or_delta 1 \
	--no-accumulation \
	--mv_minmaxnorm 1 \
	--gpus 0 2>&1 | tee exp/${expdir}/train.log

python test.py \
	--arch resnet18 \
	--arch_estimator DenseNetTiny \
	--data-name ucf101 \
	--representation mv \
	--test-crops 1 \
	--test_segments 25 \
	--data-root /projects/eventnet/dataset/UCF101/fb/mpeg4_videos \
 	--flow-root /projects/eventnet/dataset/UCF101/fb/TSN_input \
	--test-list /projects/LSDE/work03/FB/data_preprocess/datalists/ucf101_split2_test.txt \
	--weights exp/${expdir}/_${representation}_model_best.pth.tar \
	--use_databn 0 \
	--flow_ds_factor 16 \
	--gen_flow_or_delta 1 \
	--no-accumulation \
	--mv_minmaxnorm 1 \
	--save-scores exp/${expdir}/${representation}_score_model_best \
	--gpus 0 2>&1 | tee exp/${expdir}/test.log