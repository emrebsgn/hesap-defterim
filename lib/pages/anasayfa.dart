import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hesap_defterim/dao/veritabanidao.dart';
import 'package:hesap_defterim/main.dart';
import 'package:hesap_defterim/model/model_gelir_gider.dart';
import 'package:hesap_defterim/pages/add_new_process_sc.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

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

  var islemAdi=<String>["Market Alışverişi_400 TL","Aksam Yemeği_350 TL","Sinema_200 TL","Spor_50 TL","Okul Kitapları_1.000 TL"];
  var listIslemDurumu=<String>["Hepsi","Gelenler","Gidenler"];
  String selectedIslemDurumu="Hepsi";
  var listIslemGunAraligi=<String>["Bugün","Dün","Son 7 gün","Son 15 gün","Bu Ay"];
  String selectedIslemGunAraligi="Bugün";

  var listMonth=<String>["Ocak","Şubat","Mart","Nisan","Mayıs","Haziran","Temmuz","Ağustos","Eylül","Ekim","Kasım","Aralık"];
  var list=<ModelGelirGider>[];

  double toplamGider=0;
  double toplamGelir=0;
  double kalanParam=0;


  Future<bool>redirectPage()async{
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "")));
    return false;
  }


  Future<void>getLocal()async{
    kalanParam=0;
    toplamGider=0;
    toplamGelir=0;

    list=await VeritabaniDao().gelirGiderBilgileri(islemTuru: "Hepsi",zaman: "Bugün");
    if(list.isEmpty){
      print("Liste Boş");
    }else{
      print("Liste Dolu");
    }

    toplamGider=await VeritabaniDao().islemTipiToplami(islemTipi: "Gider");
    print("Toplam Gider: ${toplamGider}");
    toplamGelir=await VeritabaniDao().islemTipiToplami(islemTipi: "Gelir");
    print("Toplam Gelir: ${toplamGelir}");
    kalanParam=toplamGelir-toplamGider;
    print("Kalan Param: ${kalanParam}");

    /*
    for(var i in list){
      print(i.tutar);
      print(i.tarih);
      if(i.islem_tipi=="GELİR"){
        print("***Gelir: ${i.tutar}");
        //toplamGelir=toplamGelir+int.parse(i.tutar);
        toplamGelir=toplamGelir+i.tutar;
      }
      if(i.islem_tipi=="GİDER"){
        print("***Gider: ${i.tutar}");
        //toplamGider=toplamGider+int.parse(i.tutar);
        toplamGider=toplamGider+i.tutar;
      }
    }

    print("KALAN PARAM: ${kalanParam}");
    print("Toplam Gelir: ${toplamGelir}");
    print("Toplam Gider: ${toplamGider}");
    kalanParam=toplamGelir-toplamGider;
    */
    setState(() {
      kalanParam;
      toplamGider;
      toplamGelir;
    });

  }

  Future<void>getTotal()async{

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
                    },
                    icon: Icon(Icons.home_outlined,size: 26,color: Colors.black,)),
                SizedBox(width: 10,),
                Text("Hesap Defterim",style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: "NotoSans",
                    fontWeight: FontWeight.w500
                ),),
                Spacer(),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "")));
                  },
                  child: Icon(Icons.power_settings_new_outlined,color: Colors.redAccent.withOpacity(0.8),size: MediaQuery.of(context).size.width>1200?25:MediaQuery.of(context).size.height>1200?25: 23),
                )
                /*
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
                */
              ],
            ),
          ),
        ),
        backgroundColor: Colors.grey[200],
        //backgroundColor: Colors.grey,
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
                          maxHeight: MediaQuery.of(context).size.height-56-8-6-55-MediaQuery.of(context).padding.top

                      ),
                      child: Column(
                        children: [
                          ///Kalan Param
                          GestureDetector(
                            onTap: ()async{
                              var list=await VeritabaniDao().gelirGiderBilgileri(islemTuru: "Hepsi",zaman: "Bugün");
                              for(var i in list){
                                print("İşlem Tipi: ${i.islem_tipi}");
                                print("Tarih: ${i.tarih}");
                                print("Açıklama: ${i.aciklama}");
                                print("Tutar: ${i.tutar}");
                              }
                            },
                            child: Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(right: 4),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 4,right: 4),
                                              child: Text("Kalan Param",style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                                fontFamily: "NotoSans",
                                              ),),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 4,),
                                            Text("${kalanParam.toStringAsFixed(2)}",style: TextStyle(//200.000
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "NotoSans",
                                            ),),
                                            SizedBox(width: 4,),
                                            //Spacer(),
                                            Text("TL",style: TextStyle(//200.000
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "NotoSans",
                                            ),),
                                            SizedBox(width: 8,)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          /// Gidenler/Gelenler
                          Container(
                            height: 80,
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      //await VeritabaniDao().tableClear("gelirgidertable");
                                      /*
                              var geciciList=await VeritabaniDao().gelirGiderBilgileri(islemTuru: "Hepsi", zaman: "Bu Ay");
                              for(var i in geciciList){
                                print("İşlem Tipi: ${i.islem_tipi}");
                                print("Tutar: ${i.tutar}");
                              }
                              */
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "")));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(3),
                                      //height: 80,
                                      decoration: BoxDecoration(
                                        //color: Color(0xFFFFC6D3),//Color(0xFFFFE5F1),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              //Icon(Icons.add,color: Colors.redAccent,size: 20),
                                              Spacer(),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text("Gidenler",style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent,
                                                  fontFamily: "NotoSans",
                                                ),),
                                              ),SizedBox(width: 4,)
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 4,),
                                              Text("${toplamGider.toStringAsFixed(2)}",style: TextStyle( //140.000
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "NotoSans",
                                              ),),
                                              SizedBox(width: 4,),
                                              Text("TL",style: TextStyle( //140.000
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "NotoSans",
                                              ),),
                                              SizedBox(width: 4,)
                                            ],
                                          ),
                                          Spacer(),
                                          SizedBox(height: 16,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async{
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewProcessSC(processType: "Gelir")));
                                      /*
                              var geciciList=await VeritabaniDao().gelirGiderBilgileri(islemTuru: "Hepsi", zaman: "Bu Ay");
                              for(var i in geciciList){
                                print("i: ${i.tutar}");
                                print("i: ${i.islem_tipi}");
                                print("i: ${i.aciklama}");
                              }
                              */
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(3),
                                      //height: 80,
                                      decoration: BoxDecoration(
                                        //color: Color(0xFFFFC6D3),//Color(0xFFFFE5F1),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              //Icon(Icons.add,color: Colors.green,size: 20),
                                              Spacer(),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text("Gelenler",style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                  fontFamily: "NotoSans",
                                                ),),
                                              ),
                                              SizedBox(width: 4,)
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 4,),
                                              Text("${toplamGelir.toStringAsFixed(2)}",style: TextStyle( //340.000
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "NotoSans",
                                              ),),
                                              SizedBox(width: 4,),
                                              Text("TL",style: TextStyle( //340.000
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "NotoSans",
                                              ),),
                                              SizedBox(width: 4,)
                                            ],
                                          ),
                                          Spacer(),
                                          SizedBox(height: 16,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          /// Gider/Gelen Ekle
                          Container(
                            height: 30,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent.withOpacity(0.8)
                                    ),
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewProcessSC(processType: "Gider")));
                                    },
                                    child: Text("Ekle"),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green.withOpacity(0.8)
                                    ),
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewProcessSC(processType: "Gelir")));
                                    },
                                    child: Text("Ekle"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          /// DropDownList Hepsi/Bugün
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left:16,top: 8,right: 4,bottom: 8),
                                  height: 44,
                                  decoration: BoxDecoration(
                                      color: Color(0xFCFEDB39).withOpacity(0.3),//Color(0xFFFF6F6C9),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      borderRadius: BorderRadius.circular(12),
                                      isDense: true,
                                      value: selectedIslemDurumu,
                                      items: listIslemDurumu.map<DropdownMenuItem<String>>((String value){

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
                                          selectedIslemDurumu=selectedData!;
                                        });
                                        print("İşlem durumu: ${selectedIslemDurumu}");
                                        list=await VeritabaniDao().gelirGiderBilgileri(islemTuru: selectedIslemDurumu, zaman: selectedIslemGunAraligi);
                                        //getLocal();
                                        setState(() {
                                          list;
                                        });

                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left:16,top: 8,right: 4,bottom: 8),
                                  height: 44,
                                  decoration: BoxDecoration(
                                      color: Color(0xFCFEDB39).withOpacity(0.3),//Color(0xFFFF6F6C9),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      borderRadius: BorderRadius.circular(12),
                                      isDense: true,
                                      value: selectedIslemGunAraligi,
                                      items: listIslemGunAraligi.map<DropdownMenuItem<String>>((String value){

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
                                          selectedIslemGunAraligi=selectedData!;
                                        });
                                        print("İşlem Tarihi: ${selectedIslemGunAraligi}");
                                        list=await VeritabaniDao().gelirGiderBilgileri(islemTuru: selectedIslemDurumu, zaman: selectedIslemGunAraligi);
                                        //getLocal();
                                        setState(() {
                                          list;
                                        });

                                        /*
                                getLocal(aktif_pasif: selectedAktifPasif);

                                */

                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          /// Liste
                          Flexible(
                              child: ListView.builder(
                                  itemCount: list.length,
                                  //reverse: true,
                                  //shrinkWrap: true,
                                  itemBuilder: (context,index){
                                    return Column(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(left: 4,top: 5,right: 4,bottom: 5),
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              //color: Color(0xFFBFEAF5).withOpacity(0.3),
                                              //color: Colors.grey[200],
                                              borderRadius: BorderRadius.circular(8),
                                              //border: Border.all(color: Colors.grey,width: 0.2)
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets.all(8),
                                                              decoration: BoxDecoration(
                                                                color: Colors.orangeAccent,//Colors.grey[350]
                                                              ),
                                                              child: Text(list[index].tarih.substring(8,10),style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.white,
                                                                fontFamily: "NotoSans",
                                                              )),
                                                            ),
                                                            SizedBox(height: 4,),
                                                            Text("${listMonth[int.parse(list[index].tarih.substring(5,7))-1]}",style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily: "NotoSans",
                                                            ),),
                                                            /*
                                                    Text("14:30:12",style: TextStyle(
                                                        fontSize: 11
                                                    ),)
                                                    */
                                                          ],
                                                        )),
                                                    Expanded(
                                                        flex: 9,
                                                        child: Container(
                                                          //color: Colors.teal,
                                                          child: Column(
                                                            children: [
                                                              SizedBox(height: 4,),
                                                              Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Container(
                                                                  child: Text(list[index].aciklama,style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontFamily: "NotoSans",
                                                                  )),
                                                                ),
                                                              ),
                                                              SizedBox(height: 4,),
                                                              list[index].islem_tipi=="Gelir"?
                                                              Align(
                                                                  alignment: Alignment.centerRight,
                                                                  child: Text(list[index].tutar.toStringAsFixed(2)+" TL",style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w500,
                                                                    color: Colors.green,
                                                                    fontFamily: "NotoSans",
                                                                  ))):
                                                              Align(
                                                                  alignment: Alignment.centerRight,
                                                                  child: Text(list[index].tutar.toStringAsFixed(2)+" TL",style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w500,
                                                                    color: Colors.redAccent,
                                                                    fontFamily: "NotoSans",
                                                                  ))),
                                                            ],
                                                          ),
                                                        ))

                                                  ],
                                                )
                                              ],
                                            )
                                        ),
                                        SizedBox(height: 4,),
                                      ],
                                    );
                                  }
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 6,),
                    /// 55
                    /*
                  Container(
                    //color: Colors.teal,
                    color: Colors.grey[350],
                    height: staticAd.size.height.toDouble(),//height: 55,
                    width: staticAd.size.width.toDouble(),
                    //width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: AdWidget(ad: staticAd),//Text("REKLAM ALANI")
                    ),
                  ),
                  */

                    //SizedBox(height: 10,)


                    /*
                  ///Liste Card
                  Column(
                    children: List.generate(list.length, (index) => Column(
                      children: [
                        Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 4,top: 5,right: 4,bottom: 5),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.orangeAccent,//Colors.grey[350]
                                                  ),
                                                  child: Text(list[index].tarih.substring(0,2),style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white
                                                  )),
                                                ),
                                                SizedBox(height: 4,),
                                                Text("${listMonth[int.parse(list[index].tarih.substring(3,5))-1]}",style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                                /*
                                                Text("14:30:12",style: TextStyle(
                                                    fontSize: 11
                                                ),)
                                                */
                                              ],
                                            )),
                                        Expanded(
                                            flex: 9,
                                            child: Container(
                                              //color: Colors.teal,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 4,),
                                                  Container(
                                                    child: Text(list[index].aciklama,style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500
                                                    )),
                                                  ),
                                                  SizedBox(height: 4,),
                                                  list[index].islem_tipi=="GELİR"?
                                                  Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Text(list[index].tutar+" TL",style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.green
                                                      ))):
                                                  Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Text(list[index].tutar+" TL",style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.redAccent
                                                      ))),
                                                ],
                                              ),
                                            ))

                                      ],
                                    )
                                  ],
                                )
                            ),
                            SizedBox(height: 4,),
                          ],
                        )
                      ],
                    )).reversed.toList(),
                  ),
                  */
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
