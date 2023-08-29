class CategoriesWrapper {
  List<String> categories;

  CategoriesWrapper({required this.categories});

  factory CategoriesWrapper.fromJson(Map<String, dynamic> map) =>
      CategoriesWrapper(categories: map['categories'].cast<String>() as List<String>);
}
