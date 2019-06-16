FROM tensorflow/tensorflow:latest-py3-jupyter

EXPOSE 8888
WORKDIR /app
ENTRYPOINT ["jupyter", "notebook", "--allow-root", "--ip=0.0.0.0", "--no-browser"]
