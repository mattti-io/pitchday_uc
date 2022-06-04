import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:pitchday/resources/socket_client.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../provider/room_data_provider.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance?.socket!;

  //EMITS
  void createRoom(String nickname, String title) {
    if (nickname.isNotEmpty) {
      _socketClient?.emit('createRoom', {'nickname': nickname, 'title': title});
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient?.emit('joinRoom', {'nickname': nickname, 'roomId': roomId});
    }
  }

  //LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    _socketClient?.on('createRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameRoom.routeName, arguments: room);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient?.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameRoom.routeName, arguments: room);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient?.on("errorOccured", (data) {
      window.alert(data);
    });
  }
}
