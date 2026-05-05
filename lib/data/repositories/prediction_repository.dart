abstract interface class PredictionRepository {
  Future<Map<String, dynamic>> fetchLatest();
}

class FakePredictionRepository implements PredictionRepository {
  @override
  Future<Map<String, dynamic>> fetchLatest() async => <String, dynamic>{};
}

