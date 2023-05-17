import 'package:scanner/modules/scanner/product.dart';
import 'package:scanner/services/scanner_service/scanner_service_interface.dart';

class ScannerService implements ScannerServiceInterface {
  @override
  Future<Product> fetchProductByBarcode({required String barcode}) async {
    throw UnimplementedError();
  }

  @override
  Future<Product> fetchProductById({required String keyword}) async {
    throw UnimplementedError();
  }

}