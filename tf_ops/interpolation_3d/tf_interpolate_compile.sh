#!/bin/bash
# tested with TF1.15 and cuda-10.0 (/usr/local/cuda --> /usr/local/cuda-10.0)
# make sure to source the correct python virtualenv first, otherwise no or the wrong tensorflow will be found
TF_CFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))') )
TF_LFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))') )

# TF_CFLAGS: -I/path/to/venv/lib/python3.6/site-packages/tensorflow_core/include -D_GLIBCXX_USE_CXX11_ABI=0
# TF_LFLAGS: -L/path/to/venv/lib/python3.6/site-packages/tensorflow_core -l:libtensorflow_framework.so.1

g++ -std=c++11 -shared tf_interpolate.cpp -o tf_interpolate_so.so ${TF_CFLAGS[@]} -fPIC -lcudart ${TF_LFLAGS[@]} -L/usr/local/cuda/lib64
