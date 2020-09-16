
import 'dart:typed_data';

import 'lib/murmur32.dart';

void main() {
  
  var key = '布瑞恩氏 大型短管磁轨炮';
  var seed = 2538058380;
  
  var mmh = Murmur32(seed);
  var val = mmh.computeHashFromString(key);
  var byteData = ByteData.sublistView(val);
  
  print("$key = $val = ${byteData.getUint32(0)} (expecting 2170369764L)"); 
}