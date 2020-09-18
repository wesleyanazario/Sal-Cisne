import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_salcisne/lista_produtos/domain/entity/produto_entity.dart';

import '../bloc/lista_produtos_bloc.dart';

class ListaProdutosWidget extends StatelessWidget {
  const ListaProdutosWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListaProdutosBloc _listaProdutosBloc =
        BlocProvider.of<ListaProdutosBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de produtos')),
      body: Center(
        child: BlocBuilder<ListaProdutosBloc, ListaProdutosState>(
          bloc: _listaProdutosBloc,
          builder: (context, state) {
            if (state is ListaProdutosInitial) {
              print(state);
              _listaProdutosBloc.add(GetListaProdutos());
            } else if (state is Error) {
              print(state.message);
            } else if (state is Loading) {
            } else if (state is ListaCarregada) {
              print(state.produtos.length);

              return ListView(
                children: [
                  _boxInfo(context, state.produtos.length),
                  for (var item in state.produtos) _boxContaudo(context, item),
                ],
              );
            }
            return Container(
              child: Text(
                "Carregando Produtos",
              ),
            );
          },
        ),
      ),
    );
  }

  _boxContaudo(BuildContext context, Produto produto) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 5,
        left: 10,
        right: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.blueAccent,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Column(
          children: [
            //Text(produto.quantidade.toString()),

            _texto("Nome : " + produto.nome, Colors.black),
            _texto(
                "Quantidade : " + produto.quantidade.toString(), Colors.black),
            _texto("Local : " + produto.local, Colors.black),

            // _texto("texto"),
          ],
        ),
      ),
    );
  }

  _boxInfo(BuildContext context, int num) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black45,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: _texto(
            num.toString() + " - Produros encontrados", Colors.blueAccent),
      ),
    );
  }

  _texto(String texto, Color cor) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5,
        left: 5,
        right: 5,
        bottom: 5,
      ),
      child: Row(
        children: [
          Text(
            texto,
            style: TextStyle(
              color: cor,
            ),
          ),
        ],
      ),
    );
  }
}
