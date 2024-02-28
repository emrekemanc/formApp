import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formapp/loginPage.dart';
import 'package:formapp/mainPage.dart';



class formPage extends StatefulWidget{
  @override

 formPageState createState()=> formPageState();
}

class formPageState extends State<formPage>{
 
final _formKey = GlobalKey<FormState>();
late String nameSurname;
late String nickName;
late String eMail;
late String password;
  
   @override
Widget build(BuildContext context) {

  return Scaffold(appBar: AppBar(title: Text("Register Page"),),
    resizeToAvoidBottomInset: false,
  body: Form(
    key: _formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        nameAndSurnameClass(),
        SizedBox(height:10),
        nickNameClass(),
        SizedBox(height:10),
         eMailClass(),
         SizedBox(height:10),
         passwordClass(),
         SizedBox(height:10),
        loginClass(),
        SizedBox(height: 10,),
       registerClass()
    ]
    ),
  ),
  );
}
//Ad Soyad
Widget nameAndSurnameClass()=>Container(
   child: Column(
            children: [
               const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:25),
                    child: Text("Name And Surname",style: TextStyle(
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
                         return "Please Enter Your Name And Surname";
                      }else{
                       
                        return null;
                      }
                    },
                    onSaved: (newValue) {
                     nameSurname=newValue!;
                   },
                    )
                    )
              
            ],
          ),
);
//kullanici Adi
Widget nickNameClass()=>Container(
child: Column(
            children: [
               const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:25),
                    child: Text("Nick Name",style: TextStyle(
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
                        return "Please Enter Your Nickname";
                      }else{
                          return null;
                      }
                    },
                  onSaved: (newValue) {
                     nickName=newValue!;
                   },
                    )
                    )
              
            ],
          ),
);
//E-Posta 
Widget eMailClass()=>Container(
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
                        return "Please Enter Your E-Mail";
                   
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
);
//Sifre
Widget passwordClass()=>Container(
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
);

//Giriş Yap
Widget  loginClass()=>Container(
 child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>loginPage()));
              
              }, child: Text("Login")
              ),
            )
            ],
          ),
);
//Üye Ol
Widget registerClass()=>ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(200, 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
        ),
          child: const Text("Register",style: TextStyle(
            color: Colors.black
            ,fontSize: 17),
            ),
            onPressed: () async {
          if(_formKey.currentState!.validate()){
            _formKey.currentState!.save();
            try {
              final user = FirebaseAuth.instance.createUserWithEmailAndPassword(email: eMail, password: password);
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