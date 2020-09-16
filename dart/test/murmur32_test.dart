
import '../util/murmur32.dart';
import 'package:test/test.dart';

void main() {

  test('Murmur32 convert string to hash key', () {
    var key = '布瑞恩氏 大型短管磁轨炮';
    var seed = 2538058380;
    
    var mmh = Murmur32(seed);
    var val = mmh.computeHashFromString(key); 
    expect(val.getUint32(0), equals(2170369764));
  });
}