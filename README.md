# PwCHO_Z1


## Build manualny

```

DOCKER_BUILDKIT=1 docker build https://github.com/sz3jdii/PwCHO_Z1.git -t time-app:v0.0.1 --no-cache

```

## Docker hub

1) Utworzenie repozytorium na docker hub
2) Włączanie synchronizacji Docker Hub <-> Github, wybranie master jako źródłowego brancha oraz lokacji Dockerfile /
3) Włączenie automatycznego builda
4) Ustawienie zmiennej srodowiskowej w docker hubie  DOCKER_BUILDKIT na 1

## Lokalnie

1) docker pull sz3jdii/pwcho_z1
2) docker run --rm  -d -p 80:80  sz3jdii/pwcho_z1

