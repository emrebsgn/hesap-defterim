import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hesap_defterim/dao/veritabanidao.dart';
import 'package:hesap_defterim/model/model_gelir_gider.dart';
import 'package:hesap_defterim/pages/add_account.dart';
import 'package:hesap_defterim/pages/add_new_process_sc.dart';
import 'package:hesap_defterim/pages/anasayfa.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hesap Defterim',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('tr','TR'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hesap Defterim'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Future<bool>notRedirectPage()async{
    return false;
  }

  @override
  void initState() {
    super.initState();
  }
  var listAccount=<String>["Müşteri","Özel","Hesap Oluştur"];

  int selectedIndex=-99;


  @override
  Widget build(BuildContext context) {
    var screenInfos=MediaQuery.of(context); //Burada ekran boyutu alınacak.
    final double screenWidth=screenInfos.size.width;
    final double screenHeight=screenInfos.size.height;
    return Scaffold(
      body: WillPopScope(
        onWillPop:()=>notRedirectPage(),
        child: Column(
          children: [
            Container(
                //color: Colors.teal,
                constraints: BoxConstraints(
                    maxHeight: screenHeight-65
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //color: Colors.teal,
                            child: Padding(
                              padding: EdgeInsets.only(left:22,right: 22),
                              child: Column(
                                children: [
                                  SizedBox(height: 15,),
                                  Image.asset("images/hesap_defterim.png",
                                    width: MediaQuery.of(context).orientation ==Orientation.portrait
                                        ?MediaQuery.of(context).size.height>821? 100: MediaQuery.of(context).size.width<321? 90:120
                                        :MediaQuery.of(context).size.height>551? 100:MediaQuery.of(context).size.height<321?90:120,
                                  ),
                                  SizedBox(height: 20,),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: EdgeInsets.only(left:12,right: 12),
                            child: Container(
                              width: screenWidth,
                              height: 250,
                              //color: Colors.orangeAccent,
                              color: Colors.grey[100],
                              child: Column(
                                children: [
                                  listAccount.isEmpty?Center():
                                      Flexible(
                                        child: ListView.builder(
                                          itemCount: listAccount.length,
                                          itemBuilder: (context,index){
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      if(listAccount[index]!="Hesap Oluştur"){
                                                        setState(() {
                                                          selectedIndex=index;
                                                        });
                                                        Future.delayed(Duration(milliseconds: 420),() => Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa())),);
                                                      }else{
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAccount()));
                                                      }
                                                    });
                                                  },
                                                  child: Card(
                                                    margin: EdgeInsets.only(top: 2,bottom: 2),
                                                    child: Container(
                                                      padding: EdgeInsets.only(top: 4,bottom: 4),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(width: 10,),
                                                          Container(
                                                            width: 60,
                                                            height: 60,
                                                            decoration: BoxDecoration(
                                                                color: listAccount[index]=="Hesap Oluştur"? Colors.lightGreen.withOpacity(0.7):Colors.orangeAccent.withOpacity(0.6),//Colors.grey[300],
                                                                shape: BoxShape.circle
                                                            ),
                                                            child: IconButton(
                                                              onPressed: (){
                                                                print("Tıklandı");
                                                              },
                                                              icon:listAccount[index]=="Hesap Oluştur"?
                                                              Icon(Icons.add,size: 40,color: Colors.white,):
                                                              Text("${index+1}",style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w400,
                                                                fontFamily: "NotoSans",
                                                              ),),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Text(listAccount[index],style: TextStyle(//200.000
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: "NotoSans",
                                                          ),),
                                                          Spacer(),
                                                          listAccount[index]=="Hesap Oluştur"?Center():Container(
                                                            width: 10,
                                                            height: 10,
                                                            decoration: BoxDecoration(
                                                                color: selectedIndex==index?Colors.green:Colors.transparent,
                                                                shape: BoxShape.circle
                                                            ),
                                                          ),
                                                          SizedBox(width: 8,),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text("AsBey Bilişim",style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "NotoSans",
                          ),),
                          SizedBox(height: 4,),
                          Text("© Tüm Hakları Saklıdır.  ",style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "NotoSans",
                          ),)

                        ],
                      ),
                    ),
                  ),
                )
            ),
            Column(
              children: [
                Container(
                  width: screenWidth,
                  height: 60,
                  //color: Colors.grey[300],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
