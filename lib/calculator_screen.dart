import 'package:flutter/material.dart';

import 'button_values.dart';

class  CalculatorScreen extends StatefulWidget
{
  const CalculatorScreen({super.key});
  @override
  State<CalculatorScreen> createState()=> _CalculatorScreenState();
}
class _CalculatorScreenState extends State<CalculatorScreen>
{
  String n1="";
  String op="";
  String n2="";


  @override
  Widget build(BuildContext context) {
    //responsive
    final screenSize=MediaQuery.of(context).size;
    return Scaffold(

      body: SafeArea(
        bottom:false,
        child:Column(
        children: [
          //output
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: TextEditingController(text: "$n1$op$n2".isEmpty ? "0" : "$n1$op$n2"),
                  style:
                 const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,

                ),
                textAlign: TextAlign.end,
                  readOnly: true,
                  maxLength: null,
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          //button
          Wrap(
            children: Btn.buttonValues.map(
                  (value) => SizedBox(
                      width:screenSize.width / 4,
                      height:screenSize.width / 5,
                      child: buildButton(value)
                  ),
            ).toList(),
          )
        ],
      ),
      ),
    );
  }
  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        color:getColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(

          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(
            color: Colors.white24,

          ),


        ),
        child: InkWell(
          onTap: () => onbtntap(value),
          child: Center(
            child: Text(value,style:
             const TextStyle(
                fontWeight:FontWeight.bold,
                fontSize: 20,
              ),),
          ),
        ),
      ),
    );

  }

  //ontap function
  void onbtntap(String value)
  {
    if(value==Btn.del)
      {
        delete();
        return;
      }
    if(value==Btn.clr)
      {
        clearall();
        return;
      }
    if(value==Btn.per)
      {
        converttoper();
        return;
      }
    if(value==Btn.calculate)
      {
        calculate();
        return;
      }


    appendvalue(value);
  }
  void calculate()
  {
    if(n1.isEmpty) return;
    if(n2.isEmpty) return;
    if(op.isEmpty) return;

    final double num1=double.parse(n1);
    final double num2=double.parse(n2);
    dynamic result;

    switch(op)
    {
      case Btn.add:result=num1+num2;break;
      case Btn.subtract:result=num1-num2;break;
      case Btn.multiply:result=num1*num2;break;
      case Btn.divide:if(num2!=0)
                      {
                        result=num1/num2;
                      }
                      else
                      {
                          result="divide by zero";
                      }break;
    }
    setState(() {
      n1="$result";
      if(n1.endsWith(".0"))
        {
          n1=n1.substring(0,n1.length-2);
        }
      op="";
      n2="";
    });

  }
  void converttoper()
  {
    if(n1.isNotEmpty&&op.isNotEmpty&&n2.isNotEmpty)
      {
          calculate();
      }
    if(op.isNotEmpty)
      {
        return;
      }
    final number = double.parse(n1);
    setState(() {
      n1="${(number/100)}";
      op="";
      n2="";
    });
  }
  void clearall()
  {
    setState(() {
      n1="";
      op="";
      n2="";
    });
  }
  void delete()
  {
    if(n2.isNotEmpty)
      {
        n2=n2.substring(0,n2.length-1);

      }
    else if(op.isNotEmpty)
      {
        op="";
      }
    else if(n1.isNotEmpty)
      {
        n1=n1.substring(0,n1.length-1);
      }
    setState(() {

    });
  }
  void appendvalue(String value) {
    if(value != Btn.dot && int.tryParse(value) == null) {
      if(op.isNotEmpty && n2.isNotEmpty) {
        calculate();
      }
      op = value;
    } else if(op.isEmpty) {
      if(value == Btn.dot && n1.contains(Btn.dot)) return;
      if(value == Btn.dot && (n1.isEmpty || n1 == Btn.dot)) {
        value = "0.";
      }
      n1 += value;
    } else {
      if(value == Btn.dot && n2.contains(Btn.dot)) return;
      if(value == Btn.dot && (n2.isEmpty || n2 == Btn.dot)) {
        value = "0.";
      }
      n2 += value;
    }
    setState(() {});
  }


  //color function
  Color getColor(value)
  {
    return [Btn.del,Btn.clr].contains(value)?Colors.amber
        : [Btn.per, Btn.add, Btn.multiply, Btn.divide, Btn.subtract,].contains(value)?Colors.purple
        :[Btn.calculate].contains(value)?Colors.green
        : Colors.indigo;
  }
  }
