abstract class ItemsState<T> {}

class ItemsLoading<T> extends ItemsState<T> {}

class ItemsLoaded<T> extends ItemsState<T> {
  final List<T> items;
  ItemsLoaded(this.items);
}

class ItemsError<T> extends ItemsState<T> {
  final String message;
  ItemsError(this.message);
}
