class Word {
  int? id;
  String? rus;
  String? uzb;

  Word(this.rus, this.uzb);

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "rus": rus,
      "uzb": uzb,
    };

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Word.fromMap(Map<String, Object?> map) {
    id = (map["id"] as int?);
    rus = (map["rus"] as String?);
    uzb = (map["uzb"] as String?);
  }

  Word.fromJson(Map<String, dynamic> json) {
    rus = json["rus"];
    uzb = json["uzb"];
  }
}
