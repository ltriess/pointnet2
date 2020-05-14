### PointNet++: *Deep Hierarchical Feature Learning on Point Sets in a Metric Space*
Created by <a href="http://charlesrqi.com" target="_blank">Charles R. Qi</a>, <a href="http://stanford.edu/~ericyi">Li (Eric) Yi</a>, <a href="http://ai.stanford.edu/~haosu/" target="_blank">Hao Su</a>, <a href="http://geometry.stanford.edu/member/guibas/" target="_blank">Leonidas J. Guibas</a> from Stanford University.

Modified by [Larissa Triess](https://github.com/ltriess).
Please find the original code and instructions [here](https://github.com/charlesq34/pointnet2).

![prediction example](doc/teaser.jpg)

### Installation

The code is tested under `TF1.15` GPU version and Python 3.6 on Ubuntu 18.04.
Make sure to use `cuda 10.0` and `libcudnn 7.6.0` to run TensorFlow GPU properly.

#### Compile Customized TF Operators
The TF operators are included under `tf_ops`.
You need to compile them (check `tf_xxx_compile.sh` under each ops subfolder) first.

```shell script
# Enter your virtualenv first to the get the correct TensorFlow.
source /path/to/venv/bin/activate

TF_CFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))') )
TF_LFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))') )

# Check that you use the desired path to TensorFlow before proceeding.
# Should look something like this if you use a virtualenv.
# TF_CFLAGS: -I/path/to/venv/lib/python3.6/site-packages/tensorflow_core/include -D_GLIBCXX_USE_CXX11_ABI=0
# TF_LFLAGS: -L/path/to/venv/lib/python3.6/site-packages/tensorflow_core -l:libtensorflow_framework.so.1

/usr/local/cuda/bin/nvcc -std=c++11 -c -o tf_sampling_g.cu.o tf_sampling_g.cu ${TF_CFLAGS[@]} -D GOOGLE_CUDA=1 -x cu -Xcompiler -fPIC
g++ -std=c++11 -shared -o tf_sampling_so.so tf_sampling.cpp tf_sampling_g.cu.o ${TF_CFLAGS[@]} -fPIC -lcudart ${TF_LFLAGS[@]} -I/usr/local/cuda/include -L/usr/local/cuda/lib64
```

### Modifications
Find the original code [here](https://github.com/charlesq34/pointnet2).
* adapt code to be used with Python 3
* refactoring of the code for unified coding style
* add pre-commit config for coding style
* update compile scripts for newer TensorFlow versions
* shorten [README.md](README.md) to only show changes
