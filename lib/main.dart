import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  TextEditingController textEditingController = TextEditingController();
  String encryptedText = '';
  String desencryptedText = '';
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8('my 32 length key................')));
  dynamic encrypted;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
           const  SizedBox(height: 30,),
            const Text('Encriptacion', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            TextFormField(
              controller: textEditingController,
            ),
            const SizedBox(height: 20,),
            Text('Encriptado: $encryptedText'),
            const SizedBox(height: 20,),
            Text('Desencriptado: $desencryptedText'),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              encrypted = encrypter.encrypt(textEditingController.text, iv: iv);
              setState(() {
                encryptedText = encrypted.base64;
              });
            }, child: const Text('Encriptar')),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              final decrypted = encrypter.decrypt(encrypted, iv: iv);
              setState(() {
                desencryptedText = decrypted;
              });
            }, child: const Text('Desencriptar')),
        
          ],
        ),
      )
    );
  }
}
