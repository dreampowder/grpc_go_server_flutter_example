import 'package:flutter/material.dart';
import 'package:flutter_grpc/grpc/chat.pb.dart';
import 'package:flutter_grpc/grpc/chat.pbgrpc.dart';
import 'package:grpc/grpc.dart' as grpc;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late final grpc.ClientChannel channel;
  late final ChatServiceClient chatClient;

  final TextEditingController _teChat = TextEditingController();
  final TextEditingController _teResponse = TextEditingController();

  @override
  void initState() {
    super.initState();
    initClient();
  }

  void initClient(){
    channel =  grpc.ClientChannel(
      "localhost",
      port: 9000,
      options: const grpc.ChannelOptions(credentials: grpc.ChannelCredentials.insecure())
    );

    chatClient =  ChatServiceClient(channel);
  }

  void sendMessage(String text){
    chatClient.sayHello(Message(body: text))
        .then((response){
        _teResponse.text = "${_teResponse.text}\n${response.body}";
        _teChat.clear();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                controller: _teChat,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Message To Send",
                ),
                onSubmitted: sendMessage,
              ),
              const SizedBox(height: 16,),
              Expanded(
                child: TextField(
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Response",
                  ),
                  textAlignVertical: TextAlignVertical.top,
                  controller: _teResponse,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
