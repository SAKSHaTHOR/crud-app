
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan,
      ),
      home: LoginPage(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String studentName=" ";
  late String studentID,studyProgramID;
  late double studentGPA;

  getStudentName(name){
    this.studentName = name;
  }
  getStudentID(studentID){
    this.studentID = studentID;
  }
  getStudyProgramID(programID){
    this.studyProgramID= programID;
  }
  getStudentGPA(GPA){
    this.studentGPA=double.parse(GPA);
  }
  createData(){


    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Mystudents").
       doc(studentName);

    Map<String,dynamic> students = {
      "studentName" : studentName,
      "studentID" : studentID,
      "studyProgramID" : studyProgramID,
      "studentGPA" : studentGPA
    };

    documentReference.set(students).whenComplete((){
      print("$studentName created");
    });
  }
  readData(){
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection("Mystudents").
      doc(studentName);
  documentReference.get().then((datasnapshot){
     print(datasnapshot);
  });
  }
  updateData(){

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("Mystudents").
    doc(studentName);

    Map<String,dynamic> students = {
      "studentName" : studentName,
      "studentID" : studentID,
      "studyProgramID" : studyProgramID,
      "studentGPA" : studentGPA
    };

    documentReference.set(students).whenComplete((){
      print("$studentName updated");
    });

  }
  deleteData(){
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("Mystudents").
    doc(studentName);

    documentReference.delete().whenComplete((){
      print("$studentName deleted");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GDSC new Member list'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),

              child: TextFormField(
                decoration: InputDecoration(
                  labelText:"Name" ,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide:BorderSide(
                      color:Colors.blueGrey,
                      width:2.0)
                    )
                  ),
                onChanged: (String name){
                  getStudentName(name);
                },
                ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText:"Student ID" ,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:BorderSide(
                            color:Colors.blue,
                            width:2.0)
                    )
                ),
                onChanged: (String studentID){
                    getStudentID(studentID);
                },
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText:"Study program ID" ,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:BorderSide(
                            color:Colors.blue,
                            width:2.0)
                    )
                ),
                onChanged: (String StudyProgramID){
                  getStudyProgramID(StudyProgramID);
                },
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText:"GPA" ,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:BorderSide(
                            color:Colors.blue,
                            width:2.0)
                    )
                ),
                onChanged: (String GPA){
                  getStudentGPA(GPA);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('CREATE'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontStyle: FontStyle.normal),
                  ),
                  onPressed: () {
                    createData();
                  },

                ),
                ElevatedButton(
                  child: Text('READ'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontStyle: FontStyle.normal),
                  ),
                  onPressed: () {
                    readData();
                  },
                ),
                ElevatedButton(
                  child: Text('UPDATE'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontStyle: FontStyle.normal),
                  ),
                  onPressed: () {
                    updateData();
                  },

                ),
                ElevatedButton(
                  child: Text('DELETE'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontStyle: FontStyle.normal),
                      ),
                  onPressed: () {
                    deleteData();
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                Expanded(child: Text("Name"),
                ),
                Expanded(child: Text("Student ID"),
                ),
                Expanded(child: Text("Program ID"),
                ),
                Expanded(child: Text("GPA"),
                ),

              ],),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Mystudents").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot? querySnapshot = snapshot.data as QuerySnapshot?;
                  if (querySnapshot != null) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: querySnapshot.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot = querySnapshot.docs[index];
                        return Row(
                          children: <Widget>[
                            Expanded(child: Text(documentSnapshot["studentName"])),
                            Expanded(child: Text(documentSnapshot["studentID"])),
                            Expanded(child: Text(documentSnapshot["studyProgramID"])),
                            Expanded(child: Text(documentSnapshot["studentGPA"].toString())),
                          ],
                        );
                      },
                    );
                  }
                }

                // Return an empty Container as a placeholder
                return Container();
              },
            )


          ],
        ),
      )
    );
  }
}
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: _validateEmail,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: _validatePassword,
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                      );
                    }
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
