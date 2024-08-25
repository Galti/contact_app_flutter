enum LoadableBlocStatus { initial, loading, success, failure }

extension InfoProviding on LoadableBlocStatus {
  bool get isLoading => this == LoadableBlocStatus.initial || this == LoadableBlocStatus.loading;
}
