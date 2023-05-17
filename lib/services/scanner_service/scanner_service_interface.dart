import 'package:scanner/modules/scanner/product.dart';

abstract class ScannerServiceInterface {
  Future<Product> fetchProductByBarcode({required String barcode});
  Future<Product> fetchProductById({required String keyword});
}
