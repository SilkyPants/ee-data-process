class LocalisedString {
  final int index;
  final String localisedString;

  LocalisedString({this.index, this.localisedString});

  factory LocalisedString.fromMap({Map<String, dynamic> map}) {
    return LocalisedString(
      index: map["index"],
      localisedString: map["localisedString"],
    );
  }

  Map<String, dynamic> toJson() => {
        "index": index,
        "localisedString": localisedString,
      };
}
