import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:repo_github/models/repo_model.dart';

class RepoViewModel extends GetxController{
  var repo = <RepoModel>[].obs;
  var isLoading = false.obs;

  final String _apiKey = dotenv.env['API_KEY'] ?? '';
  final String _baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<void> fetchRepositories(String username) async {
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users/$username/repos?sort=updated'),
        headers: {
          'Authorization' : 'Bearer $_apiKey',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = List.from(jsonDecode(response.body));
        repo.value = data.map((json) => RepoModel.fromJson(json)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch repositories: ${response.reasonPhrase}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}