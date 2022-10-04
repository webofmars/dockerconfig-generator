# dockerconfig generator

Tool to format github config that can be used in you docker config files or in a kubernetes secret

## usage cleartext

```sh
pip install -r requirements.txt
python ./generator.py --registry index.docker.io --username foo --password bar
```

## usage with base64 encoding

```sh
pip install -r requirements.txt
python ./generator.py --registry index.docker.io --username foo --password bar --base64
```

## or with docker

```sh
docker run --rm -it webofmars/dockerconfig-generator:latest --registry index.docker.io --username foo --password bar --base64
```

## use it with kubernetes

```sh
docker run --rm -it webofmars/dockerconfig-generator:latest --registry index.docker.io --username foo --password bar \
  | kubectl create secret generic toto -o yaml --dry-run=client --from-file .dockerconfigjson=/dev/stdin
```
