import 'package:flutter/material.dart';

class MyCounter extends StatefulWidget {
  const MyCounter({
    Key key,
  }) : super(key: key);

  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State {
  int _currentAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 50,
      height: 40,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        // color: Colors.red,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: Icon(
                Icons.remove,
                size: 20,
                color: Colors.grey[700],
              ),
            ),
            onTap: () {
              setState(() {
                _currentAmount -= 1;
              });
            },
          ),
          SizedBox(width: 15),
          Container(
            // width: 40,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                "$_currentAmount",

                style: TextStyle(fontSize: 20),
                // style: Theme.of(context).textTheme.title,
              ),
            ),
          ),
          SizedBox(width: 15),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: Icon(
                Icons.add,
                size: 20,
                color: Colors.grey[700],
              ),
            ),
            onTap: () {
              setState(() {
                _currentAmount += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}

class CustomColorRadio extends StatefulWidget {
  // List<RadioColoModel> sampleData = [];
  // CustomColorRadio({this.sampleData});

  @override
  createState() {
    return new CustomColorRadioState();
  }
}

class CustomColorRadioState extends State<CustomColorRadio> {
  List<RadioColorModel> sampleData = [];
  // CustomColorRadioState({this.sampleData});
  var Size = [
    Colors.accents,
    Colors.pink,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.yellow
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // for (int i = 0; i < Size.length; ++i) {
    //   sampleData.add(new RadioColoModel(false, Size[i]));
    // }
    sampleData.add(new RadioColorModel(
      false,
      Colors.red,
    ));
    sampleData.add(new RadioColorModel(
      false,
      Colors.blue,
    ));
    sampleData.add(new RadioColorModel(false, Colors.black));
    sampleData.add(new RadioColorModel(false, Colors.blue[900]));
    // sampleData.add(new RadioColoModel(false, 'A'));
    // sampleData.add(new RadioColoModel(false, 'B'));
    // sampleData.add(new RadioColoModel(false, 'C'));
    // sampleData.add(new RadioColoModel(false, 'D'));
    // sampleData.add(new RadioColoModel(false, 'A'));
    // sampleData.add(new RadioColoModel(false, 'B'));
    // sampleData.add(new RadioColoModel(false, 'C'));
    // sampleData.add(new RadioColoModel(false, 'D'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      // color: Colors.white,
      // color: Colors.pink,
      child: new ListView.builder(
        itemCount: sampleData.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return

              // Container(
              //   width: 50,
              //   child: Text("${sampleData[index].buttonText}"),
              // );
              new GestureDetector(
            // highlightColor: Colors.red,
            // splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                print("ind: $index");
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
              });
            },
            child:
                //  Container(
                //   height: 50,
                //   width: 50,
                //   color: sampleData[index].buttonText,
                // )

                new RadioColorItem(sampleData[index]),
          );
        },
      ),
    );
  }
}

class RadioColorItem extends StatelessWidget {
  final RadioColorModel _item;
  RadioColorItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      // color: Colors.pink,
      margin: new EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: new Row(
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Opacity(
            opacity: _item.isSelected ? 1.0 : 0.7,
            child: new Container(
              height: 40.0,
              width: 40.0,
              // child: new Center(
              // child:
              // new Text(_item.buttonText,
              //     style: new TextStyle(
              //         color: Colors.black,
              //         // color: _item.isSelected ? Colors.white : Colors.black,
              //         //fontWeight: FontWeight.bold,
              //         fontSize: 12.0)),
              // ),
              decoration: new BoxDecoration(
                color: _item.buttonText,
                // color: _item.isSelected ? Colors.blueAccent : _item.buttonText,
                // color: _item.isSelected ? Colors.transparent : _item.buttonText,
                // color: _item.isSelected ? _item.buttonText : Colors.transparent,
                // color: _item.isSelected ? _item.buttonText : (_item.buttonText),
                // color: Colors.transparent,
                border: new Border.all(
                  // width: _item.isSelected ? 1 : 2.0,
                  // width: 2.0,
                  // width: 4,
                  // color: _item.isSelected ? _item.buttonText : Colors.white,
                  color: _item.buttonText,
                  // color: _item.isSelected ? _item.buttonText : _item.buttonText,
                ),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(30.0)),
              ),
            ),
          ),
          // new Container(
          //   margin: new EdgeInsets.only(left: 10.0),
          //   child: new Text(_item.text),
          // )
        ],
      ),
    );
  }
}

class RadioColorModel {
  bool isSelected;
  final Color buttonText;
  // final String text;

  RadioColorModel(this.isSelected, this.buttonText);
}

class CustomRadio extends StatefulWidget {
  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = new List<RadioModel>();
  var Size = ['X', 'S', 'M', 'L', "XL", "XXL", "XXXL", "XXXXL"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < Size.length; ++i) {
      sampleData.add(new RadioModel(false, Size[i]));
    }
    // sampleData.add(new RadioModel(false, ''));
    // sampleData.add(new RadioModel(false, 'B'));
    // sampleData.add(new RadioModel(false, 'C'));
    // sampleData.add(new RadioModel(false, 'D'));
    // sampleData.add(new RadioModel(false, 'A'));
    // sampleData.add(new RadioModel(false, 'B'));
    // sampleData.add(new RadioModel(false, 'C'));
    // sampleData.add(new RadioModel(false, 'D'));
    // sampleData.add(new RadioModel(false, 'A'));
    // sampleData.add(new RadioModel(false, 'B'));
    // sampleData.add(new RadioModel(false, 'C'));
    // sampleData.add(new RadioModel(false, 'D'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      // color: Colors.amber,
      child: new ListView.builder(
        itemCount: sampleData.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return

              // Container(
              //   width: 50,
              //   child: Text("${sampleData[index].buttonText}"),
              // );
              new GestureDetector(
            // highlightColor: Colors.red,
            // splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
              });
            },
            child: new RadioItem(sampleData[index]),
          );
        },
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      // color: Colors.pink,
      margin: new EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: new Row(
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 40.0,
            width: 40.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color: _item.buttonText == 'X'
                          ? Colors.white
                          : _item.isSelected
                              ? Colors.white
                              : Colors.black,
                      fontWeight: FontWeight.bold,
                      //fontWeight: FontWeight.bold,
                      fontSize: _item.buttonText == 'X' ? 18 : 12.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.buttonText == 'X'
                  ? Colors.red
                  : _item.isSelected
                      ? Colors.blueAccent
                      : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Colors.blueAccent : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
            ),
          ),
          // new Container(
          //   margin: new EdgeInsets.only(left: 10.0),
          //   child: new Text(_item.text),
          // )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  // final String text;

  RadioModel(this.isSelected, this.buttonText);
}
