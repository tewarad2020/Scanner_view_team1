import 'package:scanner/exceptions/service_exception.dart';
import 'package:scanner/modules/scanner/product.dart';
import 'package:scanner/services/scanner_service/scanner_service_interface.dart';
// import 'package:scanner/services/scanner_service/scanner_service.dart';
import 'package:scanner/services/scanner_service/scanner_mock_service.dart';
import 'package:collection/collection.dart';

class ScannerViewModel {
  List<Product> itemsInCardList = [];
  // TODO : fixed
  Map<String, int> amonutItemsInCardList = {};
  String _inputStr = '';

  // final ScannerServiceInterface _service = ScannerService();
  final ScannerServiceInterface _service = ScannerMockService();

  void initScanner() {
    // TODO : fixed
    itemsInCardList.clear();
    amonutItemsInCardList.clear();
  }

  void setInputStr({required String value}) {
    _inputStr = value;
  }

  get getInputStr => _inputStr;

  Future<void> onUserScannedBarcode({
    required String barcode,
  }) async {
    late Product? scannedItem;
    scannedItem = itemsInCardList.firstWhereOrNull((element) => element.barcode == barcode);

    if (scannedItem != null) {
      final bool increaseAble = tryIncreaseAmountItemInCardList(item: scannedItem);
      if (increaseAble) {
        // TODO : fixed
        amonutItemsInCardList[scannedItem.skuId] = amonutItemsInCardList[scannedItem.skuId]! + 1;
      }else {
        throw ProductRunOutOfStockError(errorStatus: 200, message: 'Product run out of stock');
      }
    }else {
      try {
        scannedItem = await _service.fetchProductByBarcode(barcode: barcode);
        final bool increaseAble = tryIncreaseAmountItemInCardList(item: scannedItem);
        if (increaseAble) {
          // TODO : fixed
          itemsInCardList.add(scannedItem);
          amonutItemsInCardList[scannedItem.skuId] = 1;
        }else {
          throw ProductRunOutOfStockError(errorStatus: 200, message: 'Product run out of stock');
        }
      }catch(_) {
        rethrow;
      }
    }
  }

  Future<void> onUserIdentifyKeyword({required String keyword}) async {
    Product? identifiedItem;
    identifiedItem = itemsInCardList.firstWhereOrNull((element) => element.barcode == keyword);

    if (identifiedItem != null) {
      final bool increaseAble = tryIncreaseAmountItemInCardList(item: identifiedItem);
      if (increaseAble) {
        // TODO : fixed
        amonutItemsInCardList[identifiedItem.skuId] = amonutItemsInCardList[identifiedItem.skuId]! + 1;
      }else {
        throw ProductRunOutOfStockError(errorStatus: 200, message: 'Product run out of stock');
      }
    }else {
      try {
        identifiedItem = await _service.fetchProductById(keyword: keyword);
        final bool increaseAble = tryIncreaseAmountItemInCardList(item: identifiedItem);
        if (increaseAble) {
          // TODO : fixed
          itemsInCardList.add(identifiedItem);
          amonutItemsInCardList[identifiedItem.skuId] = 1;
        }else {
          throw ProductRunOutOfStockError(errorStatus: 200, message: 'Product run out of stock');
        }
      }catch(_) {
        rethrow;
      }
    }
  }

  void onUserPressedDeleteButton({required int index}) {
    // TODO : fixed
    amonutItemsInCardList[itemsInCardList[index].skuId] = 0;
    itemsInCardList.removeAt(index);
  }

  // TODO : fixed
  bool tryIncreaseAmountItemInCardList({required Product item}) {
    if (amonutItemsInCardList[item.skuId] != null) {
      if (item.remainInStock > amonutItemsInCardList[item.skuId]! + item.amount) {
        return true;
      }
      return false;
    }else {
      if (item.remainInStock > item.amount) {
        return true;
      }
      return false;
    }
    
  }

}
