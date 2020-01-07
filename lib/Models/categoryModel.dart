class Note {
  int id,qty=1;
  String price, image, name, description,metadescripion,model,quantity;
  Note(this.id, this.price, this.image, this.name, this.description,this.qty,this.metadescripion,this.model,this.quantity);
  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    metadescripion=json['meta_description'];
    model=json['model'];
    quantity=json['quantity'];
  }
}
