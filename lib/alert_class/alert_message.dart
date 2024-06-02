
import 'package:flutter/material.dart';

import '../utils/color.dart';

class AlertMessage{

  Future<void> alertInfo(context,Color color, String infoText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        var screenInfos =MediaQuery.of(context); //Burada ekran boyutu alınacak.
        final double screenWidth = screenInfos.size.width;
        final double screenHeight = screenInfos.size.height;
        return AlertDialog(
          //insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth/20)
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  //padding: EdgeInsets.all(screenWidth / 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth / 100),
                    //color: Color(0xFFEEEBB8),
                  ),
                  child: Center(
                    child: Text(
                      infoText,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                              ?MediaQuery.of(context).size.height>821? 20: MediaQuery.of(context).size.width<321? 13:15
                              :MediaQuery.of(context).size.height>551? 20:MediaQuery.of(context).size.height<321?13:15,//screenWidth / 22,
                          fontWeight: FontWeight.bold,
                          color: color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(screenWidth/40),
                                    side: BorderSide(color: Colors.grey)
                                )
                            )
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                          child: Text(
                            "Tamam",style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                  ?MediaQuery.of(context).size.height>821? 16: MediaQuery.of(context).size.width<321? 12:16
                                  :MediaQuery.of(context).size.height>551? 16:MediaQuery.of(context).size.height<321?12:16,//screenWidth/26,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PoppinsRegular"
                          ),
                          ),
                        )
                    ),
                  ),
                ),
                Expanded(child: SizedBox(

                )),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> alertWarningListNew(context,Color titleColor, List errorTextList) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        var screenInfos =MediaQuery.of(context); //Burada ekran boyutu alınacak.
        final double screenWidth = screenInfos.size.width;
        final double screenHeight = screenInfos.size.height;
        //Future.delayed(const Duration(),() => SystemChannels.textInput.invokeMethod('TextInput.hide'));
        return AlertDialog(
          title: Center(),/*
          Flexible(
            child: Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              //color: Colors.teal,
              child: Stack(
                children: [
                  Icon(Icons.info_outline,color: Colors.redAccent,size: 52,),
                  Positioned(
                    left: 24,
                    top: 3,
                    child: Container(
                      padding: EdgeInsets.only(left:30,top: 10,right: 16,bottom: 10),
                      decoration: BoxDecoration(
                        //border: Border.all(color:Colors.orange,width: 1),
                        border: Border(
                          top: BorderSide(color:Colors.orange,width: 1.5),
                          //left: BorderSide(color:Colors.orange,width: 1.5),
                          right: BorderSide(color:Colors.orange,width: 1.5),
                          bottom: BorderSide(color:Colors.orange,width: 1.5),
                        ),
                        //borderRadius: BorderRadius.circular(8)
                      ),
                      child: Text("İşlem Sonucu",style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                      )),
                    ),
                  ),
                  Spacer(),
                  SizedBox(width: 20,),
                ],
              ),
            ),
          ),
          */
          content: Flexible(
            child: ListView.builder(
              itemCount: errorTextList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1,
                  shadowColor: AppColors.mainColor,//AppColors.mainColor,
                  color: Color(0xFFEEEBB8), //Colors.grey[200],
                  child: Container(
                      padding: EdgeInsets.symmetric( vertical: 8,horizontal: 2),
                      width: screenWidth,
                      child: Text(
                        errorTextList[index].toString().trim(),
                        style: TextStyle(fontSize: 16),
                      )),
                );
              },
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                SizedBox(width: screenWidth/50,),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(screenWidth/40),
                                    side: BorderSide(color: Colors.grey)
                                )
                            )
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenWidth/30),
                          child: Text(
                            "Tamam",style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth/26,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PoppinsRegular"
                          ),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }


  Future<void> alertRedirectNew(context,Color color, String infoText,String pageName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        var screenInfos =MediaQuery.of(context); //Burada ekran boyutu alınacak.
        final double screenWidth = screenInfos.size.width;
        final double screenHeight = screenInfos.size.height;
        //Future.delayed(const Duration(),() => SystemChannels.textInput.invokeMethod('TextInput.hide'));
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth/20)
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  //padding: EdgeInsets.all(screenWidth / 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth / 100),
                    //color: Color(0xFFEEEBB8),
                  ),
                  child: Center(
                    child: Text(
                      infoText,
                      style: TextStyle(fontSize: screenWidth / 22,
                          fontWeight: FontWeight.bold,
                          color: color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                SizedBox(width: screenWidth/50,),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(screenWidth/40),
                                    side: BorderSide(color: Colors.grey)
                                )
                            )
                        ),
                        onPressed: () async {
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenWidth/30),
                          child: Text(
                            "Tamam",style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth/26,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PoppinsRegular"
                          ),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }


  Future<void> alertProcess(context,Color color, String infoText,Function f) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        var screenInfos =MediaQuery.of(context); //Burada ekran boyutu alınacak.
        final double screenWidth = screenInfos.size.width;
        final double screenHeight = screenInfos.size.height;
        //Future.delayed(const Duration(),() => SystemChannels.textInput.invokeMethod('TextInput.hide'));
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth/20)
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  //padding: EdgeInsets.all(screenWidth / 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth / 100),
                    //color: Color(0xFFEEEBB8),
                  ),
                  child: Center(
                    child: Text(
                      infoText,
                      style: TextStyle(fontSize: screenWidth / 22,
                          fontWeight: FontWeight.bold,
                          color: color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(screenWidth/40),
                                    side: BorderSide(color: AppColors.mainColor)
                                )
                            )
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenWidth/30),
                          child: Text(
                            "Vazgeç",style: TextStyle(
                              //color: Colors.black,
                              color: AppColors.mainColor,
                              fontSize: screenWidth/26,
                              fontFamily: "PoppinsRegular"
                          ),
                          ),
                        )),
                  ),
                ),
                SizedBox(width: screenWidth/50,),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(screenWidth/40),
                                    side: BorderSide(color: Colors.grey)
                                )
                            )
                        ),
                        onPressed: () async {
                          f();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenWidth/30),
                          child: Text(
                            "Sil",style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth/26,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PoppinsRegular"
                          ),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }



}