##GRPC - Dart Example Project

For running the server:

```go

go get

go mod tidy

go run main.go
```

Protobuf and grpc server files are already generated. 
But in order to generate again: 

###Go server files generation:
```shell
protoc --go-grpc_out=../. ./proto/chat.proto
```

###Dart Client files generation:
```shell
protoc --dart_out=grpc:./dart/. ./proto/chat.proto
```

