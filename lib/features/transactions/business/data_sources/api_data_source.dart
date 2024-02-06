import 'package:http/http.dart' as http;
import 'package:trackbucks/config/config.dart';

abstract class ApiDataSource {
  Future<void> loadNewTransactions();
}

class ApiDataSourceImpl implements ApiDataSource {
  @override
  Future<void> loadNewTransactions() async {
    try {
      await http.post(
        Uri.parse(transactionsAPIEndpoint),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      throw Exception("Transactions could not be loaded");
    }
  }
}
