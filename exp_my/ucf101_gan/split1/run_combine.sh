# Copyright (c) Facebook, Inc. and its affiliates.
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

#! /bin/bash

# ./exp/ucf101_gan/split1/run_combine.sh 2>&1 | tee ./exp/ucf101_gan/split1/acc.log

expdir=ucf101_gan/split1
representation=mv

python combine.py \
  --iframe exp/ucf101_coviar/ucf101_iframe/split1/iframe_score_model_best.npz \
  --res exp/ucf101_coviar/ucf101_residual/split1/residual_score_model_best.npz \
  --mv exp/ucf101_coviar/ucf101_mv/split1/mv_score_model_best.npz \
  --flow exp/${expdir}/mv_score_model_best.npz