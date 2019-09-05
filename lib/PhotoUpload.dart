import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kruuz_flutter/HomePage.dart';
import 'package:kruuz_flutter/authentication_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPhotoPage extends StatefulWidget {
  final String loadID;
  final String shipper;
  final String trucker;
  final String process;
  UploadPhotoPage({this.loadID, this.shipper, this.trucker, this.process});
  State<StatefulWidget> createState() {
    return _UploadPhotoPageState();
  }
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File sampleImage;
  final formKey = new GlobalKey<FormState>();
  String url;
  String _myValue;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  _switchTitle() {
    if (widget.process == 'In progress') {
      return Text('Upload Bill of Lading');
    } else if (widget.process == 'Complete') ;
    {
      return Text('Upload Proof of Completion');
    }
  }

  _updateLoad() async {
    await Firestore.instance.runTransaction(
      (Transaction tx) async {
        DocumentSnapshot postSnapshot = await tx.get(
            Firestore.instance.collection('Load').document('${widget.loadID}'));
        print('${postSnapshot}');
        if (postSnapshot.exists) {
          await tx.update(
              Firestore.instance
                  .collection('Load')
                  .document('${widget.loadID}'),
              <String, dynamic>{
                'process': 'Complete',
              });
        }
      },
    );
  }

  _closeLoad() async {
    // create a DELETE ROUTE EVENTUALLY
    await Firestore.instance.runTransaction(
      (Transaction tx) async {
        DocumentSnapshot postSnapshot = await tx.get(
            Firestore.instance.collection('Load').document('${widget.loadID}'));
        print('${postSnapshot}');
        if (postSnapshot.exists) {
          await tx.update(
              Firestore.instance
                  .collection('Load')
                  .document('${widget.loadID}'),
              <String, dynamic>{
                'process': 'Closed',
                'status': '${postSnapshot['trucker']}',
                'trucker': 'Closed'
              });
        }
      },
    );
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      if (widget.process == 'In progress') {
        print('HERE');
        final StorageReference postImageRef =
            FirebaseStorage.instance.ref().child("ImageBillLading");
        var timeKey = new DateTime.now();
        final StorageUploadTask uploadTask = postImageRef
            .child(timeKey.toString() + ".jpg")
            .putFile(sampleImage);
        var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
        url = ImageUrl.toString();
        print("Image Url= " + url);

        saveToDatabase(url);
      } else if (widget.process == 'Complete') {
        final StorageReference postImageRef =
            FirebaseStorage.instance.ref().child("ImageProofComplete");
        var timeKey = new DateTime.now();
        final StorageUploadTask uploadTask = postImageRef
            .child(timeKey.toString() + ".jpg")
            .putFile(sampleImage);
        var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
        url = ImageUrl.toString();
        print("Image Url= " + url);

        saveToDatabase(url);
      }
    }
  }

  void saveToDatabase(url) {
    print('here');
    print(widget.process);
    DocumentReference load =
        Firestore.instance.collection('Load').document(widget.loadID);
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    if (widget.process == 'In progress') {
      DocumentReference ds =
          Firestore.instance.collection('BillOfLading').document();
      Map<String, dynamic> imageDetails = {
        "image": url,
        "description": _myValue,
        "loadID": widget.loadID,
        "shipper": widget.shipper,
        "trucker": widget.trucker,
        "date": date,
        "time": time,
      };
      ds.setData(imageDetails).then((onvalue) {
        _updateLoad();
      }).then(
        (onvalue) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      ).catchError((onError) {
        print(onError);
      });
    } else if (widget.process == 'Complete') {
      DocumentReference ds =
          Firestore.instance.collection('ProofOfCompletion').document();
      Map<String, dynamic> imageDetails = {
        "image": url,
        "description": _myValue,
        "loadID": widget.loadID,
        "shipper": widget.shipper,
        "trucker": widget.trucker,
        "date": date,
        "time": time,
      };
      ds.setData(imageDetails).then((onValue) {
        _closeLoad();
      }).then(
        (onvalue) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      ).catchError((onError) {
        print(onError);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: _switchTitle(),
        centerTitle: true,
      ),
      body: new Center(
          child:
              sampleImage == null ? Text("Select an Image") : enableUpload()),
      floatingActionButton: new FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Add Image',
          child: new Icon(Icons.add_a_photo)),
    );
  }

  Widget enableUpload() {
    return new SingleChildScrollView(
        child: new Container(
      child: new Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Image.file(sampleImage, height: 330.0, width: 600.0),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              decoration: new InputDecoration(labelText: 'Description'),
              validator: (value) {
                return value.isEmpty ? 'Description is required' : null;
              },
              onSaved: (value) {
                return _myValue = value;
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              elevation: 10.0,
              child: Text("Upload Relevant Documents"),
              textColor: Colors.white,
              color: Color.fromRGBO(242, 152, 54, 1),
              onPressed: validateAndSave,
            ),
          ],
        ),
      ),
    ));
  }
}
