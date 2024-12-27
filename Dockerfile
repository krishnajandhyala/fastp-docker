FROM ubuntu:22.04

RUN apt update && apt install -y git cmake autoconf automake libtool help2man nasm yasm zlib1g-dev build-essential libpthread-stubs0-dev make

RUN git clone https://github.com/intel/isa-l.git
WORKDIR /isa-l
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

WORKDIR /

RUN git clone https://github.com/ebiggers/libdeflate.git
WORKDIR /libdeflate
RUN cmake -B build && cmake --build build
WORKDIR /libdeflate/build
RUN make
RUN make install

WORKDIR /

RUN git clone https://github.com/OpenGene/fastp.git
WORKDIR /fastp
RUN make
RUN make install