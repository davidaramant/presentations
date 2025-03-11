# Presentations

**WIP**

Contains Markdown slideshows in the Python [mkslides](https://pypi.org/project/mkslides/) package format.

Based on what was done by [HoGenTIN](https://github.com/HoGentTIN/hogent-markdown-slides).

Includes Docker infrastructure to render the slides without having to mess with python stuff

## Usage

* Dump slideshows in `mkslides` format into `presentations/docs`
* Run `generate.sh`. This will:
  1) Create a Docker image with `mkslides`
  2) Run the tool
  3) Generate output in `presentations/site` (this is ignored from git; maybe it shouldn't be? dunno yet)
