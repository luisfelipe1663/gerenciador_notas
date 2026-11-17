import 'package:flutter/material.dart';
import 'package:gerenciador_de_notas/service/nota_storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Controller permite ler o conteudo digitado no Textfield
  final TextEditingController _controller = TextEditingController();

  final TextEditingController _tituloController =
    TextEditingController();

  //Intancia do serviço : a tela não acessa o pacote diretamente
  final NotaStorageService _storage = NotaStorageService();

  //guarda o texto que a interface mostra abaixo dos botões
  String _notaSalva = '';

  @override
  void initState() {
    super.initState();
    carregarNota(); //recuperar o valor ao abrir a home
  }

  //busca o texto salvo, espera a leitura e atualiza a interface
  Future<void> carregarNota() async {
    final String texto = await _storage.buscarNota();
    if (!mounted) return; // verifica se a tela ainda esta disponivel
    // final String titulo = await _storage.buscarTitulo();

    setState(() {
      _notaSalva = texto; //atualiza o texto marcado na tela
      _controller.text = texto; // preenche o campo com o valor salvo
      // _tituloController.text = titulo;
    });
  }

//Função de chamada pleo onPressed do botão de salvar
Future<void> salvarNota() async{

  //variavel para armazenar a nota digitada pelo usuario
  final String texto = _controller.text.trim();
  // final String titulo = _tituloController.text.trim();

//verificamos se a nota esta vazia
  if(texto.isEmpty) return; // caso esteja vazia não salvara a nota

  await _storage.salvarNota(texto); //Grava no dispositivo
  // await _storage.salvarTitulo(titulo);
  if(!mounted) return;//Evita atualizar uma tela descartada

  setState(() {
    _notaSalva = texto; //Mostra a versão recem-salva
  });

//Informamos ao usuario que a ação filanizou
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Nota Salva no dispositivo'))
  );
}

  //Função para apagar uma nota
  Future<void> apagatNota() async{
    await _storage.apagatNota();//Remove o valor persistido
    if(!mounted) return;

    setState(() {
      _notaSalva = ''; //Limpa o texto exibido, atualiza ele para vazio
      _controller.clear();//Limpa o campo de entrada
      _tituloController.clear();
    });
  }

  @override
  void dispose() {
    //libera o controller quando o flutter descarta essa tela
    _controller.dispose();
    super.dispose();
    _tituloController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Notas')),
      body: Padding(padding: const EdgeInsets.all(20),
       child: Column( 
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Minha primeira anotação'),

          const SizedBox(height: 12),

          TextField(
            controller: _controller, //conecta o campo ao controller
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Escreva uma anotação...'
            ),
          ),

           TextField(
            controller: _tituloController, //conecta o campo ao controller
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Escreva um titulo para a nota'
            ),
          ),

            const SizedBox(height: 12),

            FilledButton(
              onPressed: salvarNota,
             child: const Text('Salvar no dispositivo')),

             OutlinedButton(
              onPressed: apagatNota,
               child:const Text('Apagar nota salva')),

                const SizedBox(height: 12),

                const Text('Nota recuperada do armazenamento:'),
                const SizedBox(height: 12),

          
                Text(_notaSalva.isEmpty ? 'nenhuma nota salva' : _notaSalva)
        ],
      )
      ),
    );
  }
}
