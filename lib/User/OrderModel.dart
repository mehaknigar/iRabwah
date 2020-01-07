class Order{
  String productName,productPrice,productQuantity;
  Order(this.productName,this.productPrice,this.productQuantity);
  Order.fromJson(Map<String, dynamic> json) {
    productName = json['name'];
    productPrice=json["price"];
    productQuantity=json["quantity"];
   
  }

}