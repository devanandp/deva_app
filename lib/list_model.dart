class Listmodel {
  int id;
  String name;
  Listmodel(this.id, this.name);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  Listmodel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}