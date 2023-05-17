import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:scanner/constants/decorations/box_decoration.dart';
import 'package:scanner/constants/decorations/colors.dart';
import 'package:scanner/constants/decorations/text_style.dart';
import 'package:scanner/exceptions/service_exception.dart';
import 'package:scanner/modules/scanner/components/add_new_product.dart';
import 'package:scanner/modules/scanner/components/barcode_scanner_overlay_shape.dart';
import 'package:scanner/modules/scanner/components/comfirm_rollback.dart';
import 'package:scanner/modules/scanner/components/confirm_delete.dart';
import 'package:scanner/modules/scanner/components/product_card.dart';
import 'package:scanner/modules/scanner/components/scanned_error.dart';
import 'package:scanner/modules/scanner/components/scanned_error_correction.dart';
import 'package:scanner/modules/scanner/product.dart';
import 'package:scanner/modules/scanner/scanner_view_model.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  final ScannerViewModel _viewModel = ScannerViewModel();
  late TextEditingController inputStr; 
  late double _width;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'Barcode');
  late QRViewController controller;
  late String? barcode;
  bool _isScanningTime = false;
  

  @override
  void initState() {
    super.initState();
    _viewModel.initScanner();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Container(
          child: _iconAppBar(
            icon: Icons.arrow_back_rounded, 
            size: 35, 
            color: kPrimaryLightColor,
            onPressed: () async {
              controller.pauseCamera();
              await _alertConfirmRollback();
            }
          ) 
        ),
        actions: [
          Container(
            child: _iconAppBar(
              icon: Icons.check, 
              size: 30, 
              color: kPrimaryDarkColor,
              onPressed: () {
                // TODO : check out process
                // Navigator.push(
                //   context, 
                //   MaterialPageRoute(
                //     builder: (context) => MyScannerPage()
                //   )
                // );
              }
            )
          )
        ],
      ),
      body: _body()
    );
  }

  IconButton _iconAppBar({
    required IconData icon, 
    required double size, 
    required Color color,
    required VoidCallback onPressed
  }) {
    return IconButton(
      icon: Icon(
        icon,
        size: size,
        color: color,
      ),
      onPressed: onPressed
    );
  }

  Future<void> _alertConfirmRollback() async {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) => ConfirmRollback(
        title: 'แน่ใจหรือไม่',
        data: 'หากออกจากหน้านี้แล้วรายการทั้งหมดที่กำลังดำเนินอยู่จะหายไป',
        leftButtonText: 'ยกเลิก',
        rightButtonText: 'ยืนยัน',
        onUserPressedLeftButton: () async {
          controller.resumeCamera();
          Navigator.pop(context);
        },
        onUserPressedRightButton: () async {
          controller.resumeCamera();
          Navigator.pop(context);
          Navigator.pop(context);
        },
      )
    );
  }

  Container _body() {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(16, 0 ,16, 16),
      child: Column(
        children: <Widget>[
          _scannerBox(),
          _cardBox(),
        ],
      ),
    );
  }

  Container _scannerBox() {
    return Container(
      width: _width * 0.8,
      height: _width * 0.8,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: kScannerBoxlDecoration,
        child: Indexer(
          children: <Widget>[
            _cameraBox(),
            _focusBox(),
            _borderBox(),
            _pipeBox(),
          ],
        )
    );
  }

  Indexed _pipeBox() {
    return Indexed(
      index: 2,
      child: Center(
        child: Container(
          color: Colors.red,
          height: _width * 0.78,
          width: _width * 0.003,
        )
      ),
    );
  }

  Indexed _cameraBox() {
    return Indexed(
      index: 1,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: QRView(
          key: qrKey,
          cameraFacing: CameraFacing.back,
          formatsAllowed: const [BarcodeFormat.code128, BarcodeFormat.ean8, BarcodeFormat.ean13],
          onQRViewCreated: _onQRViewCreated,
        ),
      ),
    );
  }

  Indexed _focusBox() {
    return Indexed(
      index: 2,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child:ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Container(
            decoration: ShapeDecoration(
              shape: BarcodeScannerOverlayShape(
                borderColor: Colors.white,
                borderRadius: 10,
                borderLength: 15,
                borderWidth: 5,
                cutOutSize: _width * 0.55,
              ) 
            ),
          ),
        ),
      ),
    );
  }

  Indexed _borderBox() {
    return Indexed(
      index: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(
            color: kPrimaryDarkColor,
            width: 2,
          ),
          color: Colors.transparent,
        ),
      )
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
        setState(() {});
        if (!_isScanningTime) {
          _isScanningTime = true;
          controller.pauseCamera();
          barcode = scanData.code;
          try {
            await _viewModel.onUserScannedBarcode(
              barcode: barcode.toString(),
            );
            _isScanningTime = false;
            controller.resumeCamera();
          }on Exception catch(error) {
            // if(error.toString() == Exception('Product run out of stock').toString()) {
            if(error is ProductRunOutOfStockError) {
              await _alertRunOutOfBox();
            // } else if(error.toString() == Exception('Barcode can not specify').toString()) {
            } else if(error is ResourceNotFoundError) {
              await 
              _alertNotSpecifyBox();
            }
          }
        }
    });
  }

  Future<void> _alertRunOutOfBox() async {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) => ScannedError(
        title: 'เกิดข้อผิดพลาด', 
        content: 'สินค้าหมดสต๊อก',
        leftButtonText: 'สแกนใหม่',
        rightButtonText: 'ยืนยัน',
        onUserPressedLeftButton: () async {
          _isScanningTime = false;
          controller.resumeCamera();
          Navigator.pop(context);
        },
        onUserPressedRightButton: () async {
          _isScanningTime = false;
          controller.resumeCamera();
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _alertNotSpecifyBox() async {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) => ScannedError(
        title: 'เกิดข้อผิดพลาด', 
        content: 'ระบบไม่สามารถระบุบาร์โค้ดที่สแกน',
        leftButtonText: 'สแกนใหม่',
        rightButtonText: 'ระบุเอง',
        onUserPressedLeftButton: () async {
          _isScanningTime = false;
          controller.resumeCamera();
          Navigator.pop(context);
        },
        onUserPressedRightButton: () async {
          Navigator.pop(context);
          await _identifyBox();
        },
      ),
    );
  }

  Future<void> _identifyBox() async {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) => ScannedErrorCorrection(
        onUserPressedLeftButton: () async {
          _isScanningTime = false;
          controller.resumeCamera();
          Navigator.pop(context);
        },
        onUserPressedRightButton: () async {
          Navigator.pop(context);
          try {
            await _viewModel.onUserIdentifyKeyword(
              keyword: _viewModel.getInputStr
            );
            _isScanningTime = false;
            controller.resumeCamera();
          }on Exception catch(error) {
            // if(error.toString() == Exception('Product run out of stock').toString()) {
            if(error is ProductRunOutOfStockError) {
              await _alertRunOutOfBox();
              _isScanningTime = false;
              controller.resumeCamera();
            // }else if (error.toString() == Exception('Not found the product').toString()) {
            }else if (error is ResourceNotFoundError) {
              await _alertNotFoundBox();
            }
          }
          _viewModel.setInputStr(value: '');
        },
        setInputStr: _viewModel.setInputStr,
      )
    );
  }

  Future<void> _alertNotFoundBox() async {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) => ScannedError(
        title: 'เกิดข้อผิดพลาด', 
        content: 'ไม่พบสินค้าที่ระบุ', 
        leftButtonText: 'ระบุใหม่', 
        rightButtonText: 'เพิ่มสินค้า', 
        onUserPressedLeftButton: () async {
          Navigator.pop(context);
          await _identifyBox();
        }, 
        onUserPressedRightButton: () async {
          Navigator.pop(context);
          await _addNewProductBox();
        }
      )
    );
  }

  Future<void> _addNewProductBox() async {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) => AddNewProduct(
        onUserPressedBackButton: () async {
          Navigator.pop(context);
          await _identifyBox();
        },
        onUserPressedUpdateButton: () async {
          // TODO : update product process
          _isScanningTime = false;
          controller.resumeCamera();
          Navigator.pop(context);
        },
      )
    );
  }

  Expanded _cardBox() {
    return Expanded(
      flex: 70,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            _cardListTitle(),
            _cardList()
          ],
        ),
      ),
    );
  }

  Container _cardListTitle() {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: 30,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'สำเร็จ',
            style: kSubHeaderTextStyle,
          ),
        ],
      ),
    );
  }
  
  Expanded _cardList() {
  return Expanded(
    child: Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(
        top: 6
      ),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            itemCount: _viewModel.itemsInCardList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              Product item = _viewModel.itemsInCardList[index];
              return _itemCard(index: index, item: item);
            },
          ),
        ),
      ),
    );
  }

  ProductCard _itemCard({
    required int index, 
    required Product item
  }) {
    return ProductCard(
      model: item,
      onUserPressedDeleteButton: () {
        controller.pauseCamera();
        showDialog(
          barrierDismissible: false,
          context: context, 
          builder: (context) => ConfirmDelete(
            icon: Icons.delete_forever, 
            title: 'ลบสินค้าทั้งหมด',
            content: 'สินค้าทั้งหมดจำนวน : ${item.itemsInCardList} ชิ้น',
            leftButtonText: 'ยกเลิก',
            rightButtonText: 'ยืนยัน',
            onUserPressedAcceptButton: () {
              setState(() {});
              _viewModel.onUserPressedDeleteButton(index: index);
              Navigator.pop(context);
              controller.resumeCamera();
            },
            onUserPressedCancelButton: () {
              controller.resumeCamera();
              Navigator.pop(context);
            },
          )
        );
        setState(() {});
      },
    );
  }
}