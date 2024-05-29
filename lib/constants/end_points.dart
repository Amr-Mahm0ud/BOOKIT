const String baseURL = "https://api.themoviedb.org/3";
const String apiKey = "e7302dacbb60b612c56d6c2e5028e5d4";
const String imageURL = "https://image.tmdb.org/t/p/w500/";
const String videoURL = "https://www.youtube.com/watch?v=";

class EndPoints {
  static const trending = '$baseURL/trending/movie/week?api_key=$apiKey';
  static const topRated = '$baseURL/movie/top_rated?api_key=$apiKey';
  static const latest = '$baseURL/movie/latest?api_key=$apiKey';
  static const nowPlaying = '$baseURL/movie/now_playing?api_key=$apiKey';
  static const popular = '$baseURL/movie/popular?api_key=$apiKey';
  static const upcoming = '$baseURL/movie/upcoming?api_key=$apiKey';
  static const allMovies = '$baseURL/discover/movie?api_key=$apiKey';
  static const allGenres = '$baseURL/genre/movie/list?api_key=$apiKey';
  static const searchByName = '$baseURL/search/movie?api_key=$apiKey&query=';
}
