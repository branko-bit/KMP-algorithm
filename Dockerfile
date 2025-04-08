# Uporabi uradno sliko Ubuntu kot osnovno sliko
FROM ubuntu:latest

# Posodobi paketni seznam in namesti potrebne pakete
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    make \
    && rm -rf /var/lib/apt/lists/*

# Nastavi delovno mapo v zabojniku
WORKDIR /app

# Kopiraj trenutno mapo vsebine v zabojnik na /app
COPY . /app

# Zaženi Makefile za kompilacijo programa
RUN make

# Določi ukaz za zagon programa ob zagonu zabojnika
CMD ["./program"]