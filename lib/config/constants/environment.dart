import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  
  static String theMovieDbKey = dotenv.env["THE_MOVIEDB_KEY"] ?? 'No hay api key';

  static String baseUrl = dotenv.env["BASE_URL"] ?? 'URL NO ESPECIFICA'; 

}