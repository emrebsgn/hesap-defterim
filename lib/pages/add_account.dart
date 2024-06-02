import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/color.dart';
import '../widgets/small_text_row_title.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {

  var listRenkler=["Turuncu","Beyaz","Sarı","Mavi","Yeşil","Kırmızı","Pembe","Mor"];
  var selectedRenk="Turuncu";

  Future<bool>redirectPage()async{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "")));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var screenInfos=MediaQuery.of(context); //Burada ekran boyutu alınacak.
    final double screenWidth=screenInfos.size.width;
    final double screenHeight=screenInfos.size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,//Color(0xFFE14D2A),//Color(0xFF3A72DC),//Color(0xFFFD841F),//Color(0xFF3A72DC),//FF884B //E14D2A
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              IconButton(
                  onPressed: (){
                    redirectPage();
                  },
                  icon: Icon(Icons.arrow_back,size: 26,color: Colors.black,)
                      /*
                  Icon(Icons.add,size: 26,color: Colors.green,)
                  */
              ),
              SizedBox(width: 10,),
              Text("Hesap Oluştur",style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: "NotoSans",
                  fontWeight: FontWeight.w500
              ),),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: WillPopScope(
          onWillPop: ()=>redirectPage(),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                //padding: EdgeInsets.all(8.0),
                padding: EdgeInsets.only(left:8,top: 8,right: 8),
                child: Column(
                  children: [
                    Container(
                      //color: Colors.teal,
                      constraints: BoxConstraints( //80-10-60
                          maxHeight: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-56-14-60

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12,),
                          ///Hesap Adı Başlık
                          SmallTextRowTitle(title: "Hesap Adı", color: Colors.black),
                          SizedBox(height: 6,),
                          ///Hesap Adı
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: MediaQuery.of(context).orientation ==Orientation.portrait
                                      ?MediaQuery.of(context).size.width<321? 38:42
                                      :MediaQuery.of(context).size.height<321?38:42,
                                  //45,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(width: 1,color:Colors.black),
                                    color: Colors.white
                                  ),
                                  child: TextField(
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    autofocus: false,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                          ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                          :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NotoSans",
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: "Hesap Adı Gir",
                                      hintStyle: TextStyle(
                                        fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                            :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "NotoSans",
                                      ),
                                      //contentPadding: EdgeInsets.only(bottom: 3),
                                      //contentPadding: EdgeInsets.zero,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      border: InputBorder.none,
                                    ),
                                    onSubmitted: (onSubmitValue){


                                    },
                                    onChanged: (value){

                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),


                          SizedBox(height: 24,),
                          /// DropDownList =>Renkler
                          SmallTextRowTitle(title: "Renk Seç", color: Colors.black),
                          SizedBox(height: 6,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left:16,top: 8,right: 4,bottom: 8),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.orangeAccent.withOpacity(0.6),//Color(0xFFFF6F6C9),
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        borderRadius: BorderRadius.circular(12),
                                        isDense: true,
                                        value: selectedRenk,
                                        items: listRenkler.map<DropdownMenuItem<String>>((String value){

                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,style: TextStyle(
                                              fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                  ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                  :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "NotoSans",
                                            ),
                                            ),
                                          );
                                        }).toList(),
                                        icon: Icon(Icons.arrow_drop_down),
                                        onChanged: (String? selectedData) async{
                                          setState(() {
                                            selectedRenk=selectedData!;
                                          });
                                          /// Global değişken olan list değerine değer atanacak.
                                          //list=await con.get....
                                          /*
                              setState(() {
                                list;
                              });
                              */
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24,),
                          /// Oluştur button
                          Row(
                            children: [
                              Expanded(child: Center()),

                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).orientation ==Orientation.portrait
                                      ?MediaQuery.of(context).size.width<321? 40:45
                                      :MediaQuery.of(context).size.height<321?40:45,
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green
                                    ),
                                    onPressed: () async {


                                    },
                                    child: Text("Oluştur"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6,),
                    Column(
                      children: [
                        Container(
                          width: screenWidth,
                          height: 55,
                          color: Colors.grey[300],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
