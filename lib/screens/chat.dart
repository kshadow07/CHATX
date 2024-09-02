import 'dart:async';

import 'package:chtx/services/auth/authservice.dart';
import 'package:chtx/services/chat/chatservice.dart';
import 'package:chtx/widgets/chat_bubble.dart';
import 'package:chtx/widgets/text_FILED.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ChatPage extends StatefulWidget {
  static String id = 'chatpage';
  final String receviersemail;
  final String receviersid;
  final String username;

  const ChatPage(
      {super.key,
      required this.receviersemail,
      required this.receviersid,
      required this.username});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

final ChatService _chatService = ChatService();

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Authservice _authservice = Authservice();
  final FocusNode myfocusnode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // add listener to the focusnode
    getConnectivity();
    myfocusnode.addListener(() {
      if (myfocusnode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });
    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlert = false;
  void getConnectivity() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlert == false) {
          showDialogBox();
          setState(() {
            isAlert = true;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    myfocusnode.dispose();
    _messageController.dispose();
    subscription.cancel();
    super.dispose();
  }

  Future<void> scrollDown() async {
    try {
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.username.toString().trim(),
          style: (TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w300)),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessagelist()),
          // user input
          _builduserinput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessagelist() {
    String? senderId = _authservice.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderId, widget.receviersid),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            value: 0.62,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ));
        } else {
          return ListView(
            shrinkWrap: true,
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => buildMessageItem(doc))
                .toList(),
          );
        }
        //listview
      },
    );
  }

  void sendmessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receviersid, _messageController.text);
      _messageController.clear();
    }
    await scrollDown();
  }

  //build meesage item
  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser =
        data['senderEmail'] == _authservice.getCurrentUser()!.email;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            isCurrentUser: isCurrentUser,
            message: data['message'],
          )
        ],
      ),
    );
  }

  //build user input
  Widget _builduserinput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: scrollDown,
            child: InputBox(
              // suffixicon: IconButton(
              //   focusNode: myfocusnode,
              //   onPressed: () async {
              //     // pick image from gallery
              //     ImagePicker imagePicker = ImagePicker();
              //     XFile? image =
              //         await imagePicker.pickImage(source: ImageSource.gallery);
              //     if (image == null) return;
              //     Reference storage = FirebaseStorage.instance.ref();
              //     Reference imagestorage = storage.child('images');
              //     Reference finalimage = imagestorage
              //         .child(DateTime.now().millisecondsSinceEpoch.toString());
              //     try {
              //       await finalimage.putFile(File(image!.path));
              //       imageUrl = await finalimage.getDownloadURL();
              //     } catch (e) {
              //       print(e);
              //     }
              //   },
              //   icon: Icon(Icons.camera_alt),
              // ),
              suffixicon: null,
              icon: null,
              ontap: scrollDown,
              focusNode: myfocusnode,
              hintstring: 'Message',
              controller: _messageController,
              obsuretext: false,
              keybordtype: TextInputType.multiline,
            ),
          ),
        ),
        GestureDetector(
          onTap: sendmessage,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                  color: Colors.green, shape: BoxShape.circle),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }

  showDialogBox() => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Colors.grey,
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          contentPadding: EdgeInsets.all(10),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, "Cancel");
                setState(() => isAlert = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() => isAlert = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
