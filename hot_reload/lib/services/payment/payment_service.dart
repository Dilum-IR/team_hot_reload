import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PayService {
  String generateHash() {
    final String? merchantId = dotenv.env['PAYHERE_MERCHANT_ID'];
    final String? merchantSecret = dotenv.env['PAYHERE_MERCHANT_SECRET'];

    const orderId = "123";
    double amount = 1000.00;
    const String currency = "LKR";

    // Format the amount with 2 decimal places and convert it to a string
    String formattedAmount = amount.toStringAsFixed(2);

    // Concatenate the values as in your PHP code
    String dataToHash =
        merchantId! + orderId + formattedAmount + currency + merchantSecret!;

    // Calculate MD5 hash
    var bytes = utf8.encode(dataToHash); // Encode the data
    var md5Hash = md5.convert(bytes);
    // print("$bytes \n");
    // Calculate MD5 hash

    // Convert the hash to a hexadecimal string and make it uppercase
    String resultHash = md5Hash.toString().toUpperCase();

    // print(resultHash);

    return resultHash;
  }
}
