// import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import '../widgets/dialoag_functions.dart';
import 'package:gap/gap.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('E8EAED'),
        body: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notes',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
                        ),
                        const Gap(30),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.40,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('notes').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.docs.length == 0) {
                                  return Text(
                                    "We don't have any notes",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto'),
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      final docData = snapshot.data.docs[i].data();
                                      final note = docData['note'];
                                      final id = snapshot.data.docs[i].id;
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              DialogFuncs.openDialiagNote(context, id, note);
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.90,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                elevation: 2,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                    note,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      height: 1.5,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Gap(20)
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                return Container(width: 0.0, height: 0.0);
                              }
                            },
                          ),
                        )
                        // const Gap(30),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 55,
                      width: 310,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(500),
                        ),
                      ),
                      child: TextField(
                        autofocus: false,
                        controller: textController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write a note',
                          hintStyle: TextStyle(
                            color: HexColor('C0C0C0'),
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: HexColor('C0C0C0'),
                      ),
                      onPressed: () {
                        DialogFuncs.openCreateDialoagNote(context, textController.text);
                        textController.clear();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
