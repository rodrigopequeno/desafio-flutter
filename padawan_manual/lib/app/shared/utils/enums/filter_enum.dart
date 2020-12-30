enum FilterEnum { all, favorite }

extension FilterEnumExtension on FilterEnum {
  String get description {
    switch (this) {
      case FilterEnum.all:
        return "All";
        break;
      case FilterEnum.favorite:
        return "Favorites";
        break;
    }
    return "";
  }
}
