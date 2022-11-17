// ignore_for_file: unused_local_variable

import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:data_app/main.dart';
import 'package:data_app/views/components/my_alert_dialog.dart';
import 'package:data_app/views/product/detail/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: slash_for_doc_comments
/**
 * View가 Controller에게 요청 하는것
 * 원래는 Spring에서는 바로 View로 주었지만
 * 여기서 View는 Provider만 리스닝 중이기 때문에 Controller은 Provider로 넣어준다.
 */

// View에서 컨트롤러 사용하기 위한 싱글톤 Provider 사용법.
// 창고에 productController를 저장해두는것과 같은 논리. -> 이제부터 productController에만 접근해도 된다.

/**
 * Controller은 비즈니스 로직을 담당.
 */
final productController = Provider<ProductController>((ref) {
  final productHttpRepositoryPS =
      ref.read(productHttpRepository); // 컨트롤러 + Http레포 결합
  return ProductController(ref);
});

class ProductController {
  final context = navigatorKey
      .currentContext!; // 모든 컨트롤러에 달아준다, 이 컨텍스트가 뷰를 참조할 수 있게 해준다. -> 현재 띄워진 화면의 모든 컨텍스트를 찾을 수 있다.
  final Ref _ref;
  ProductController(this._ref);

  void findAll() async {
    List<Product> productList = await _ref
        .read(productHttpRepository)
        .findAll(); // 레포에서 받은 값을 productList에 저장
    _ref
        .read(productListViewStore.notifier)
        .onRefresh(productList); // Store의 값을 갱신해줌.
  }

  void insert(Product productReqDto) async {
    Product productRespDto =
        await _ref.read(productHttpRepository).insert(productReqDto);
    _ref.read(productListViewStore.notifier).addProduct(productRespDto);
  }

  void deleteById(int id) async {
    int code = await _ref.read(productHttpRepository).deleteById(id);
    if (code == 1) {
      //삭제 이후 데이터를 갱신 할 필요가 있다.
      // 삭제한 리스트를 다시 갱신 하려고 findAll을 하면 모두 리빌드기 때문에 하지 않는다, 아래 처럼 remove만 실행한다.
      _ref.read(productListViewStore.notifier).removeProduct(id);
    } else {
      showCupertinoDialog(
          context: context, builder: (context) => MyAlertDialog(msg: "삭제 실패"));
    }
  }

  void updateById(int id, Product productReqDto) async {
    Product productRespDto =
        await _ref.read(productHttpRepository).updateById(id, productReqDto);
    _ref.read(productListViewStore.notifier).updateProduct(productRespDto);
  }
}
