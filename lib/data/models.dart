class Service {
  final String title;
  final String description;

  const Service({
    required this.title,
    required this.description,
  });
}

class Project {
  final String name;
  final String description;
  final List<String> tech;
  final String? url;

  const Project({
    required this.name,
    required this.description,
    this.tech = const [],
    this.url,
  });
}