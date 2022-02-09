import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("chat").snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final chatDocs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: chatDocs.length, // itemBuilder에서 보여줄 갯수
          itemBuilder: (context, index) { // 리스트에 그려질 항목을 Lazy하게 child을 생성해준다.
            return Text(chatDocs[index]['text']);
          },
        );
      },
    );
  }
}
