class Src {
  final String original;
  final String large2x;
  final String large;
  final String medium;
  final String small;
  final String portrait;
  final String landscape;
  final String tiny;

  Src({
    required this.original,
    required this.large2x,
    required this.large,
    required this.medium,
    required this.small,
    required this.portrait,
    required this.landscape,
    required this.tiny,
  });

  factory Src.fromJson(Map<String, dynamic> json) {
    return Src(
      original: json['original'],
      large2x: json['large2x'],
      large: json['large'],
      medium: json['medium'],
      small: json['small'],
      portrait: json['portrait'],
      landscape: json['landscape'],
      tiny: json['tiny'],
    );
  }
}

class ImageData {
  final int id;
  final Src src;
  final String photographer;
  final int width;
  final int height;
  final String url;
  final String photographerUrl;
  final int photographerId;
  final String avgColor;
  final bool liked;
  final String alt;

  ImageData({
    required this.id,
    required this.src,
    required this.photographer,
    required this.width,
    required this.height,
    required this.url,
    required this.photographerUrl,
    required this.photographerId,
    required this.avgColor,
    required this.liked,
    required this.alt,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      src: Src.fromJson(json['src']),
      photographer: json['photographer'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      photographerUrl: json['photographer_url'],
      photographerId: json['photographer_id'],
      avgColor: json['avg_color'],
      liked: json['liked'],
      alt: json['alt'],
    );
  }
}
