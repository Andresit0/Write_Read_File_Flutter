import 'package:flutter/material.dart';
import 'writeReadData.dart' as globalWriteRead;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Write Read Text',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Write Read Text'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerWriteData = new TextEditingController();
  String filename = 'writeReadData.txt';
  String data = '';
  final _formKey = GlobalKey<FormState>();

  // Write and erase the same data into a file
  // await globalWrite.writeData(filename, data);

  //Write in the final of the document separated with a ";" symbol
  void writeData() async {
    data = await globalWriteRead.readData(filename);
    data = data + controllerWriteData.text + ";";
    await globalWriteRead.writeData(filename, data);
    setState(() {});
  }

  // Read data as List<String>
  // data.split(";");

  //Refresh Data
  void readDataNow() async {
    data = await globalWriteRead.readData(filename);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readDataNow();
  }

  @override
  Widget build(BuildContext context) {
    valuesNotAcepted(textInserted) {
      if (textInserted == null || textInserted.isEmpty) {
        return 'Complete all fields';
      } else {
        List<String> valuesNotAcepted = [";"];
        for (int i = 0; i < valuesNotAcepted.length; i++) {
          if (textInserted.contains(valuesNotAcepted[i])) {
            return 'Does not allow symbol:   ' + valuesNotAcepted[i];
          }
        }
      }
      return null;
    }

    void error() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Fix Information"),
            content: const Text('Review red text'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: valuesNotAcepted,
                  scrollPadding: EdgeInsets.all(0),
                  autofocus: true,
                  controller: controllerWriteData,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  maxLength: 30,
                  decoration: InputDecoration(
                    helperText: 'max 30 letters',
                    hintText: 'Text to write',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 15)),
              Container(
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      writeData();
                    } else {
                      error();
                    }
                  },
                  child: Text('Write Data'),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 15)),
              Text(data),
              Padding(padding: EdgeInsets.only(top: 15)),
              Flexible(
                child: ListView.builder(
                  itemCount: data.split(";").length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Text(data.split(";")[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
