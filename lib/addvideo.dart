import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class AddVideo extends StatefulWidget {
  @override
  _AddVideoState createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  var _controller2 = TextEditingController();
  var _controller3 = TextEditingController();
  var _controller4 = TextEditingController();
  var _controller5 = TextEditingController();

  final firestoreInstance = FirebaseFirestore.instance;
  bool teamV=false,siteV=false,typeV=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<ListItem> _dropdownItemsTeam = [
    ListItem(1, "All"),
    ListItem(2, "Attacker"),
    ListItem(3, "Defender"),
  ];
  List<ListItem> _dropdownItemsSite = [
    ListItem(1, "A Site"),
    ListItem(2, "B Site"),
    ListItem(3, "C Site"),
  ];
  List<ListItem> _dropdownItemsType = [
    ListItem(1, "All"),
    ListItem(2, "Retake"),
    ListItem(3, "One-Way"),
    ListItem(4,"Execute"),
    ListItem(5,"Afterplant")
  ];
  String _coll_name,_credit,_video_url,_image_url,_team,_type,_site,_video_title;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItemsTeam,_dropdownMenuItemsSite,_dropdownMenuItemsType;
  ListItem _selectedItemTeam,_selectedItemSite,_selectedItemType;

  @override
  void initState() {
    _dropdownMenuItemsTeam = buildDropDownMenuItems(_dropdownItemsTeam);
    _dropdownMenuItemsSite = buildDropDownMenuItems(_dropdownItemsSite);
    _dropdownMenuItemsType = buildDropDownMenuItems(_dropdownItemsType);
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Hexcolor("#ff4654"),
        title: new Text('Upload'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: (){},
          )
        ],
      ),
      body: SingleChildScrollView(

        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  maxLength: 4,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                  inputFormatters: [UpperCaseTextFormatter()],
                  maxLines: 1,
                  validator: (input){
                    if(input.isEmpty){
                      return 'Please enter collection name';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter collection name e.g.ASH'
                  ),
                  onChanged: (input)=> _coll_name = input,
                  onSaved: (input)=> _coll_name = input,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: DropdownButton(
                      hint: Text("Team"),
                      value: _selectedItemTeam,
                      items: _dropdownMenuItemsTeam,
                      //icon: Icon(Icons.view_stream,color: Colors.redAccent),
                      onChanged: (value){
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _selectedItemTeam = value;
                          if(_selectedItemTeam.name.toString().isEmpty){
                            teamV= false;
                          }else{
                            teamV = true;
                          }
                        });
                      },
                    ),
                  ),
                  Container(
                    child: DropdownButton(
                      hint: Text("Type"),
                      value: _selectedItemType,
                      items: _dropdownMenuItemsType,
                      //icon: Icon(Icons.view_stream,color: Colors.redAccent),
                      onChanged: (value){
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _selectedItemType = value;
                          if(_selectedItemType.name.toString().isEmpty){
                              typeV = false;
                          }
                          else{
                            typeV = true;
                          }
                        });
                      },
                      //icon: Icon(Icons.merge_type,color: Colors.redAccent),
                    ),
                  ),
                  Container(
                    child: DropdownButton(
                      hint: Text("Site"),
                      value: _selectedItemSite,
                      items: _dropdownMenuItemsSite,
                      //icon: Icon(Icons.view_stream,color: Colors.redAccent),
                      onChanged: (value){
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _selectedItemSite = value;
                          if(_selectedItemSite.name.toString().isEmpty){
                            siteV = false;
                          }
                          else{
                            siteV = true;
                          }
                        });
                      },
                      //icon: Icon(Icons.map,color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: _controller2,
                  validator: (input){
                    if(input.isEmpty){
                      return "Please enter video title";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter video title'
                  ),
                  onChanged: (input)=> _video_title = input,
                  onSaved: (input)=> _video_title = input,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _controller3,
                  decoration: InputDecoration(
                      labelText: 'Enter credit'
                  ),
                  onChanged: (input)=> _credit = input,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: _controller4,
                  validator: (input){
                    if(input.isEmpty){
                      return "Please enter video url";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter video url'
                  ),
                  onChanged: (input)=> _video_url = input,
                  onSaved: (input)=> _video_url = input,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: _controller5,
                  validator: (input){
                    if(input.isEmpty){
                      return "Please enter image url";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter image url'
                  ),
                  onChanged: (input)=> _image_url = input,
                  onSaved: (input)=> _image_url = input,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if(_formKey.currentState.validate()){
                      if(teamV == false || siteV == false || typeV == false){
                        Fluttertoast.showToast(msg: "Select all dropdown items",gravity:
                        ToastGravity.BOTTOM,backgroundColor: Colors.redAccent,textColor: Colors.white,fontSize: 15,toastLength: Toast.LENGTH_SHORT);
                      }
                      else{
                        String videoType = _selectedItemType.name.toString().toLowerCase();
                        String videoTeam = _selectedItemTeam.name.toString().toLowerCase();
                        String videoSite = _selectedItemSite.name.toString().toLowerCase();

                        if(videoType == "all"){
                          videoType = "";
                        }
                        if(videoTeam == "all"){
                          videoTeam = "";
                        }


                        firestoreInstance.collection(_coll_name.toUpperCase()).add({
                          "title" : _video_title,
                          "credit" : _credit,
                          "type": videoType,
                          "team": videoTeam,
                          "site" : videoSite,
                          "video": _video_url,
                          "image": _image_url

                        }
                        ).then((_){
                          _controller2.clear();
                          _controller3.clear();
                          _controller4.clear();
                          _controller5.clear();
                          Fluttertoast.showToast(msg: "Video successfully added",gravity:
                          ToastGravity.BOTTOM,backgroundColor: Colors.redAccent,textColor: Colors.white,fontSize: 20,toastLength: Toast.LENGTH_SHORT);
                        print("Success");
                        });
                      }
                    }
                  });
                },
                child: new Text('Upload'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}





