import '../../../../core/network/api_constants.dart';
import '../../domain/entities/credit_person.dart';

class CreditPersonModel extends CreditPerson {
  CreditPersonModel({
    required super.id,
    required super.name,
    required super.role,
    required super.profileUrl,
    required super.department,
  });

  factory CreditPersonModel.fromCastJson(Map<String, dynamic> json) {
    return CreditPersonModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] ?? 'Unknown').toString(),
      role: (json['character'] ?? 'Cast').toString(),
      profileUrl: ApiConstants.posterUrl(json['profile_path'] as String?),
      department: 'Cast',
    );
  }

  factory CreditPersonModel.fromCrewJson(Map<String, dynamic> json) {
    return CreditPersonModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] ?? 'Unknown').toString(),
      role: (json['job'] ?? 'Crew').toString(),
      profileUrl: ApiConstants.posterUrl(json['profile_path'] as String?),
      department: (json['department'] ?? 'Crew').toString(),
    );
  }
}
