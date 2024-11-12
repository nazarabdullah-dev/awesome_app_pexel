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

  factory Src.fromMapDatabase(Map<String, dynamic> map) {
    return Src(
      original: map['src_original'],
      large2x: map['src_large2x'],
      large: map['src_large'],
      medium: map['src_medium'],
      small: map['src_small'],
      portrait: map['src_portrait'],
      landscape: map['src_landscape'],
      tiny: map['src_tiny'],
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'src_original': src.original,
      'src_large2x': src.large2x,
      'src_large': src.large,
      'src_medium': src.medium,
      'src_small': src.small,
      'src_portrait': src.portrait,
      'src_landscape': src.landscape,
      'src_tiny': src.tiny,
      'photographer': photographer,
      'width': width,
      'height': height,
      'url': url,
      'photographer_url': photographerUrl,
      'photographer_id': photographerId,
      'avg_color': avgColor,
      'liked': liked,
      'alt': alt,
    };
  }

  factory ImageData.fromMapDatabase(Map<String, dynamic> map) {
    return ImageData(
      id: map['id'],
      src: Src.fromMapDatabase(map),
      photographer: map['photographer'],
      width: map['width'],
      height: map['height'],
      url: map['url'],
      photographerUrl: map['photographer_url'],
      photographerId: map['photographer_id'],
      avgColor: map['avg_color'],
      liked: map['liked'],
      alt: map['alt'],
    );
  }
}
