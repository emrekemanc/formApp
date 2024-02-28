
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formapp/mainPage.dart';


class loginPage extends StatefulWidget{
  @override
  
loginPagestate createState()=>loginPagestate();

}
class loginPagestate extends State<loginPage>{
  final _formKey = GlobalKey<FormState>();
   late String password;
   late String eMail;
  @override
  Widget build(BuildContext context) {
   
   return Scaffold(
    appBar: AppBar(title: Text("Login Page"),
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
                    child: Text("E-Mail",style: TextStyle(
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
                        return "Please Enter Your E-Mail ";
                   
                      }else{
                         return value.contains(RegExp(r'[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}'))? 
                         null : "Please Enter In Valid E-Mail";
                      }
                    },
                    onSaved: (newValue) {
                     eMail=newValue!;
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
                    child: Text("Password",style: TextStyle(
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
                        return "Please Enter Your Password";
                      }else{
                        return null;
                      }
                    },
                   onSaved: (newValue) {
                     password=newValue!;
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
          child: const Text("Login",style: TextStyle(
            color: Colors.black
            ,fontSize: 17),
            ),
            onPressed: () async {
              if(_formKey.currentState!.validate()){
                _formKey.currentState!.save();
              }
              try{
             final user= await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: eMail,
              password: password
             );
             if(user!=null){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>mainPage()));
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
