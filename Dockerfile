FROM tensorflow/tensorflow:latest-gpu-py3
#FROM tensorflow/tensorflow:latest-py3-jupyter

RUN pip3 install --upgrade pip
RUN pip3 install Cython contextlib2 pillow lxml matplotlib protobuf jupyter

RUN apt-get -y update
RUN apt-get install -y git
RUN apt-get install -y protobuf-compiler

# Install OpenCV
RUN pip3 install opencv-python 
RUN apt-get install -y libsm6 libxrender-dev

# Install tensorflow models
RUN git clone https://github.com/tensorflow/models.git /tensorflow/models

# Install COCO API
#RUN git clone https://github.com/cocodataset/cocoapi.git
#RUN cd cocoapi/PythonAPI; make; cp -r pycocotools /tensorflow/models/research

WORKDIR /tensorflow/models/research

# Install Protoc
RUN protoc object_detection/protos/*.proto --python_out=.

RUN export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--allow-root", "--ip=0.0.0.0", "--no-browser", "--notebook-dir=/tensorflow/models/research/object_detection"]
