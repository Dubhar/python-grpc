```sh
cd .
docker build --build-arg REPOS="https://github.com/Dubhar/example-proto.git" --tag pyproto:1.0.0 .

docker run -e URL=192.168.178.69:6666 pyproto:1.0.0
```

If you have your proto files spread across more than one repo, list them space separated as `REPOS="repo1 repo2 ..."`

