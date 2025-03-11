FROM python:3.13 AS mkslides
WORKDIR /presentations
RUN pip install mkslides
ENTRYPOINT mkslides build docs 