class TypeRoom {
  int? type_id;
  String? type_name;
  int? price;
  String? desc;
  String? photo_path;

  TypeRoom({
    this.type_id,
    this.type_name,
    this.price,
    this.desc,
    this.photo_path,
  });
  TypeRoom.fromJson(dynamic r) {
    TypeRoom(
      type_id: r["type_id"],
      type_name: r["type_name"],
      desc: r["desc"],
      price: r["price"],
      photo_path: r["photo_path"],
    );
  }
}
