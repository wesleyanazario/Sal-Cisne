import 'dart:convert';
import 'dart:io';

import 'package:teste_salcisne/lista_produtos/domain/entity/produto_entity.dart';
import 'package:http/http.dart' as http;

import '../domain/client/lista_produtos_client.dart';

class ProdutosClientImpl implements ProdutosClient {
  final String url = 'http://192.168.1.180:8080/estoque/find-all';
  var client = http.Client();

  // List<Produto> produtos = [
  //   Produto(nome: "Produto 1", local: "Local A", quantidade: 20),
  //   Produto(nome: "Produto 2", local: "Local B", quantidade: 18),
  //   Produto(nome: "Produto 3", local: "Local C", quantidade: 16),
  // ];

  @override
  Future<List<Produto>> getListaProdutos() async {
    print("CHAMADA DA API");
    List<Produto> produtos = new List<Produto>();
    //return produtos;
    try {
      var _response = await client.get(url);

      if (_response.statusCode == HttpStatus.ok) {
        final _json = json.decode(_response.body);
        for (var item in _json) {
          produtos.add(Produto(
              nome: item['produto']['nome'],
              local: item['filial']['endereco'],
              quantidade: item['qtd']));
        }
        return produtos;
      } else {
        throw http.ClientException("Houve um erro na requisição");
      }
    } catch (e) {
      throw http.ClientException("Erro inesperado");
    }
  }
}
