import 'package:book_keeper/scanner/scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _message = "";
  List<SmsConversation> _conversations = [];
  List<SmsMessage> _messages = [];
  final telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  onMessage(SmsMessage message) async {
    setState(() {
      _message = message.body ?? "Error reading message body.";
      fetchConversations();
      fetchMessages(message.threadId ?? -1);
      if (kDebugMode) {
        print(_messages);
      }
    });
  }

  fetchConversations() async {
    telephony.getConversations().then((value) {
      setState(() {
        _conversations = value;
      });
    });
  }

  fetchMessages(int threadId) async {
    telephony.getInboxSms().then((value) {
      setState(() {
        _messages = value;
      });
    });
  }

  Future<void> initPlatformState() async {
    final bool? result = await telephony.requestSmsPermissions;

    if (result != null && result) {
      telephony.listenIncomingSms(
          onNewMessage: onMessage, listenInBackground: false);
      telephony.getConversations().then((value) {
        setState(() {
          _conversations = value;
        });
      });
      telephony.getInboxSms().then((value) {
        setState(() {
          _messages = value;
        });
      });
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Latest received SMS: $_message")),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: _conversations.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text((_conversations[index].threadId).toString()),
          //         subtitle: Text((_conversations[index].snippet).toString()),
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text((_messages[index].address).toString()),
                  subtitle: Text((_messages[index].body).toString()),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BarcodeScanner(),
                ),
              );
            },
            child: const Text('Scanner'),
          ),
        ],
      ),
    ));
  }
}
