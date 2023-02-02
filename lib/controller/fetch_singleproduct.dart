import 'package:fake_store/app_configure.dart';
import 'package:fake_store/model/singleproduct_model.dart';
import 'package:http/http.dart' as http;

class FetchSingleProduct {
  Future<SingleProduct> fetchProject({required int id}) async {
    // String token = access_token.$;

    //encode Map to JSON
    // Map data = {'id': id};
    // var body = json.encode(data);

    final response =
        await http.get(Uri.parse("${AppConfig.BASE_URL}products/${id}"));
    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return singleProductFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
