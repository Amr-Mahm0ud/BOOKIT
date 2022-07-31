const String baseURL = "https://api.themoviedb.org/3";
const String apiKey = "e7302dacbb60b612c56d6c2e5028e5d4";
const String imageURL = "https://image.tmdb.org/t/p/w500/";

class EndPoints {
  static const trending = '$baseURL/trending/movie/week?api_key=$apiKey';
  static const topRated = '$baseURL/movie/top_rated?api_key=$apiKey';
  static const allMovies = '$baseURL/discover/movie?api_key=$apiKey';
  static const allGenres = '$baseURL/genre/movie/list?api_key=$apiKey';
}
