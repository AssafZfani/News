class NewsFeedEntity {
  final String? id;
  final String? title;
  final String? description;
  final String? url;
  final String? author;
  final String? image;
  final List<String>? category;
  final String? published;

  const NewsFeedEntity(
      {this.id, this.title, this.description, this.url, this.author, this.image, this.category, this.published});
}
