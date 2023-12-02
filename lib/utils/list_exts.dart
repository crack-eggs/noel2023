extension ListExt on Iterable {
  /// Returns a new list with the elements of this that are not null.
  List<T> whereNotNull<T>() => whereType<T>().toList();

  /// return first element of list, if null return IterableElementError
  T firstOrError<T>() => firstWhere((element) => element is T) as T;
}
