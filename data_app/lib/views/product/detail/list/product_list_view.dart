// ignore_for_file: prefer_const_constructors

import 'package:data_app/controller/product_controller.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/views/product/detail/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// read : 창고읽고 한번만 갱신
// watch (while): 창고 읽어서 화면 지속적으로 갱신 - rebuild가 됨
// listen (while) : 창고 읽어서 지속적인 행위를 할 때 쓴다. - rebuil 필요 없는 부분을 listen을 사용함.
class ProductListView extends ConsumerWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pm = ref.watch(productListViewStore);
    final pc = ref.read(productController);

    // pc.findAll(); View는 Store를 계속 watch를 하고있다. findAll을 호출하면 뷰가 갱신되고 리빌드를 하러 가기 때문에 무한 루프를 돌게 된다.
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          pc.findAll();
          pc.insert(Product(id: 4, name: '호박', price: 2000));
        },
      ),
      appBar: AppBar(title: Text("product_list_page")),
      body: _buildListView(pm, pc),
    );
  }

  Widget _buildListView(List<Product> pm, ProductController pc) {
    if (!(pm.length > 0)) {
      return Center(
          child: Image.asset(
        "assets/image/giphy.gif",
        width: 400,
        height: 400,
      ));
    } else {
      return ListView.builder(
        itemCount: pm.length,
        itemBuilder: (context, index) => ListTile(
          key: ValueKey(pm[index]
              .id), // ListTile 키 값은 내부적으로 같은 데이터가 있을 시 id를 보고 구분을 하기 때문에 중요하다
          // 키를 주는 가장 좋은 방법은 DB의 프라이머리 키를 준다.
          onTap: () {
            pc.deleteById(pm[index].id);
          },
          onLongPress: () {
            pc.updateById(
                pm[index].id, Product(id: 0, name: "호박", price: 99999999));
          },

          leading: Icon(Icons.account_balance_wallet),
          title: Text(
            "${pm[index].name}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("${pm[index].price}"),
        ),
      );
    }
  }
}
