package main

import (
	"google.golang.org/grpc"
	"grpc-test/chat"
	"log"
	"net"
)

///Proto oluşturma komutları:
///protoc --go-grpc_out=../. chat.proto
///protoc --go_out=../. chat.proto

///protoc --dart_out=grpc:./dart/. ./proto/chat.proto
func main() {
	lis, err := net.Listen("tcp", ":9000")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	grpcServer := grpc.NewServer()
	chat.RegisterChatServiceServer(grpcServer, &chat.Server{})
	if err := grpcServer.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %s", err)
	}
}