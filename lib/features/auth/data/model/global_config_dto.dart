class GlobalConfigDto {
  final String code;
  final String description;
  final int id;
  final String key;
  final String value;

  GlobalConfigDto({
    required this.code,
    required this.description,
    required this.id,
    required this.key,
    required this.value,
  });

  factory GlobalConfigDto.fromJson(Map<String, dynamic> json) {
    return GlobalConfigDto(
      code: json['code'] ?? '',
      description: json['description'] ?? '',
      id: json['id'] ?? 0,
      key: json['key'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'description': description,
      'id': id,
      'key': key,
      'value': value,
    };
  }
}
