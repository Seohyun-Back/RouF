import 'package:flutter/material.dart';

class NoFriend extends StatelessWidget {
  const NoFriend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Text('친구를 추가하고 실시간으로 친구들과 일상을 공유해보세요!',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w200)),
      ),
    );
  }
}
