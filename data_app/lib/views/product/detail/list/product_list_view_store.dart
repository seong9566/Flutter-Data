// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:data_app/controller/product_controller.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewStore =
    StateNotifierProvider<ProductListViewStore, List<Product>>((ref) {
  return ProductListViewStore([], ref)
    ..initViewModel(); // ListView가 실행되면 처음 시작할때 바로 초기화 하는 코드 -> ..문법
});

// 빈배열, ref가 들어감 ( ref를 넣는 이유 httpRepository를 쓰기 위함 )
class ProductListViewStore extends StateNotifier<List<Product>> {
  Ref _ref;
  ProductListViewStore(super.state, this._ref);

  // ViewModel이 http를 처음 딱한번 초기화 시켜주는 코드, 두번실행은 절대 안됨!
  void initViewModel() async {
    List<Product> products = await _ref.read(productHttpRepository).findAll();
    state = products;
  }

  void PageRefresh(List<Product> products) {
    state = products; // 상태에 새로운 product를 넣어준다.
  }

  void onRefresh(List<Product> products) {
    state = products;
  }

  void addProduct(Product productRespDto) {
    state = [...state, productRespDto];
  }

  void removeProduct(int id) {
    state = state.where((product) => product.id != id).toList();
  }

  void updateProduct(Product productRespDto) {
    state = state.map((product) {
      if (product.id == productRespDto.id) {
        return productRespDto;
      } else {
        return product;
      }
    }).toList();
  }
}
