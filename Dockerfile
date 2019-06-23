FROM tensorflow/tensorflow:latest-py3-jupyter

RUN pip3 install --upgrade pip
RUN pip3 install Cython
RUN pip3 install contextlib2
RUN pip3 install pillow
RUN pip3 install lxml
RUN pip3 install matplotlib

EXPOSE 8888
WORKDIR /app
ENTRYPOINT ["jupyter", "notebook", "--allow-root", "--ip=0.0.0.0", "--no-browser"]
