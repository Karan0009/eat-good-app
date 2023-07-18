class ImageDetails {
  final String url;
  final String path;

  const ImageDetails({
    required this.url,
    required this.path,
  });

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      "path": path,
    };
  }

  factory ImageDetails.fromJson(Map<String, dynamic> json) {
    return ImageDetails(url: json["url"] ?? "", path: json["path"] ?? "");
  }

  static ImageDetails empty() {
    return const ImageDetails(url: "", path: "");
  }
}
