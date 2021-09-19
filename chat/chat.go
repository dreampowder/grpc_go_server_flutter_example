package chat

import (
	context "context"
	"log"
)

type Server struct {}

func (s Server) SayHello(ctx context.Context, message *Message) (*Message, error) {
	log.Println("Receive Message from client: %s",message.Body)
	return &Message{Body: "Hello there!"},nil
}

func (s Server) mustEmbedUnimplementedChatServiceServer() {
	panic("implement me")
}
