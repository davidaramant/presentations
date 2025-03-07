FROM python:3.13 AS leo
ARG PRESENTATION
RUN python -m pip install git+https://gitlab.com/da_doomer/markdown-slides.git
ENTRYPOINT ["mdslides", "./presentations/${PRESENTATION}", "--include", "media"]
