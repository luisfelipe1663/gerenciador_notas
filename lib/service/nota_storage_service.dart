import 'dart:async';
import 'dart:convert';
import 'package:gerenciador_de_notas/modules/nota.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Serviço: separa as regras de aramazenamento do widgets da tela
class NotaStorageService {
  //a chave funciona como o nome do espaço onde guardamos o texto

  //Chave antiga guardava apenas uma nota
  static const String chaveAntiga = 'nota_inicial';

  //chave que identifica a lista no armazenamento local
  static const String chaveNota = 'lista_notas';
  //SharedPreferencesAsync lê e grava valores simples no dispositivo

  //final impede _perfs receba outra instancia depois de criada
  final SharedPreferencesAsync _perfs = SharedPreferencesAsync();

// Future<List<Nota>> indica que no futuro vira uma lista
// async permite que use await durante a leitura do dispositivo
  Future<List<Nota>> listarNota() async {

    // permite o texto ou null
    final String? texto = await _perfs.getString(chaveNota);
    // se não a lista salva, verificamos a nota da aula 1
    if (texto == null) {
      final String? antiga = await _perfs.getString(chaveAntiga);

      //Tratando lsita null ou com espaço 
      if (antiga == null || antiga.trim().isEmpty) {
        return [];//pode retornar lista vazia caso esteja null
      }

        // transformando a anotação antiga em uma nota completa
      final Nota primeira = Nota(
        //Horario e mmicrossegundos para gerar um identificador simples
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        titulo: 'Minha primeira Nota',
        conteudo: antiga,
      );
      //Salvar a nota no formato novo e remover a chave antiga 
      await salvarLista([primeira]);
      await _perfs.remove(chaveAntiga);
      return [primeira];
    }

  //jsonDecode tranforma o texto em json em estruturas Dart.
  //List<dynamic> informa que esperamos uma lista
    final List<dynamic> dados = jsonDecode(texto) as List<dynamic>; 
    // map() percorrer cada elemento e transformar em nota
    //.toList() materializa o resultado como  lista Dart.
    return dados.map((item) {
      return Nota.fromMap(item as Map<String, dynamic>);
    }).toList();
  }

  //Recebe o texto e o armazena, não devolve resultado
  Future<void> salvarNota(String texto) async {
    //setString associa a String a chave escolhida
    await _perfs.setString(chaveNota, texto);
  }


//recebe a lisat completa e grava a sua versão atualizada
Future<void> salvarLista (List<Nota>notas) async {
  //convertendo cada objeto Nota para Map com o toMap().
  final List<Map<String,dynamic>> dados = notas.map((nota){
    return nota.toMap();
  }).toList();

//jsonEncode transforma a lista Maps em texto Json
  final String texto = jsonEncode(dados);

  //await aguarda a conclusão da gravação no dispositivo
  await _perfs.setString(chaveNota, texto);
}

//Acrescenta uma nova nota sem apagar os registro anteriores
Future<void>adicionarNota(Nota novaNota) async{
  //Primeiro recuperou tudo que estava salvo
  final List<Nota> notas = await listarNota();
  notas.add(novaNota);//insere a nova nota no fim da lista
  await salvarLista(notas);//grava a lista inteira novamente
}

}