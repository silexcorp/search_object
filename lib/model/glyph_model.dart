
class GlyphModel {
  String name;
  String nameLowercase;
  String description;
  String img;
  String thumbnail;
  String colors;
  List<String> tags;

  GlyphModel({
    this.name,
    this.nameLowercase,
    this.tags,
    this.description,
    this.img,
    this.thumbnail,
    this.colors,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nameLowercase': nameLowercase,
      'tags': tags,
      'description': description,
      'img': img,
      'thumbnail': thumbnail,
      'colors': colors,
    };
  }

  /*GlyphModel.fromSnapshot(DocumentSnapshot snapshot)
      : code          = snapshot['code'],
        name          = snapshot['name'],
        nameLowercase = snapshot['nameLowercase'],
        description   = snapshot['description'],
        img           = snapshot['img'],
        thumbnail     = snapshot['thumbnail'],
        brand         = snapshot['brand'],
        date          = snapshot['date'].toDate()
  ;*/

}