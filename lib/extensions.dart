extension ListExtension<T> on List<T> {

  T? firstWhereOrNull(bool Function(T obj) condition) {
    for (T element in this) {
      if (condition(element)) return element;
    }
    return null;
  }

}