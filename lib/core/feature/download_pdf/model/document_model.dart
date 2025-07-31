List<DocumentModel> documentListFromJson(List<dynamic> str) =>
    List<DocumentModel>.from(str.map((dynamic x) => DocumentModel.fromJson(x)));

class DocumentModel {
  DocumentModel({
    required this.name,
    required this.originalUrl,
    this.extension,
    this.size,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      name: json['name'],
      originalUrl: json['original_url'],
      extension: json['extension'],
      size: json['size'],
    );
  }

  String name;
  String originalUrl;
  String? extension;
  int? size;
}
