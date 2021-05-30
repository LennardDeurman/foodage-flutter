extension ListExtensions<T> on List<T> {
  void replace(T originalObject, T newObject) {
    final currentIndex = indexOf(originalObject);
    removeAt(currentIndex);
    insert(currentIndex, newObject);
  }

  T? firstWhereOrNull(bool Function(T obj) condition) {
    for (T element in this) {
      if (condition(element)) return element;
    }
    return null;
  }

}

extension IntersperseExtensions<T> on Iterable<T> {
  Iterable<T> intersperse(T element) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield element;
        yield iterator.current;
      }
    }
  }
}