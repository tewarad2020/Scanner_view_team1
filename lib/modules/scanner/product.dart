class Product {
  late String skuId;
  late String name;
  late String nickname;
  late String barcode;
  late int amount;
  late double price;
  late int remainInStock;

  Product({
    required this.name, 
    required this.nickname, 
    required this.skuId, 
    required this.barcode, 
    required this.amount, 
    required this.price,
    required this.remainInStock
  });

}