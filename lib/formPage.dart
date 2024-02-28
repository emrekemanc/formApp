import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formapp/mainPage.dart';



class formPage extends StatefulWidget{
  @override

 formPageState createState()=> formPageState();
}

class formPageState extends State<formPage>{
 
final _formKey = GlobalKey<FormState>();
late String adSoyad;
late String kullaniciAdi;
late String e_posta;
late String sifre1;
  
   @override
Widget build(BuildContext context) {

  return Scaffold(appBar: AppBar(title: Text("Kayıt ol"),),
    resizeToAvoidBottomInset: false,
  body: Form(
    key: _formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        nameAndSurname(),
        SizedBox(height:10),
        nickName(),
        SizedBox(height:10),
         eMail(),
         SizedBox(height:10),
         password(),
         SizedBox(height:10),
        login(),
        SizedBox(height: 10,),
       register()
    ]
    ),
  ),
  );
}
//Ad Soyad
Widget nameAndSurname()=>Container(
   child: Column(
            children: [
               const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:25),
                    child: Text("Ad Soyad",style: TextStyle(
                      fontSize: 15
                    ),),
                  )
                  ],
                  ),Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 3),
                    child:TextFormField(
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                    validator: (value) {
                      if(value!.isEmpty){
                         return "Adınızı Ve Soyadınızı Giriniz";
                      }else{
                       
                        return null;
                      }
                    },
                    onSaved: (newValue) {
                     adSoyad=newValue!;
                   },
                    )
                    )
              
            ],
          ),
);
//kullanici Adi
Widget nickName()=>Container(
child: Column(
            children: [
               const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:25),
                    child: Text("Kullanıcı Adı",style: TextStyle(
                      fontSize: 15
                    ),),
                  )
                  ],
                  ),Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 3),
                    child:TextFormField(
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Lütfen Kullanıcı Adınızı Giriniz";
                      }else{
                          return null;
                      }
                    },
                  onSaved: (newValue) {
                     kullaniciAdi=newValue!;
                   },
                    )
                    )
              
            ],
          ),
);
//E-Posta 
Widget eMail()=>Container(
   child: Column(
            children: [
               const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:25),
                    child: Text("E-Posta",style: TextStyle(
                      fontSize: 15
                    ),),
                  )
                  ],
                  ),Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 3),
                    child:TextFormField(
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Lütfen E-Posta Giriniz";
                   
                      }else{
                         return value.contains(RegExp(r'[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}'))? 
                         null : "Geçerli Eposta değil";
                      }
                    },
                    onSaved: (newValue) {
                     e_posta=newValue!;
                   },
                    )         
    ) ],
          ),
);
//Sifre
Widget password()=>Container(
  child: Column(
            children: [
               const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:25),
                    child: Text("Şifre",style: TextStyle(
                      fontSize: 15
                    ),),
                  )
                  ],
                  ),Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 3),
                    child:TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Lütfen Şifre Giriniz";
                      }else{
                        return null;
                      }
                    },
                   onSaved: (newValue) {
                     sifre1=newValue!;
                   },
                    )
                    )
              
            ],
          ),
);

//Giriş Yap
Widget  login()=>Container(
 child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
              
              }, child: Text("Giriş Yap")
              ),
            )
            ],
          ),
);
//Üye Ol
Widget register()=>ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(200, 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
        ),
          child: const Text("Üye Ol",style: TextStyle(
            color: Colors.black
            ,fontSize: 17),
            ),
            onPressed: () async {
          if(_formKey.currentState!.validate()){
            _formKey.currentState!.save();
            try {
              final user = FirebaseAuth.instance.createUserWithEmailAndPassword(email: e_posta, password: sifre1);
              if(user!=null){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>mainPage()));
              }
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
  } else if (e.code == 'email-already-in-use') {
  }
} catch (e) {
  print(e);
}

          }
          
        }
);
}