import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  final String label;
  final TextEditingController controller;
  final int maxLines;  //quantidade de linhas o campo pode exibir

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.maxLines = 1
  });

  @override
  Widget build(BuildContext context) {
    //TextField desenha o campo editavel na interface
    return TextField(
      controller: controller, //conectar com o campo controller
      maxLines: maxLines,//aplica a quantidade de linhas
      decoration: InputDecoration(
        labelText: label,//mostra o nome do campo
        border: const OutlineInputBorder() //Bordas visiveis
      ),
    );
    
  }
}