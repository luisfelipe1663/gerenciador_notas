//Este arquivo é responsavel por definir o formato de cada anotação
//Classe não desenha tela, nem salva dados.
class Nota {
  final String id;
  final String titulo;
  final String conteudo;
  //O construtor recebe os valores ao criar a nota
  //required obriga o usuario a informar o parametro nomeado
  //this.id atribui o parametro ao atributo id do objeto
  const Nota({
    required this.id,
    required this.titulo,
    required this.conteudo});

  //Map relaciona cada chave String ao seu valor
  //dynamic permite valores de diferentes tipos no mapa
  //Converter para MAP facilita transformar o objeto em JSON
  Map<String,dynamic> toMap() {
    return {
      'id': id, // chave 'id' recebe o atrubuto id
      'titulo': titulo,
      'conteudo': conteudo,
    };
  }

//factory permite criar uma nota usando dados ja existentes
//map['id'] lê o valor associado a chavr 'id'
//as String informa que estamos esperando um texto nesse campo
  factory Nota.fromMap(Map<String,dynamic> map){
    return Nota(
      id: map['id'] as String,
      titulo: map['titulo'] as String,
      conteudo: map['conteudo'] as String
    );
  }
}
