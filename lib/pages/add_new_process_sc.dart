import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hesap_defterim/alert_class/alert_message.dart';
import 'package:hesap_defterim/dao/veritabanidao.dart';
import 'package:hesap_defterim/main.dart';

import '../widgets/small_text_row_title.dart';

class AddNewProcessSC extends StatefulWidget {
  late String processType;

  AddNewProcessSC({Key? key,
    required this.processType
  }) : super(key: key);

  @override
  State<AddNewProcessSC> createState() => _AddNewProcessSCState();
}

class _AddNewProcessSCState extends State<AddNewProcessSC> {

  late BannerAd staticAd;
  bool statisAdloaded=false;
  static const AdRequest request=AdRequest();

  void loadStaticBannerAd(){
    staticAd=BannerAd(
        adUnitId: "XXXX",
        size: AdSize.banner,
        request: request,
        listener: BannerAdListener(
            onAdLoaded: (ad){
              setState(() {
                statisAdloaded=true;
              });
            },
            onAdFailedToLoad: (ad,error){
              ad.dispose();
              print("failed ${error.message}");
            }
        )
    );
    staticAd.load();
  }



  var _tfProcessType=TextEditingController();
  var _tfExplanation=TextEditingController();
  var _tfAmount=TextEditingController();
  String strDateTime=DateTime.now().day.toString()+"."+DateTime.now().month.toString()+"."+DateTime.now().year.toString().toString();
  DateTime newDateTime=DateTime.now();

  Future<void>getLocal()async{
    print("İşlem Tipi: ${widget.processType}");
    _tfProcessType.text=widget.processType;
  }

  Future<bool>redirectPage()async{
    FocusScope.of(context).unfocus();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "")));
    return true;
  }

  @override
  void initState() {
    //loadStaticBannerAd();
    super.initState();
    getLocal();
  }


  @override
  Widget build(BuildContext context) {
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
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "")));
                    redirectPage();
                  },
                  icon: Icon(Icons.arrow_back,size: 26,color: Colors.black,)),
              SizedBox(width: 10,),
              Text("${widget.processType} Ekle",style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: "NotoSans",
                  fontWeight: FontWeight.w500
              ),),
              Spacer(),
              GestureDetector(
                onTap: (){
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 30,),
                      Icon(Icons.add,size: 26,color: Colors.white,),
                      SizedBox(width: 10,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: WillPopScope(
        onWillPop: ()=>redirectPage(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Container(
              //color: Colors.teal,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom-70
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12,),
                  /*
                  ///İşem Tipi Başlık
                  SmallTextRowTitle(title: "İşlem Tipi", color: Colors.black),
                  SizedBox(height: 6,),
                  ///İşem Tipi
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
                            border:Border.all(width: 1,color: Colors.grey),
                          ),
                          child: TextField(
                            controller: _tfProcessType,
                            //textCapitalization: TextCapitalization.characters,
                            enabled: false,
                            textAlign: TextAlign.left,
                            autofocus: false,
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                    ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                    :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                fontWeight: FontWeight.w500,
                                fontFamily: "NotoSans",
                                color: widget.processType=="GİDER"? Colors.redAccent:Colors.green
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              counterText: "",
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


                  SizedBox(height: 12,),
                  ///İşlem Tarihi Başlık
                  SmallTextRowTitle(title: "İşlem Tarihi", color: Colors.black),
                  SizedBox(height: 6,),
                  /// Fatura Tarih ve Saati
                  GestureDetector(
                    onTap: (){
                      showDatePicker(
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Colors.black.withOpacity(0.8), // header background color
                                  onPrimary: Colors.white, // header text color
                                  onSurface: Colors.black, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                          context: context,
                          //strBaslangicTarih==""?DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1):DateTime.parse(dateReverse(strBaslangicTarih)),//DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1),//DateTime.now(),
                          //initialDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1),
                          initialDate: strDateTime==""?DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day):newDateTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
                          currentDate: DateTime.now()
                      ).then((alinanTarih) async {
                        if(alinanTarih.toString().contains("null")){

                        }else{
                          strDateTime=alinanTarih!.toString().substring(0,11);
                          newDateTime=alinanTarih!;
                          var listReverse=strDateTime.split("-");
                          strDateTime=listReverse[2].trim()+"."+listReverse[1].trim()+"."+listReverse[0].trim()+"";

                          setState(() {
                            strDateTime;
                            newDateTime;
                          });



                        }

                      });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.2,color: Colors.black),
                                borderRadius: BorderRadius.circular(2)
                              //color: Colors.grey[100],
                              //color: Colors.lightGreen.shade200,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 35,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    children: [
                                      Text(strDateTime,style: TextStyle(
                                        //color: AppColors.mainColor,
                                        fontSize: 15,
                                        fontFamily: "PoppinsRegular",)),
                                      Icon(Icons.arrow_drop_down,color: Colors.black54,size: 18,)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  */



                  SizedBox(height: 12,),
                  ///Tutar Başlık
                  SmallTextRowTitle(title: "Tutar", color: Colors.black),
                  SizedBox(height: 6,),
                  ///Tutar
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
                            border:Border.all(width: 1,color: Colors.grey),
                          ),
                          child: TextField(
                            controller: _tfAmount,
                            keyboardType: TextInputType.number,
                            //textCapitalization: TextCapitalization.characters,
                            textAlign: TextAlign.left,
                            autofocus: false,
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                    ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                    :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                fontWeight: FontWeight.w500,
                                fontFamily: "NotoSans",
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              counterText: "",
                              hintText: "Tutar Gir",
                              hintStyle: TextStyle(
                                  fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                      ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                      :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "NotoSans",
                                  color: Colors.grey[500]
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

                  SizedBox(height: 12,),
                  ///Açıklama Başlık
                  SmallTextRowTitle(title: "Açıklama", color: Colors.black),
                  SizedBox(height: 6,),
                  ///Açıklama
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
                            border:Border.all(width: 1,color: Colors.grey),
                          ),
                          child: TextField(
                            controller: _tfExplanation,
                            //textCapitalization: TextCapitalization.characters,
                            textAlign: TextAlign.left,
                            autofocus: false,
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                    ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                    :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                fontWeight: FontWeight.w500,
                                fontFamily: "NotoSans",
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              counterText: "",
                              hintText: "Açıklama Gir",
                              hintStyle: TextStyle(
                                fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                    ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                    :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                fontWeight: FontWeight.w500,
                                fontFamily: "NotoSans",
                                color: Colors.grey[500]
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
                  SizedBox(height: 12,),
                  /// Kaydet button
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: MediaQuery.of(context).orientation ==Orientation.portrait
                          ?MediaQuery.of(context).size.width<321? 30:35
                          :MediaQuery.of(context).size.height<321?30:35,
                      //width: double.maxFinite,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: widget.processType=="Gelir"?Colors.green:Colors.redAccent
                        ),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          var alert=AlertMessage();
                          print("tutar: ${_tfAmount.text}");

                          if(_tfAmount.text.contains(",") ||_tfAmount.text.contains("-")||_tfAmount.text.contains("+")||_tfAmount.text.contains("/")||_tfAmount.text.contains("*")){
                            alert.alertInfo(context, Colors.redAccent, "Tutar Hatalı!");
                          }else{
                            int count=0;
                            for(var i=0;i<_tfAmount.text.length;i++){
                              if(_tfAmount.text[i]=="."){
                                count++;
                              }
                            }
                            if(count>1){
                              alert.alertInfo(context, Colors.redAccent, "Tutar Hatalı!");
                            }else{
                              strDateTime=DateTime.now().toString().substring(0,11);
                              var tutarGonder=double.parse(_tfAmount.text);
                              double.parse(_tfAmount.text);
                              print("a: ${double.parse(_tfAmount.text)}");


                              setState(() {
                                strDateTime;
                                newDateTime;
                              });
                              var alert=AlertMessage();
                              if(_tfProcessType.text=="" || strDateTime=="" ||_tfExplanation.text==""||_tfAmount.text==""){
                                alert.alertInfo(context, Colors.redAccent, "Lütfen Boş Alan Bırakmayın!");
                              }else{
                                await VeritabaniDao().gelirGiderEkle(
                                    context: context,
                                    islem_tipi: _tfProcessType.text,
                                    tarih: newDateTime.toString().substring(0,11),//strDateTime,
                                    aciklama: _tfExplanation.text,
                                    tutar: tutarGonder);//double.parse(_tfAmount.text));
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "")));
                              }
                            }
                          }


                        },
                        child: Text("KAYDET"),
                      ),
                    ),
                  ),

                  Spacer(),
                  /// 55
                  /*
                  Container(
                    //color: Colors.teal,
                    color: Colors.grey[350],
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: AdWidget(ad: staticAd)),
                  ),
                  */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
