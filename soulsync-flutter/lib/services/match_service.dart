// lib/services/match_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MatchService {
  // 🔗 Your live API URL
  static const String baseUrl = 'https://soulsynccafe.onrender.com';

  /// Calls the /match endpoint and returns compatibility data
  Future<Map<String, dynamic>> getCompatibility({
    required String name1,
    required String birthDate1, // Format: "1995-06-15"
    required String gender1,
    required String fullName1,
    required String name2,
    required String birthDate2,
    required String gender2,
    required String fullName2,
  }) async {
    final url = Uri.parse('$baseUrl/match');

    final body = {
      "user1": {
        "name": name1,
        "birth_date": birthDate1,
        "gender": gender1,
        "full_name_at_birth": fullName1
      },
      "user2": {
        "name": name2,
        "birth_date": birthDate2,
        "gender": gender2,
        "full_name_at_birth": fullName2
      }
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data']; // Contains total_score, insight, breakdown
        } else {
          throw Exception('API reported failure: $data');
        }
      } else {
        final error = jsonDecode(response.body);
        throw Exception('HTTP ${response.statusCode}: ${error['detail'] ?? 'Unknown error'}');
      }
    } on TimeoutException {
      throw Exception('Request timeout. Please try again.');
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException {
      throw Exception('Invalid response format.');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}