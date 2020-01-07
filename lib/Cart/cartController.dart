import 'package:flutter/foundation.dart';
import 'package:irabwah/Models/categoryModel.dart';

class CartController with ChangeNotifier {
  List<Note> _itemIds;
  CartController() {
    init();
  }
  List<Note> get items => _itemIds;
  double addPrice;
   void init() {
     _itemIds = [];
   } 
int get total => _itemIds.length;
 double totalCartValue = 0;
  void addProduct(product,no) {
    int index = _itemIds.indexWhere((i) => i.id == product.id);
    if (index != -1)
      updateProduct(product, no);
    else {
      _itemIds.add(product);
        int index = _itemIds.indexWhere((i) => i.id == product.id);
         _itemIds[index].qty = no;
      calculateTotal();
      notifyListeners();
    }
  }
   void updateProduct(product, qty) {
    int index = _itemIds.indexWhere((i) => i.id == product.id);
    _itemIds[index].qty += qty;
    if (_itemIds[index].qty == 0)
      removeProduct(product);
    calculateTotal();
    notifyListeners();
  }
  void calculateTotal() {
    totalCartValue = 0;
    _itemIds.forEach((f) {
      totalCartValue += double.parse(f.price) * f.qty;
    }
    );
  }
  void addAProduct(product){
    int index = _itemIds.indexWhere((i) => i.id == product.id);
    _itemIds[index].qty +=1;
    
    calculateTotal();
    notifyListeners(); 
  }
  void remoProduct(product){
    int index = _itemIds.indexWhere((i) => i.id == product.id);
    _itemIds[index].qty -=1;
    
    calculateTotal();
    notifyListeners(); 
  }

void removeProduct(product) {
    int index = _itemIds.indexWhere((i) => i.id == product.id);
    _itemIds[index].qty = 1;
    _itemIds.removeWhere((item) => item.id == product.id);
    calculateTotal();
    notifyListeners();
  }
  clear() {
    _itemIds.forEach((f) => f.qty = 1);
    _itemIds = [];
    totalCartValue=0;
    notifyListeners();
  }

  contains(id) {
    return _itemIds
        .map((item) {
          return item.id;
        })
        .toList()
        .contains(id);
  }
}

 