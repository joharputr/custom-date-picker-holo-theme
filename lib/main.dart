import 'package:date_picker_scroll/custom_date/date_picker.dart';
import 'package:date_picker_scroll/custom_date/date_picker_theme.dart';
import 'package:date_picker_scroll/custom_date/i18n/date_picker_i18n.dart';
import 'package:date_picker_scroll/custom_date/widget/date_picker_widget.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'example',
      theme: ThemeData(primarySwatch: Colors.blue),
//      home: DateTesting(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Holo Datepicker Example'),
        ),
        body: MyHomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text("open picker dialog"),
            onPressed: () async {
              var datePicked = await DatePicker.showSimpleDatePicker(context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1960),
                  lastDate: DateTime(2100),
                  dateFormat: "dd-MMMM-yyyy",
                  locale: DateTimePickerLocale.id,
                  looping: true,
                  titleText: "Pilih Tanggal",
                  textColor: Colors.black,
                  backgroundColor: Colors.white);

              final snackBar =
                  SnackBar(content: Text("Date Picked $datePicked"));
              Scaffold.of(context).showSnackBar(snackBar);
            },
          ),
          RaisedButton(
            child: Text("Show picker widget"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (context) => WidgetPage()),
              );
            },
          )
        ],
      ),
    );
  }
}

class WidgetPage extends StatefulWidget {
  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  DateTime selectedDate;

  DateTime dateTime = DateTime.now();
  String dateSendtoApi = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: FlatButton(
                child: Text("Button Date"),
                onPressed: () => openDialog(),
              )),
        ),
      ),
    );
  }

  datePickerDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text("Tanggal"),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text("Bulan"),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text("Tahun"),
              )
            ],
          ),
          DatePickerWidget(
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            dateFormat: "dd-MMMM-yyyy",
            locale: DateTimePickerLocale.id,
            looping: true,
            pickerTheme: DateTimePickerTheme(
              backgroundColor: Colors.white,
              itemTextStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            onChange: ((DateTime date, list) {
              setState(() {
                dateSendtoApi = DateFormat("yyyy-MM-dd").format(date);
                print(date.toString());
              });
            }),
          ),
          FlatButton(
              child: Text('OK'),
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () {
                print("date = " + dateSendtoApi);
                Navigator.of(context).pop();
              }),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  openDialog() {
    return showDialog(
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) {
          return datePickerDialog();
        });
  }
}
