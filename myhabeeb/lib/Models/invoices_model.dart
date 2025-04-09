import 'package:cloud_firestore/cloud_firestore.dart';

class InvoiceModel {
  String? id;
  String invoiceNumber;
  String customerId;
  String customerName;
  String customerShopName;
  String phoneNumber;
  DateTime invoiceDate; // DateTime, not Timestamp, since you're handling conversion
  String status;
  List<InvoiceItemModel> items;

  InvoiceModel({
    this.id,
    required this.invoiceNumber,
    required this.customerId,
    required this.customerName,
    required this.customerShopName,
    required this.phoneNumber,
    required this.invoiceDate,
    required this.status,
    required this.items,
  });

  double get totalInvoicePrice =>
      items.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalItemsCount => items.fold(0, (sum, item) => sum + item.quantity);

  Map<String, dynamic> toMap() {
    return {
      'invoiceNumber': invoiceNumber,
      'customerId': customerId,
      'customerName': customerName,
      'customerShopName': customerShopName,
      'phoneNumber': phoneNumber,
      'invoiceDate': Timestamp.fromDate(invoiceDate), // Save as Timestamp
      'status': status,
      'items': items.map((item) => item.toMap()).toList(),
      'totalItemsCount': totalItemsCount,
    };
  }

  factory InvoiceModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InvoiceModel(
      id: doc.id,
      invoiceNumber: data['invoiceNumber'] ?? '',
      customerId: data['customerId'] ?? '',
      customerName: data['customerName'] ?? '',
      customerShopName: data['customerShopName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      
      invoiceDate: (data['invoiceDate'] as Timestamp?)?.toDate() ?? DateTime.now(), // Convert Timestamp to DateTime
      status: data['status'] ?? 'غير معروف',
      items: data['items'] is List ? List.from(data['items']) : [],
    );
  }
}

class InvoiceItemModel {
  String name;
  String itemcode;
  double price;
  int quantity;

  InvoiceItemModel({
    required this.name,
    required this.itemcode,
    required this.price,
    required this.quantity,
  });

  double get totalPrice => price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'itemcode': itemcode,
      'price': price,
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }

  factory InvoiceItemModel.fromMap(Map<String, dynamic> map) {
    return InvoiceItemModel(
      name: map['name'],
      itemcode: map['itemcode'],
      price: map['price'].toDouble(),
      quantity: map['quantity'],
    );
  }
}
