import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(MyCalculator());
}

class MyCalculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MySimpleCalaculator',
      theme: ThemeData(primaryColor: Colors.greenAccent),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget{
  @override
  _Calculators_States createState()=>_Calculators_States();
}

class _Calculators_States extends State<Calculator>{

  String equation = "0";
  String result = "0";
  String expression = "0";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  buttonPressed(String buttonText){
    setState(() {

      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }else if (buttonText == "<-"){
        equationFontSize = 38.0;
        resultFontSize = 48.0;
       equation = equation.substring(0,equation.length - 1);
       if (equation == ""){
         equation = "0";
       }
      }else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression  = expression.replaceAll('*', '*');
        expression  = expression.replaceAll('÷', '/');
        try{

          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = 'Error';
        }
      }else{
        equationFontSize = 38.0;
        resultFontSize = 48.0;
         if (equation == "0"){
           equation = buttonText;
         }else {
           equation = equation + buttonText;
         }
      }

    });


  }


  /*
  * Widget ButtonMaker
  * String buttonText   -   text inside button
  * double buttonHeight -   Height of button
  * Color buttonColor   -   color of button
  *
  * */
  Widget ButtonMaker(String buttonText,double buttonHeight, Color buttonColor,Color buttonTextColor){
    return Container(
      height: MediaQuery.of(context).size.height*0.1*buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid)
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: ()=>buttonPressed(buttonText),
        child: Text(buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color:buttonTextColor
            )
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(title: Text('MyCalculator'),),
      body: Column(
        children: <Widget> [
          Container(
            alignment: Alignment.centerRight,
            //padding: EdgeInsets.fromLTRB(left, top, right, bottom)
            padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
            child: Text(equation,style: TextStyle(fontSize:equationFontSize),),
            
          ),
          Container(
            alignment: Alignment.centerRight,
            //padding: EdgeInsets.fromLTRB(left, top, right, bottom)
            padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
            child: Text(result,style: TextStyle(fontSize:resultFontSize),),
          ),
          Expanded(child: Divider(),

          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.75,
                  child: Table(
                    children: [
                      TableRow(
                          children:[
                            ButtonMaker("C",1, Colors.greenAccent,Colors.white),
                            ButtonMaker("<-",1, Colors.white,Colors.black),
                            ButtonMaker("÷",1, Colors.white,Colors.black),
                          ]
                      ),
                      TableRow(
                          children:[
                            ButtonMaker("7",1, Colors.white,Colors.black),
                            ButtonMaker("8",1, Colors.white,Colors.black),
                            ButtonMaker("9",1, Colors.white,Colors.black),
                          ]
                      ),
                      TableRow(
                          children:[
                            ButtonMaker("4",1, Colors.white,Colors.black),
                            ButtonMaker("5",1, Colors.white,Colors.black),
                            ButtonMaker("6",1, Colors.white,Colors.black),
                          ]
                      ),
                      TableRow(
                          children:[
                            ButtonMaker("1",1, Colors.white,Colors.black),
                            ButtonMaker("2",1, Colors.white,Colors.black),
                            ButtonMaker("3",1, Colors.white,Colors.black),
                          ]
                      ),
                      TableRow(
                          children:[
                            ButtonMaker(".",1, Colors.white,Colors.black),
                            ButtonMaker("0",1, Colors.white,Colors.black),
                            ButtonMaker("00",1, Colors.white,Colors.black),
                          ]
                      ),
                    ],

                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.25,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            ButtonMaker("*",1, Colors.white,Colors.black)
                          ]

                        ),
                        TableRow(
                            children: [
                              ButtonMaker("-",1, Colors.white,Colors.black)
                            ]

                        ),
                        TableRow(
                            children: [
                              ButtonMaker("+",1, Colors.white,Colors.black)
                            ]

                        ),
                        TableRow(
                            children: [
                              ButtonMaker("=",2, Colors.white,Colors.black)
                            ]

                        ),
                      ],
                    )
                )
              ],
          ),

        ],
      ),
    );
    return Container();

  }

}