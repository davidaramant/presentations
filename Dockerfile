FROM python:3.13 AS mdslides
ENV PRESENTATION not-set
WORKDIR /presentations
RUN python -m pip install git+https://gitlab.com/da_doomer/markdown-slides.git
ENTRYPOINT mdslides ${PRESENTATION}
