import 'package:flutter/material.dart';

class Cl_create extends StatefulWidget {
  const Cl_create({Key? key}) : super(key: key);

  @override
  State<Cl_create> createState() => _Cl_createState();
}

class _Cl_createState extends State<Cl_create> {
  var yourName = TextEditingController();
  var surName = TextEditingController();
  var yourUni = TextEditingController();
  var yourFaculty = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create Form'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                PictureIcon(),
                TextHeader('General Info'),
                textFormF('Your Name', 'Input Your Name', yourName),
                textFormF('Surname', 'Input Your Surname', surName),
                PictureIcon(),
                TextHeader('Education Info'),
                textFormF('Your University', 'Input Your University', yourUni),
                textFormF('Faculty', 'Input Your Faculty', yourFaculty),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        onPressed: () {
                          print('Your Name : ' + yourName.text);
                          print('Your SurName : ' + surName.text);
                          print('Your University : ' + yourUni.text);
                          print('Your Faculty : ' + yourFaculty.text);
                        },
                        child: Text(
                          'Add Data',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFormF(
      String lText, String hText, TextEditingController controller) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: lText,
            hintText: hText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Text TextHeader(String Header) {
    return Text(
      Header,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.blue,
      ),
    );
  }

  Padding PictureIcon() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        Icons.insert_photo,
        size: 100,
      ),
    );
  }
}
