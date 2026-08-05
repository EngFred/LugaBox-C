import '../../../../core/network/api_constants.dart';
import '../../domain/entities/discover_person.dart';

class DiscoverPersonModel extends DiscoverPerson {
  DiscoverPersonModel({
    required super.id,
    required super.name,
    required super.profileUrl,
  });

  factory DiscoverPersonModel.fromJson(Map<String, dynamic> json) {
    return DiscoverPersonModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] ?? 'Unknown').toString(),
      profileUrl: ApiConstants.posterUrl(json['profile_path'] as String?),
    );
  }
}
