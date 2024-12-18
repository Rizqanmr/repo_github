class RepoModel {
  final String name;
  final String description;
  final String language;
  final String url;

  RepoModel({
    required this.name,
    required this.description,
    required this.language,
    required this.url,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      name: json['name'] ?? '', 
      description: json['description'] ?? 'No Description', 
      language: json['language'] ?? '', 
      url: json['html_url'] ?? '');
  }
}