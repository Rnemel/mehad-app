abstract interface class WatchRepository {
  Future<bool> ping();
}

class FakeWatchRepository implements WatchRepository {
  @override
  Future<bool> ping() async => true;
}

