

import 'package:flutter/material.dart';
import 'package:gerenciador_de_notas/screen/home_screen.dart';

//StatefulWidget: a tela precisa executar ações no seu ciclo 
class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

//initState() roda ua vez. quando o estado é criado
  @override void initState(){
    super.initState(); // mantém a inicialização da classe pai
    abrirHome();//Inicia a espera e a troca de tela
  }
    //Future<void> : operação assincrona que não retorna valor
 Future<void> abrirHome() async {
  //aguarda 2 segundos sem travar a interface
  await Future.delayed(const Duration(seconds: 2));

  //Se o monted é falso, se esta tela já foi removida da arvore.
  //Não podemos usar context para navegar depois disso
  if(!mounted) return;

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder:(context) => HomeScreen() ),
  );

 }

  @override
  Widget build(BuildContext context) {
    //Scaffold Fornece uma estrutura visual da tela Material
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 56, 83, 151),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, //ocupar so o necessario
        children: [
            Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.library_books_rounded,
              size: 65,
              color: Color.fromARGB(255, 56, 83, 151),
            ),
          ),
          const SizedBox(height: 12),

            Text('Gerenciador de Notas',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
           ],
      ),
    ),
  );
  }
}