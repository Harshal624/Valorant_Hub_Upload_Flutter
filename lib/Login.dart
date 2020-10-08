import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vhub_upload/addvideo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email,_password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height * 0.32,
                decoration: BoxDecoration(
                  color: Hexcolor("#ff4654"),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(2,2),
                          spreadRadius: 0.8
                      )
                    ]
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 35,
                    ),
                    Container(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black,
                        child: //CircleAvatar(backgroundImage: AssetImage("images/logoo.jpg"), radius: 37)
                       ClipOval(child: Image.asset("images/logoo.jpg",fit: BoxFit.fill,width: 700,height: 700),)
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("Valorant Hub",style: TextStyle(fontSize: 20,fontFamily: 'Valorant Font',color: Colors.white,fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),
                            Text("Upload",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.normal,fontFamily: 'Valorant Font'),)
                          ],
                        )),
                  ],
                ),
              ),
               SizedBox(
                 height: MediaQuery.of(context).size.height * 0.1,
               ),
               Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: TextFormField(
                      validator: (input){
                        if(input.isEmpty){
                          return 'Please enter an email';
                        }
                      },
                      onSaved: (input) => _email = input ,
                      decoration: InputDecoration(
                          labelText:'Email',prefixIcon: Icon(Icons.email,color: Colors.blue,)
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: TextFormField(
                      validator: (input){
                        if(input.length < 6){
                          return 'You password must be atleast of 6 characters';
                        }
                      },
                      onSaved: (input) => _password = input ,
                      decoration: InputDecoration(
                          labelText:'Password',prefixIcon: Icon(Icons.lock,color: Colors.blue,)
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19),
                        //side: BorderSide(color: Colors.grey)
                      ),
                      onPressed:
                      login
                      ,
                      child: new Text('Login',style: TextStyle(color: Colors.white,fontSize: 15)),
                      color:Hexcolor("#ff4654"),
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

 Future<void> login() async{
    //TODO validate fields and login to firebase
    final _formState = _formKey.currentState;
    if(_formState.validate()){
      //lOGIN TO FIREBASE
      _formState.save();
      try{
        UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.trim(), password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddVideo()));
      }
      catch(e){
        //print(e.message);
        print("Unable to login");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }
}
