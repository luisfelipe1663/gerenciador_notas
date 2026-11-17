import 'package:shared_preferences/shared_preferences.dart';

//Serviço: separa as regras de aramazenamento do widgets da tela
class NotaStorageService {
  //a chave funciona como o nome do espaço onde guardamos o texto
  static const String chaveNota = 'nota_inicial';

  static const String chavetitulo = 'titulo_nota';
  //SharedPreferencesAsync lê e grava valores simples no dispositivo

  //final impede _perfs receba outra instancia depois de criada
  final SharedPreferencesAsync _perfs = SharedPreferencesAsync();

  //Recebe o texto e o armazena, não devolve resultado
  Future<void> salvarNota(String texto) async{

    //setString associa a String a chave escolhida
    await _perfs.setString(chaveNota,texto);
  }




  //Titulos
  Future<void> salvarTitulo(String texto2) async{

    //setString associa a String a chave escolhida
    await _perfs.setString(chavetitulo,texto2);
  }

  Future<String> buscarTitulo() async{
    //(String?) significa que podemos ter retorno com String null = nulo
    final String? titulo = await _perfs.getString(chavetitulo);
    //?? usamos o texto vazio caso a nota seja null
    return titulo ?? '';
  }

  Future<void> apagarTitulo() async{
    await _perfs.remove(chavetitulo);
  }




  //recupera a nota. Retorna String, mesmo se não existir valor
  Future<String> buscarNota() async{
    //(String?) significa que podemos ter retorno com String null = nulo
    final String? nota = await _perfs.getString(chaveNota);
    //?? usamos o texto vazio caso a nota seja null
    return nota ?? '';
  }
  //exclui somente o valor salvo na chave nota.
  Future<void> apagatNota() async{
    await _perfs.remove(chaveNota);
  }
}