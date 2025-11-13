import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/quote_model.dart';

class QuoteService {
  static const String baseUrl = 'https://api.breakingbadquotes.xyz';

  Future<Quote> getRandomQuote() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/v1/quotes'),
      ).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          return Quote.fromJson(data[0]);
        } else {
          throw Exception('No quote received');
        }
      } else {
        throw Exception('Failed to load quote: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching quote: $e');
    }
  }
}