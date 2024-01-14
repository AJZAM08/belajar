import 'dart:io';
import 'package:firebase_app/components/constant.dart';
import 'package:firebase_app/components/custom_button.dart';
import 'package:firebase_app/components/text_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_icons/line_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _HomePageState();
}

class _HomePageState extends State<ProfilePage> {
  final valueController = TextEditingController();

  //user saat ini
  final currentUser = FirebaseAuth.instance.currentUser!;

  //all users
  final userCollection = FirebaseFirestore.instance.collection("Users");

  //variabel upload file
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? urlDownload;
  // String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  
  //upload file ke firebase storage
  Future uploadFile() async{
    final path = 'users/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    urlDownload = await ref.getDownloadURL();
    print(urlDownload);

    userCollection.doc(currentUser.email).update({'profileRef': urlDownload});
    

    setState(() {
      uploadTask = null;
    });

  }

  //upload file lokal
  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
      uploadFile();
    });
  }

  //edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Edit $field",
          style: TextStyle(color: primaryColor),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(
            color: primaryColor,
          ),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: GoogleFonts.montserrat(color: primaryColor),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          //cancel button
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(primaryColor),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: GoogleFonts.montserrat(
                  color: secondaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          //save button
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(primaryColor),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
            onPressed: () => Navigator.of(context).pop(newValue),
            child: Text(
              "Save",
              style: GoogleFonts.montserrat(
                  color: secondaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    //updating in firestore
    if (newValue.trim().isNotEmpty) {
      //only update if there is something inside
      await userCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  //log out
  Future logOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pop();
  }

  //pengaturan warna tema
  Color componentColor() {
    Color backgroundColor;
    var currentTheme = Theme.of(context);
    if (currentTheme.brightness == Brightness.dark) {
      backgroundColor = secondaryColor;
    } else {
      backgroundColor = primaryColor;
    }
    return backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: componentColor(),
            fontSize: 25
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(LineIcons.angleLeft),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          //get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                //profile pic
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    userData['profileRef'] != null
                      ? GestureDetector(
                        onTap: selectFile,
                        child: ClipOval(
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Image.network(
                              userData['profileRef'],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ) :
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: IconButton(
                          onPressed: selectFile,
                          icon: Icon(
                            LineIcons.retroCamera,
                            color: primaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                //user mail
                Text(
                  userData['Username'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: componentColor(), 
                    fontWeight: FontWeight.w600,
                    fontSize: 25
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                //user details
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    "My Details",
                    style: GoogleFonts.montserrat(
                        color: componentColor(), fontWeight: FontWeight.w600),
                  ),
                ),

                //username
                MyTextBox(
                  sectionName: "Username",
                  text: userData['Username'],
                  onPressed: () => editField('Username'),
                  customIcon: LineIcons.edit,
                ),

                MyTextBox(
                  sectionName: "Email",
                  text: userData['Email'],
                  onPressed: () => editField('Email'),
                  customIcon: LineIcons.edit,
                ),

                //bio
                MyTextBox(
                  sectionName: "Bio",
                  text: userData['Bio'],
                  onPressed: () => editField('Bio'),
                  customIcon: LineIcons.edit,
                ),

                //no hp
                MyTextBox(
                  sectionName: "Nomor Hp",
                  text: userData['Nomor Hp'],
                  onPressed: () => editField('Nomor Hp'),
                  customIcon: LineIcons.edit,
                ),
                //user posts

                const SizedBox(
                  height: 25,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MyButton(
                    fungsi: logOut, 
                    textButton: 'Log Out'
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error ${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
