part of 'package:api_raja_ongkir/shared/shared.dart';

class RajaOngkirService {
  //Feature digunakan untuk mengambil data yang online, data yang butuh loading, data yang semakin lama loadingnya kalau internet jelek
  //Featur memiliki kembalian. Secara deafult data kembalian berupa json object.

  static Future<http.Response> getOngkir() {
    return http.post(
      Uri.https(Const.baseUrl, "/starter/cost"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      },
      //Khusus body pengiriman data pakai json encode
      body: jsonEncode(<String, dynamic>{
        'origin': '501',
        'destination': '114',
        'weight': 1700,
        'courier': 'jne',
      }),
    );
  }

  static Future<http.Response> sendemail(String email) {
    return http.post(
      Uri.https(
          Const.baseUrlSendEmail, "/nurazizah24/Week5/api/mahasiswa/sendmail"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      //Khusus body pengiriman data pakai json encode
      body: jsonEncode(<String, dynamic>{
        'email': email,
      }),
    );
  }
}