#osnovna slika je ubunut latest verzija
FROM ubuntu:latest

#posodobi oz instalira use pakete
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    make \
    && rm -rf /var/lib/apt/lists/*

# setta main mapo v kontejnerju
WORKDIR /app

# kopira trenunto vsebino v to mapo
COPY . /app

RUN make