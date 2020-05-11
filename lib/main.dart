import 'package:flutter/material.dart';

import 'package:encrypt/encrypt_io.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

import 'package:pointycastle/export.dart' hide Signer hide RSASigner;
//const String strPrivateKey="MIICeQIBADANBgkqhkiG9w0BAQEFAASCAmMwggJfAgEAAoGBALaiUegzB3VChAHOkBomXH//JWKdoUo3X9rujbdnC0NN0gmL50rMVF2tm7+7f7NTZMIaIOnqH6DlI9xKLI1xhBS4OPvmB0aX5UdrlhrDlkNtLGfzQ01ztyJfIabS4aGyyr3VDIbQc9DgNXQQJRw0OlFfdlKuYOhx088XXNS3J6U5AgMBAAECgYEAlCo7qNU9R7QexBiAb7aPdIfaHJclMsCZ01OVRSUjzgZkT7pgeh4qk5U0tee3QhR1ucLY0OxPnIhI/35thpKBQ65fccMAsekZvgbZiBtEiLAr3TGZmKZtWgatxxiqIUmXLoW/uIgPCwZYVgoDoOiHOTtrwI/zIwp0NtspUOOSdMECQQDmmljdigFZA+NkfxVs1pMmmkQ+WJkIzgzbvaTfRc11pgOsmOIrWnv7oQ1J8+2yy68uzsu17mjTILTNRfTiwoHjAkEAyr+IIoRB4sNPr8S/mHqkiwlUyurPOh2zCckrmTx77zdolrPm3GBYuAj6hfjkBw4sJ2LAOyUjG58ksVIPJYA3MwJBALC8UqdYAbhrVnfLPmxv9896JBt0Y7Vv1kMDkbzdDp7AYciCU7TOYH91621mWiLSIK1LKK2CzywgwPEiUJEKaekCQQC6nWSOcLG8KQ2VuUCo9mmxV9tmEo6+7Us3/KRWnSdt3dA0tk4OFdhTPGBrI9Wu8MqPTgOl7N7Ns8OwOtmaKNOlAkEA3wqudEhKnRghZqHEREtTi4zvigV4O5g8K53EurDfVjjgng02mk6FMoQyVlgX+b8VJYfBpNwUdrsHj5BFjPbvYw==";

const String strPrivateKey = '''-----BEGIN PRIVATE KEY-----
MIICeQIBADANBgkqhkiG9w0BAQEFAASCAmMwggJfAgEAAoGBALaiUegzB3VChAHOkBomXH//JWKdoUo3X9rujbdnC0NN0gmL50rMVF2tm7+7f7NTZMIaIOnqH6DlI9xKLI1xhBS4OPvmB0aX5UdrlhrDlkNtLGfzQ01ztyJfIabS4aGyyr3VDIbQc9DgNXQQJRw0OlFfdlKuYOhx088XXNS3J6U5AgMBAAECgYEAlCo7qNU9R7QexBiAb7aPdIfaHJclMsCZ01OVRSUjzgZkT7pgeh4qk5U0tee3QhR1ucLY0OxPnIhI/35thpKBQ65fccMAsekZvgbZiBtEiLAr3TGZmKZtWgatxxiqIUmXLoW/uIgPCwZYVgoDoOiHOTtrwI/zIwp0NtspUOOSdMECQQDmmljdigFZA+NkfxVs1pMmmkQ+WJkIzgzbvaTfRc11pgOsmOIrWnv7oQ1J8+2yy68uzsu17mjTILTNRfTiwoHjAkEAyr+IIoRB4sNPr8S/mHqkiwlUyurPOh2zCckrmTx77zdolrPm3GBYuAj6hfjkBw4sJ2LAOyUjG58ksVIPJYA3MwJBALC8UqdYAbhrVnfLPmxv9896JBt0Y7Vv1kMDkbzdDp7AYciCU7TOYH91621mWiLSIK1LKK2CzywgwPEiUJEKaekCQQC6nWSOcLG8KQ2VuUCo9mmxV9tmEo6+7Us3/KRWnSdt3dA0tk4OFdhTPGBrI9Wu8MqPTgOl7N7Ns8OwOtmaKNOlAkEA3wqudEhKnRghZqHEREtTi4zvigV4O5g8K53EurDfVjjgng02mk6FMoQyVlgX+b8VJYfBpNwUdrsHj5BFjPbvYw==
-----END PRIVATE KEY-----''';

/*
const String strPrivateKey = '''-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKBgQCzoN1rGpG4oIam1m2fup1ruY5enRGxF9KJtnhc2XZZoTn2mRz+
oqFJEvgN0DsfNrjpAJRModM9qHFx4u2wEZgSjHvI2IgVp0t5R2Ji/v3bwwcYKy9M
UhL6Qp24EYyi6awh8uK8BovNCM7IzWFOgBxTtOJ8oBUkko01QfIIG+uoAQIDAQAB
An8l48jQzsnuJ+4/QvvctYB/OKTPUFJrCJtgcRzyeOx9+4Q+gA2dqLBcuaOZRlMy
Qli+zWB6yafFWcKUQ0nf2dY5t86wubsSAaHrSMDCASjLIJJeVDEqPe+Gj+w3RAXw
vb8MW4l7I9T3sSRukn0CnIhGU0KT8+znTHQrAvxNFFbZAkEA+yyTC2FSEGrGqKEx
Vao0ZBegnyoWIN26Xyh+i0c1mZKYHNw363NbMIo3VLQRrnQ08OzXNXE4pxKH+ACN
s1wAjwJBALcUYq619D42YmwpSoPLIUWAFHZmbQYQbO+N+wBlopP0nE6CimC5HsTI
uMAqefnAXRIEU9CM5h3u+6zFVCyi9m8CQQD4JXqEtLppw8POl6nw8z3dYUZr2R2R
jN1y48PZgBmhRqYHZT3N3OLLmtG9WkVZsC8ZkzOu9dO9o943EvzrpUpbAkEAliv9
iiusDX/Umb4A5jwvrW+S2U/I6+l7QcBne/riMZS6xddkJFSUvXubt9zfspIshYPR
MEby1ujZve0az4ZYtwJAa00wn3MncsMiYkwmPIqIruAT5AMkTHLGhddaEFmuQ/kP
xrVrCDQlcV53PNeRoldVb2YSXu58gMeI/SOQIgKMzw==
-----END RSA PRIVATE KEY-----''';
*/

void main() async {
//  final publicKey = await parseKeyFromFile<RSAPublicKey>('test/public.pem');
//  final privateKey = await parseKeyFromFile<RSAPrivateKey>('test/private.pem');
  final plainText = 'hello';
  final keyParser = RSAKeyParser();
  final privateKey = keyParser.parse(strPrivateKey) as RSAPrivateKey;
  final signer = Signer(RSASigner(RSASignDigest.SHA256, publicKey: null, privateKey: privateKey));

  print('$signer');

//  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encrypt Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }

}
