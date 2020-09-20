import '../util/murmur32.dart';

Map<int, int> msgIndexLookup = {};

class LocalisationDetails {
  final int localisationIndex;
  final String sourceName;

  LocalisationDetails(this.localisationIndex, this.sourceName);
}

class MsgIndex {
  static var _mmh = Murmur32(2538058380);
  final int msgHashCode;
  final int localiseIndex;

  MsgIndex({this.msgHashCode, this.localiseIndex});

  static LocalisationDetails lookupLocalisation(String source) {
    /*
    if boot.node.is_client() and config.SHIPPING and source == 'g85tr':
        localized_obj = LocalizedStr(source, '')
    */
    if (source == 'g85str') {
      return LocalisationDetails(0, '');
    }

    var hashCode = _mmh.computeHashFromString(source).getUint32(0);
    var index = msgIndexLookup[hashCode] ?? 0;

    return LocalisationDetails(index, source);
  }
}
