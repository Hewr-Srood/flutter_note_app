import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditNoteDialog extends StatelessWidget {
  final String note;
  final String id;

  const EditNoteDialog({Key key, @required this.note, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController(text: note);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 1,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 300,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Edit Note',
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
              TextField(
                autofocus: false,
                controller: textController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Edit your note',
                  hintStyle: TextStyle(
                    color: HexColor('C0C0C0'),
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    color: HexColor('55BCF6'),
                    icon: Icon(Icons.done),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("notes")
                          .doc(id)
                          .update({'note': textController.text});
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
