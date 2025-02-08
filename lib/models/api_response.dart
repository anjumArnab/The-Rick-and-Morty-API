class ApiResponse<T> {
  final List<T> results;
  final int count;
  final String? next;
  final String? previous;

  ApiResponse({
    required this.results,
    required this.count,
    this.next,
    this.previous,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return ApiResponse<T>(
      results: (json['results'] as List)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList(),
      count: json['info']['count'] ?? 0,
      next: json['info']['next'],
      previous: json['info']['prev'],
    );
  }
}
