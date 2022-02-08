import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:login_service/app/core/error/failure.dart';
import 'package:login_service/app/modules/home/domain/entities/product_entity.dart';
import 'package:login_service/app/modules/home/presenter/components/card_product_component.dart';

import 'components/button_exit_component.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  void _bottomSheetLogin(context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showModalBottomSheet(
          isDismissible: false,
          context: context,
          builder: (BuildContext bc) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 180,
              child: Column(children: [
                const Text(
                    'Sua sessão expirou, é necessário fazer login novamente'),
                const SizedBox(height: 40),
                ElevatedButton(
                    onPressed: () async {
                      await store.logout();
                      Modular.to.pushReplacementNamed('/login/');
                    },
                    child: const Text('Fazer login'))
              ]),
            );
          });
    });
  }

  @override
  void initState() {
    store.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          ButtonExitComponent(
            onTap: () async {
              await store.logout();
              Modular.to.pushReplacementNamed('/login/');
            },
          ),
        ],
      ),
      body: ScopedBuilder<HomeStore, Failure, List<ProductEntity>>(
        store: store,
        onState: (_, list) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: CardProductComponent(product: list[index]),
              );
            },
          );
        },
        onError: (context, error) {
          //ConnectionError, ErrorProduct
          if (error is ErrorExpirationToken) {
            _bottomSheetLogin(context);
            return Container();
          } else {
            return Center(child: Text(error!.errorMessage));
          }
        },
        onLoading: (context) {
          return const Center(
            child: Text('Carregando produtos...'),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          store.fetchProducts();
        },
        child: const Text('Buscar produtos'),
      ),
    );
  }
}
