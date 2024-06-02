import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hesap_defterim/model/model_gelir_gider.dart';

import '../VeriTabaniYardimcisi.dart';
import '../alert_class/alert_message.dart';

class VeritabaniDao{



  ///                                                Gelir Gider Bilgileri

  Future<List<ModelGelirGider>> gelirGiderBilgileri({ required String islemTuru,required String zaman})async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    String sorgu="SELECT * from gelirgidertable";

    DateTime date=DateTime.now();
    String strDate=date.toString().substring(0,10);



    if(islemTuru=="Hepsi"){
      print("HEPSİ");
      if(zaman=="Bugün"){
        print("Bugün");
        //sorgu="select * from gelirgidertable WHERE tarih BETWEEN '2022-12-28' AND '2022-12-29'";
        sorgu="select * from gelirgidertable WHERE tarih BETWEEN '${strDate}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
        //sorgu="select * from gelirgidertable WHERE tarih BETWEEN '${strDate}' AND '2022-12-29'";
      }else if(zaman=="Dün"){
        print("Dün");
        //sorgu="SELECT * from gelirgidertable WHERE";
        sorgu="select * from gelirgidertable WHERE tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Son 7 gün"){
        print("Son 7 gün");
        sorgu="select * from gelirgidertable WHERE tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-7).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Son 15 gün"){
        print("Son 15 gün");
        sorgu="select * from gelirgidertable WHERE tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-15).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Bu Ay"){
        print("Bu Ay");
        sorgu="select * from gelirgidertable WHERE tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,1).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else{

      }
    }else if(islemTuru=="Gelenler"){
      if(zaman=="Bugün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gelir' AND tarih BETWEEN '${strDate}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Dün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gelir' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Son 7 gün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gelir' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-7).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Son 15 gün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gelir' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-15).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Bu Ay"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gelir' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,1).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }

    }else if(islemTuru=="Gidenler"){
      /*
      print("Alternatif 2");
      sorgu="SELECT * from gelirgidertable WHERE islem_tipi='GİDER'";
      */
      if(zaman=="Bugün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gider' AND tarih BETWEEN '${strDate}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Dün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gider' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Son 7 gün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gider' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-7).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Son 15 gün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gider' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-15).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Bu Ay"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gider' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,1).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }
    }else if(zaman=="TÜMÜ"){
      sorgu="SELECT * from gelirgidertable islem_tipi='Gider'";
    }else{

    }



    List<Map<String,dynamic>> maps=await db.rawQuery(sorgu);

    return List.generate(maps.length, (i) {

      var satir=maps[i];
      print("BAAAAAAK: ${satir["tutar"]}");

      late double tutar;

      if(satir["tutar"].toString().contains(".")){
        tutar=satir["tutar"];
      }else{
        tutar=double.parse(satir["tutar"].toString()+".0");
      }

      print("BAAAKMA :${tutar}");
      return ModelGelirGider(
        satir["gelir_gider_ID"],
        satir["islem_tipi"],
        satir["tarih"],
        satir["aciklama"],
        tutar,
      );

    });
  }

  Future<double>islemTipiToplami({required islemTipi})async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    String sorgu="SELECT SUM (tutar) as toplamGider FROM gelirgidertable WHERE islem_tipi='${islemTipi}'";
    //double toplam=5;
    print("new sorgu: ${sorgu}");

    //var a= await db.rawQuery(sorgu);

    List<Map<String,dynamic>> maps=await db.rawQuery(sorgu);
    if(maps[0]["toplamGider"]==null){
      print("Null olduğu için ilk return'e girmektedir.");
      return 0;
    }else{
      print("ikinci return. ${maps[0]["toplamGider"]}");
      var toplamGider=maps[0]["toplamGider"];
      if(toplamGider.toString().contains(".")){
        return toplamGider;
      }else{
        return double.parse(toplamGider.toString()+".0");
      }
      //return maps[0]["toplamGider"];
    }



    /*
      List.generate(maps.length, (i) {

      var satir=maps[i];

      return ModelGelirGider(
        satir["gelir_gider_ID"],
        satir["islem_tipi"],
        satir["tarih"],
        satir["aciklama"],
        satir["tutar"],
      );
*/

  }



  Future<void>tableClear(String tableName)async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    await db.execute("DELETE FROM ${tableName}");

  }






  ///                                                Cari Güncelle Aktif/Pasif

  /*
  Future<List<ModelCariler>> aktifPasifChange(String tableName,String aktif_pasif,int cari_ID)async{
    //Veri tabanına eriş
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    String idName="";
    if(tableName=="cariler"){
      idName="cari_ID";
    }
    if(tableName=="stoklar"){
      idName="stok_id";
    }

    List<Map<String,dynamic>> maps=await db.rawQuery("UPDATE ${tableName} SET aktif_pasif='${aktif_pasif}' WHERE ${idName}=${cari_ID}");

    return List.generate(maps.length, (i) {

      var satir=maps[i];

      return ModelCariler(
        satir["cari_ID"],
        satir["cari_kod"],
        satir["column1"],
        satir["cari_vdaire_no"],
        satir["cari_vdaire_adi"],
        satir["cari_Email"],
        satir["cari_Ceptel"],
        satir["adr_cadde"],
        satir["adr_mahalle"],
        satir["adr_il"],
        satir["adr_ilce"],
        satir["cari_wwwadresi"],
        satir["adr_ulke"],
        satir["adr_posta_kodu"],
        satir["adr_tel_bolge_kodu"],
        satir["adr_tel_no1"],
        satir["adr_tel_no2"],
        satir["aktif_pasif"],
      );

    });
  }
*/


/*
  Future<void>stokSil(int stok_id)async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    await db.delete("stoklar",where: "stok_id=?",whereArgs: [stok_id] );

  }
  */



  ///                                                Stok Güncelle

  /*
  Future<void> stokUpdate({
    required context,
    required int stok_id,
    required String sto_kod,
    required String sto_isim,
    required String sto_perakende_vergi,
    required String sto_standartmaliyet,
    required String sto_birim1_ad,
    required String sto_GtipNo,
    required String aktif_pasif,

  })async{
    //Veri tabanına eriş
    var db=await VeriTabaniYardimcisi.veritabaniErisim();

    await db.execute(
        "UPDATE stoklar SET sto_kod='${sto_kod}', sto_isim='${sto_isim}', sto_perakende_vergi='${sto_perakende_vergi}', sto_standartmaliyet='${sto_standartmaliyet}', sto_birim1_ad='${sto_birim1_ad}', sto_GtipNo='${sto_GtipNo}', aktif_pasif='${aktif_pasif}' WHERE stok_id=${stok_id}"
    );
  }
*/

/*

  Future<void>tableClear(String tableName)async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    //await db.delete("teklifler",where: "tklf_id=?",whereArgs:[teklif_id] );
    await db.execute("DELETE FROM ${tableName}");

  }
*/


  ///                                                Entegrator Bilgisi Ekle
  Future<void>gelirGiderEkle({
    required var context,
    required String islem_tipi,
    required String tarih,
    required String aciklama,
    required double tutar,

  })async{

    var alert=AlertMessage();
    try{
      //id otomatik oluştuğu için diğer alanları ekleyeceğiz.
      var db=await VeriTabaniYardimcisi.veritabaniErisim();



      var bilgiler=Map<String,dynamic>();
      bilgiler["islem_tipi"]=islem_tipi;
      bilgiler["tarih"]=tarih;
      bilgiler["aciklama"]=aciklama;
      bilgiler["tutar"]=tutar;

      await db.insert("gelirgidertable", bilgiler).then((value){
        //alert.alertRedirectNew(context, Colors.black, "Firma Bilgileri Eklendi",pageName);
        alert.alertInfo(context, Colors.black, "Oluşturuldu");
      });

    }catch(e){
      alert.alertInfo(context, Colors.redAccent, "e: ${e}");
    }
  }


  /*
  ///                                                Firma Bilgileri
  Future<List<ModelEntegrator>> entegratorBilgileri()async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * from entegrator_bilgilerim");

    return List.generate(maps.length, (i) {

      var satir=maps[i];

      return ModelEntegrator(
        satir["ent_ID"],
        satir["ent_vkn"],
        satir["ent_sube"],
        satir["ent_sifre"],
        satir["ent_apikey"],
      );

    });
  }
*/







}