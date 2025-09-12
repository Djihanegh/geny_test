import '../../../../core/core.dart';

class BusinessDioProvider extends DioHttpProvider {
  BusinessDioProvider()
      : super(
          baseUrl: 'https://example.com/v0/',
        );

  Future<Map<String, dynamic>> getBusiness(int id) async {
    final result = await get('business/$id');
    return result.data!;
  }

  Future<Map<String, dynamic>> getAll() async {
    final result = await get('business/');
    return result.data!;
  }
}
