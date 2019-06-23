FROM tensorflow/tensorflow:latest-py3-jupyter

RUN pip3 install --upgrade pip
RUN pip3 install Cython
RUN pip3 install contextlib2
RUN pip3 install pillow
RUN pip3 install lxml
RUN pip3 install matplotlib
RUN pip3 install protobuf

RUN apt-get install -y git protobuf-compiler

RUN git clone https://github.com/tensorflow/models.git /tensorflow/models

#WORKDIR /app
WORKDIR /tensorflow/models/research

RUN protoc object_detection/protos/*.proto --python_out=.

RUN export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--allow-root", "--ip=0.0.0.0", "--no-browser", "--notebook-dir=/tensorflow/models/research/object_detection"]
