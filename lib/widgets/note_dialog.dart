import 'package:flutter/material.dart';
import 'package:hewr_note_app/widgets/dialoag_functions.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteDialog extends StatelessWidget {
  final String note;
  final String id;

  const NoteDialog({@required this.note, @required this.id});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 300,
        width: 400,
        decoration:
            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Note',
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
              // const Gap(20),
              Text(
                '$note',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    color: HexColor('55BCF6'),
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pop(context);
                      DialogFuncs.openEditDialogNote(context, id, note);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: HexColor('F65555'),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("notes")
                          .doc(id)
                          .delete()
                          .catchError((e) {
                        print(e);
                      });
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
