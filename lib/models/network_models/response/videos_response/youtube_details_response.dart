class YoutubeDetailsResponse {
  String? title;
  String? authorName;
  String? authorUrl;
  String? type;
  int? height;
  int? width;
  String? version;
  String? providerName;
  String? providerUrl;
  int? thumbnailHeight;
  int? thumbnailWidth;
  String? thumbnailUrl;
  String? html;

  YoutubeDetailsResponse(
      {this.title,
      this.authorName,
      this.authorUrl,
      this.type,
      this.height,
      this.width,
      this.version,
      this.providerName,
      this.providerUrl,
      this.thumbnailHeight,
      this.thumbnailWidth,
      this.thumbnailUrl,
      this.html});

  YoutubeDetailsResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    authorName = json['author_name'];
    authorUrl = json['author_url'];
    type = json['type'];
    height = json['height'];
    width = json['width'];
    version = json['version'];
    providerName = json['provider_name'];
    providerUrl = json['provider_url'];
    thumbnailHeight = json['thumbnail_height'];
    thumbnailWidth = json['thumbnail_width'];
    thumbnailUrl = json['thumbnail_url'];
    html = json['html'];
  }
}
