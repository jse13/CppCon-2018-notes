FROM ubuntu:latest

ARG target_path=/code/helloworld/

RUN apt-get update && apt-get install -y g++

WORKDIR /code

COPY code .

WORKDIR $target_path

CMD [ "./build.sh" ]