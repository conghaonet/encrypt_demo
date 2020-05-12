import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:fast_gbk/fast_gbk.dart';

void main() {
  final plainText = 'hello world!你好世界！【】  ，324·/。，';
  const String shortKey = 'MIICeQIBADANBgkqhkiG9w0BAQEFAASCAmMwggJfAgEAAoGBALaiUegzB3VChAHOkBomXH//JWKdoUo3X9rujbdnC0NN0gmL50rMVF2tm7+7f7NTZMIaIOnqH6DlI9xKLI1xhBS4OPvmB0aX5UdrlhrDlkNtLGfzQ01ztyJfIabS4aGyyr3VDIbQc9DgNXQQJRw0OlFfdlKuYOhx088XXNS3J6U5AgMBAAECgYEAlCo7qNU9R7QexBiAb7aPdIfaHJclMsCZ01OVRSUjzgZkT7pgeh4qk5U0tee3QhR1ucLY0OxPnIhI/35thpKBQ65fccMAsekZvgbZiBtEiLAr3TGZmKZtWgatxxiqIUmXLoW/uIgPCwZYVgoDoOiHOTtrwI/zIwp0NtspUOOSdMECQQDmmljdigFZA+NkfxVs1pMmmkQ+WJkIzgzbvaTfRc11pgOsmOIrWnv7oQ1J8+2yy68uzsu17mjTILTNRfTiwoHjAkEAyr+IIoRB4sNPr8S/mHqkiwlUyurPOh2zCckrmTx77zdolrPm3GBYuAj6hfjkBw4sJ2LAOyUjG58ksVIPJYA3MwJBALC8UqdYAbhrVnfLPmxv9896JBt0Y7Vv1kMDkbzdDp7AYciCU7TOYH91621mWiLSIK1LKK2CzywgwPEiUJEKaekCQQC6nWSOcLG8KQ2VuUCo9mmxV9tmEo6+7Us3/KRWnSdt3dA0tk4OFdhTPGBrI9Wu8MqPTgOl7N7Ns8OwOtmaKNOlAkEA3wqudEhKnRghZqHEREtTi4zvigV4O5g8K53EurDfVjjgng02mk6FMoQyVlgX+b8VJYfBpNwUdrsHj5BFjPbvYw==';
  const String strPrivateKey = '''-----BEGIN PRIVATE KEY-----
$shortKey
-----END PRIVATE KEY-----''';

  final keyParser = RSAKeyParser();
  final privateKey = keyParser.parse(strPrivateKey) as RSAPrivateKey;
  final signer = Signer(RSASigner(RSASignDigest.SHA256, publicKey: null, privateKey: privateKey));

  print('${signer.signBytes(gbk.encode(plainText)).base64}');

//  Encrypted encrypted = signer.sign(plainText);
//  print('${encrypted.base64}');
}