import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/cat_fact.dart';

part 'cat_fact_service.g.dart';

@RestApi(baseUrl: "https://cat-fact.herokuapp.com")
abstract class CatFactService {
  factory CatFactService.create() {
    final dio = Dio();
    return _CatFactService(dio);
  }

  @GET("/facts/random?animal_type=cat&amount=10")
  Future<List<CatFact>> getRandomCatFacts();
}