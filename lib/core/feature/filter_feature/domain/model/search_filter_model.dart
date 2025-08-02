class SelectableModel {
  SelectableModel({this.id, this.name, this.image});

  int? id;
  String? name;
  String? image;

  @override
  String toString() {
    return name ?? "--";
  }
}
