This , is my first Dockerfile and docker-compose.yml files
My apt-proxy with apt-cacher-ng is created from debian:stable docker.
He listen on 3142 port, and interface 0.0.0.0 , ipv4 only.

Usage:
 mkdir apt-proxy
 cd apt-proxy
 [ cpy all files for repository]
 sudo groupadd -g 117 apt-cacher-ng
 sudo useradd -u 117  -g 117  -s "/bin/false" -d "/var/cache/apt-cacher-ng" apt-cacher-ng
 mkdir /var/cache/apt-cacher-ng
 mkdir /var/log/apt-cacher-ng
 docker build -t apt-proxy .
 docker compose up

In my home, this work!

/* -------------------------------------------- */
In french:
Ceci sont mes premiers fichiers Dockerfile et docker-compose.yml.
Mon apt-proxy avec apt-cacher-ng est créé à partir du docker debian:stable 
Il  écoute sur le port 3142, sur l'interfaces 0.0.0.0, ipv4 seulement. 

Usage:
 mkdir apt-proxy
 cd apt-proxy
 [ cpy all files for repository]
 sudo groupadd -g 117 apt-cacher-ng
 sudo useradd -u 117  -g 117  -s "/bin/false" -d "/var/cache/apt-cacher-ng" apt-cacher-ng
 mkdir /var/cache/apt-cacher-ng
 mkdir /var/log/apt-cacher-ng
 docker build -t apt-proxy .
 docker compose up

Chez moi, cela fonctionne!


