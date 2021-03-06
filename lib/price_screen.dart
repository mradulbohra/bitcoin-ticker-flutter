import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:rflutter_alert/rflutter_alert.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  void initState(){
    super.initState();
    fetchValues();


  }
  String selectedC = 'INR';
  double temp;
  var data, data2, data3;
  int btcValue, ethValue, ltcValue;
  CoinData cd = CoinData();

  DropdownButton<String> androidButton(){
    List<DropdownMenuItem<String>> dropDownMenu = [];
    for(int  i = 0; i<currenciesList.length; i++){
      String currency = currenciesList[i];
      dropDownMenu.add(DropdownMenuItem(child: Text(currency), value: currency ,));

    }
//    return dropDownMenu;

   return DropdownButton<String>(
      value: selectedC,
      items: dropDownMenu,
      style: TextStyle(fontSize: 23, color: Colors.black),
      //dropdownColor: Colors.lightBlue,


      //focusColor: Colors.white,
      iconEnabledColor: Colors.white,
      onChanged: (value)async{
        selectedC = value;
        fetchValues();
       // print(selectedC);
       //   data = await cd.getData('BTC', selectedC);
       //   data2 = await cd.getData('ETH', selectedC);
       //   data3 = await cd.getData('LTC', selectedC);
       //  setState(() {
       //    if(data==null||data2==null||data3==null)
       //    {
       //      failureHandler();
       //    }
       //    else
       //    updateUI(data, data2, data3);
       //  });
      },
    );

  }

  void fetchValues() async
  {
    data = await cd.getData('BTC', selectedC);
    data2 = await cd.getData('ETH', selectedC);
    data3 = await cd.getData('LTC', selectedC);
    setState(() {
      if(data==null||data2==null||data3==null)
      {
        failureHandler();
      }
      else
        updateUI(data, data2, data3);
    });
  }

  void failureHandler()
  {
    Alert(
      context: context,
      type: AlertType.error,
      title: "API Overused",
      desc: "Youve made maximum attemp",
      buttons: [
        DialogButton(
          child: Text(
            "Exit",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => SystemNavigator.pop(),
          width: 120,
        )
      ],
    ).show();

  }

  void updateUI(dynamic data, dynamic data2, dynamic data3)
  {
//     temp = data['rate'];
     btcValue = data['rate'].toInt();
      ethValue = data2['rate'].toInt();
      ltcValue = data3['rate'].toInt();
     //  print(btcValue);
  }
  CupertinoPicker iOSPicker()
  {
    List<Widget>  pickerMenu = [];

    for(int  i = 0; i<currenciesList.length; i++)
    {
      pickerMenu.add(Text(currenciesList[i]));
    }

    return CupertinoPicker(

      itemExtent: 32,
      onSelectedItemChanged: (value){
        selectedC = currenciesList[value];
        fetchValues();

      },
      children: pickerMenu,
      backgroundColor: Colors.lightBlue,
    );
  }

  Widget getOS()
  {
    if(Platform.isIOS)
      return iOSPicker();
    else if(Platform.isAndroid) return androidButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $btcValue $selectedC',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            SizedBox(height: 10,),
            Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ethValue $selectedC',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
                SizedBox(height: 10,),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $ltcValue $selectedC',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

          Container(
            height: 120.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 20.0),
            color: Colors.lightBlue,
            child: Platform.isIOS? iOSPicker(): androidButton(),

          ),
        ],
      ),
    );
  }
}

//
