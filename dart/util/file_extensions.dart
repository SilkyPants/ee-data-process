import 'dart:io';

extension FileExtention on FileSystemEntity {
  bool get isFile {
    return (this is File);
  }

  String get name {
    return this?.path?.split("/")?.last;
  }

  String get extension {
    return this?.name?.split(".")?.last;
  }

  String get nameWithoutExtension {
    var t = this?.name?.split(".");
    return t.sublist(0, t.length - 1).join(".");
  }
}
