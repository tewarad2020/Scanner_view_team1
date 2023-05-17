import 'package:scanner/exceptions/service_exception.dart';
import 'package:scanner/modules/scanner/product.dart';
import 'package:scanner/services/scanner_service/scanner_service_interface.dart';
import 'package:collection/collection.dart';


class ScannerMockService implements ScannerServiceInterface {
  List<Product> allProduct = [
    Product(name: 'ช้างเล็ก ยกลัง', nickname: 'ช้างยังไม่โต', skuId: '1', barcode: '8851993613102', amount: 10, unitPrice: 100, itemsInCardList: 0),
    Product(name: 'ช้างใหญ๋ แพค6', nickname: 'ช้างโตแล้ว', skuId: '2', barcode: '1234567891234', amount: 2, unitPrice: 400, itemsInCardList: 0),
    Product(name: 'เอสโคล่า ขวดลิตร ยกลัง', nickname: 'ทำไมไม่กินโค้ก', skuId: '3', barcode: '9938131085162', amount: 1, unitPrice: 250, itemsInCardList: 0),
    Product(name: 'ยำยำช้างน้อย ยกลัง', nickname: 'ไม่เคยเอามาต้มกิน', skuId: '4', barcode: '4643975201987', amount: 9, unitPrice: 100, itemsInCardList: 0),
    Product(name: 'น้ำเปล่าMinere ขวดเล็ก', nickname: 'น้ำช้างเท่านั้นครับ', skuId: '5', barcode: '2756879808465', amount: 12, unitPrice: 7, itemsInCardList: 0),
  ];

  @override
  Future<Product> fetchProductByBarcode({required String barcode}) async {
    late Product? scannedItem;
    scannedItem = allProduct.firstWhereOrNull((element) => element.barcode == barcode);
    if (scannedItem != null) {
      return scannedItem;
    }
    throw ResourceNotFoundError(errorStatus: 404, message: 'Barcode can not specify');
  }

  @override
  Future<Product> fetchProductById({required String keyword}) async {
    late Product? scannedItem;
    scannedItem = allProduct.firstWhereOrNull((element) => element.barcode == keyword);
    if (scannedItem != null) {
      return scannedItem;
    } 
    throw ResourceNotFoundError(errorStatus: 404, message: 'Not found the product');
  }

}