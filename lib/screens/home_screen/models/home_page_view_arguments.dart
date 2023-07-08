class HomePageViewArguments {
  int initalIndex = 0;

  HomePageViewArguments({required this.initalIndex});

  factory HomePageViewArguments.fromJson(Map<String, dynamic> json) {
    return HomePageViewArguments(initalIndex: json["initalIndex"]);
  }
}
