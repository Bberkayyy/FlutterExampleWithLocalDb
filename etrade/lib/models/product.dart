class Product {
  /*late => null yapmamasını belirtiyoruz. Bu sayede kodumuz, null gözüken değerin belirlendiği satıra kadar sorunsuzca çalışmaya devam edecektir.*/
  int? _id;
  late String _name;
  late String _description;
  late double _price;

  //Constructor
  Product(
    this._name,
    this._description,
    this._price,
  );
  Product.withId(this._id, this._name, this._description, this._price);

  int? get id => _id;
  String get name => _name;
  String get description => _description;
  double get price => _price;

  set name(String value) {
    if (value.length >= 2) {
      _name = value;
    }
  }

  set description(String value) {
    if (value.length >= 10) {
      _description = value;
    }
  }

  set price(double value) {
    if (value >= 10) {
      _price = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["description"] = _description;
    map["price"] = _price;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Product.fromObject(dynamic obj) {
    _id = obj["Id"];
    _name = obj["Name"];
    _description = obj["Description"];
    _price = double.tryParse(obj["Price"].toString())!;
  }
}
