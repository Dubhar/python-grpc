# since all stages of this multistage image use the same base image, define that base image just once
FROM alpine:3.16 as root-img

# also install common software
RUN apk --no-cache add python3 py3-pip
RUN pip3 install grpcio-tools


# 1st stage of multistage image: *.proto ➜ *.py
FROM root-img

# get protos
RUN apk --no-cache add git
WORKDIR /protos
ARG REPOS
RUN for repo in $REPOS; do \
  git clone $repo; \
  done

# compile protos
WORKDIR /pyProtos
RUN python3 -m grpc_tools.protoc --proto_path=/protos --python_out=/pyProtos --grpc_python_out=/pyProtos $(find /protos -name \*.proto -type f | tr '\n' ' ')


# 2nd stage of multistage image: run the code using generated files
FROM root-img

COPY --from=1 /pyProtos /app
COPY ./entrypoint.py /app/entrypoint.py
WORKDIR /app
ENTRYPOINT ["python3", "entrypoint.py"]
