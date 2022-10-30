import os
import grpc
import exampleProto.test_pb2 as messages
import exampleProto.test_pb2_grpc as service

from google.protobuf import empty_pb2 as empty

channel = grpc.insecure_channel(os.environ['URL'])
message = empty.Empty()
stub = service.SaySomethingStub(channel)
answer = stub.Hello(message)
print(f'{result}')

