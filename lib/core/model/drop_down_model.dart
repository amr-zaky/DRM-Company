class DropDownModel {
  DropDownModel(
      {required this.id,
      required this.value,
      required this.name,
      this.dropImage});
  final int id;
  final String name;
  final String value;
  final String? dropImage;
}
