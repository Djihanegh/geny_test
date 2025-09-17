abstract class ItemsState<T> {}

class ItemsLoading<T> extends ItemsState<T> {}

class ItemsLoaded<T> extends ItemsState<T> {
  ItemsLoaded(this.items);
  final List<T> items;
}

class ItemsError<T> extends ItemsState<T> {
  ItemsError(this.message);
  final String message;
}
