abstract class ServiceException implements Exception {
  late int errorStatus;
  late String message;
}

///The InternalServerError exception is used when the server encounters an
/// error that prevents it from fulfilling a request.
class InternalServerError implements ServiceException {
  @override
  int errorStatus;

  @override
  String message;

  InternalServerError({
    required this.errorStatus,
    required this.message,
  });
}

/// This exception can be used when a requested resource is not found on
/// the server.
class ResourceNotFoundError implements ServiceException {
  @override
  int errorStatus;

  @override
  String message;

  ResourceNotFoundError({
    required this.errorStatus,
    required this.message,
  });
}

/// This exception can be used when a amount of resource is run out of stock.
class ProductRunOutOfStockError implements ServiceException {
  @override
  int errorStatus;

  @override
  String message;

  ProductRunOutOfStockError({
    required this.errorStatus,
    required this.message,
  });
}