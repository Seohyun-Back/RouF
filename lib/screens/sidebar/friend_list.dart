import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:RouF/config/palette.dart';
import 'package:RouF/globals.dart' as globals;

class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // AppBar 사이즈 지정
        child: AppBar(
          backgroundColor: Colors.white, // AppBar 색상 지정
          title: Text('친구 목록', style: TextStyle(color: Colors.black)),

          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),

          iconTheme: IconThemeData(color: Color.fromARGB(255, 32, 32, 32)),
          elevation: 0.0,

          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user/${globals.currentUid}/friends')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final docs = snapshot.data!.docs;

                    return Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                                child: Text('친구 ${docs.length}',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500)),
                              ),
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: docs.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      //padding:,
                                      child: ListTile(
                                    // 친구 프로필사진
                                    leading: CircleAvatar(
                                      radius: 18,
                                      backgroundImage: AssetImage(
                                          'assets/images/profile.jpg'),
                                    ),
                                    // 친구 이름

                                    title: Text(docs[index]['name']),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                          child: Text(
                                            '삭제',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                          onPressed: () async {
                                            print("친구 삭제");
                                            // 목록에서 해당 data 사라지게
                                            FirebaseFirestore.instance
                                                .collection(
                                                    'user/${globals.currentUid}/friends')
                                                .doc(docs[index]['email'])
                                                .delete();

                                            globals.friendEmail =
                                                docs[index]['email']; //2 email
                                            globals.friendUid =
                                                docs[index]['uid'];

                                            FirebaseFirestore.instance
                                                .collection(
                                                    'user/${globals.friendUid}/friends')
                                                .doc(globals.currentEmail)
                                                .delete();

                                            globals.friendEmail = '';
                                            globals.friendUid = '';
                                          },
                                        ),
                                      ],
                                    ),
                                  ));
                                },
                              ),
                            ],
                          ),
                        ));
                  },
                )
              ],
            )),
      ),
    );
  }
}
