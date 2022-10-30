import os
import grpc
import exampleProto.test_pb2 as messages
import exampleProto.test_pb2_grpc as service

from google.protobuf import empty_pb2 as empty

url = "host.docker.internal:6565"
if 'URL' in os.environ:
  url = os.environ['URL']
channel = grpc.insecure_channel(url)
message = empty.Empty()
stub = service.SaySomethingStub(channel)
answer = stub.Hello(message)
print(f'{result}')

