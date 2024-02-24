
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formapp/anaSayfa.dart';


class login extends StatefulWidget{
  @override
  
loginstate createState()=>loginstate();

}
class loginstate extends State<login>{
  final _formKey = GlobalKey<FormState>();
   late String sifre;
   late String eposta;
  @override
  Widget build(BuildContext context) {
   
   return Scaffold(
    appBar: AppBar(title: Text("Giriş Yap"),
    ),
      resizeToAvoidBottomInset: false,
    body:Form(
      key: _formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
                     eposta=newValue!;
                   },
                    )         
               ) ],
          ),
          ),
          SizedBox(height: 20,),
         Container(
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
                     sifre=newValue!;
                   },
                    )
                    )
            ],
          ),
         ),
         SizedBox(height: 70,),
         ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(200, 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
        ),
          child: const Text("Giriş Yap",style: TextStyle(
            color: Colors.black
            ,fontSize: 17),
            ),
            onPressed: () async {
              if(_formKey.currentState!.validate()){
                _formKey.currentState!.save();
              }
              try{
             final user= await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: eposta,
              password: sifre
             );
             if(user!=null){
              print("işlem başarılı");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>anaSayfa()));
             }
            } on FirebaseAuthException catch(e){
               if (e.code == 'user-not-found') {
               print('E_posta Bulunamadı');
            } else if (e.code == 'wrong-password') {
                print('Şifre yanlış');
            }
           }catch(e){
            print(e);
           }
            }
          ),
         ]
      ),
    ) ,
   );
  }

  }
