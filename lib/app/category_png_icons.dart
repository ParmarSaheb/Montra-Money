enum CategoryPngIcons {
  cate2,
  cate3,
  cate4,
  cate6,
  cate7,
  cate8,
  cate9,
  cate12,
  cate13,
  cate14,
  cate15,
  cate16,
  cate17,
  cate18,
  cate19,
  cate20,
  cate21,
  cate22,
  cate23,
  cate24,
  cate25,
  cate26,
  cate27,
  cate28,
  cate29,
  cate30,
  cate32,
  cate33,
  cate34,
  cate35,
  cate36,
  cate37,
  cate38,
  ;

  String get path => "assets/icons/category_png_icons/$name.png";

  @override
  String toString() => "assets/icons/category_png_icons/$name.png";

  const CategoryPngIcons();
}

extension GetIcon on String {
  CategoryPngIcons get getIcon {
    try {
      return CategoryPngIcons.values.firstWhere((element) => element.path == this);
    } catch (e) {
      return CategoryPngIcons.values.first;
    }
  }
}
