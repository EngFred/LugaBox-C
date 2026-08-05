import '../../../../core/network/api_constants.dart';
import '../../domain/entities/featured_title.dart';

class FeaturedTitleModel extends FeaturedTitle {
  FeaturedTitleModel({
    required super.id,
    required super.mediaType,
    required super.title,
    required super.overview,
    required super.backdropUrl,
  });

  factory FeaturedTitleModel.fromJson(Map<String, dynamic> json) {
    return FeaturedTitleModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      mediaType:
          (json['media_type'] as String?) ??
          (json['name'] != null ? 'tv' : 'movie'),
      title: (json['title'] ?? json['name'] ?? 'Untitled').toString(),
      overview: (json['overview'] ?? '').toString(),
      backdropUrl: ApiConstants.backdropUrl(json['backdrop_path'] as String?),
    );
  }
}
