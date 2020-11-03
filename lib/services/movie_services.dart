part of "services.dart";

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page";

    client ??= http.Client();
    var response = await client.get(url);
    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data["results"];
    return result.map((e) => Movie.fromJson(e)).toList();
  }

  // Method untuk mendapatkan details dari movie yang sedang dipilih
  static Future<MovieDetail> getDetails(Movie movie,
      {http.Client client}) async {
    // buat avriabel untuk menampung url API
    String url =
        "https://api.themoviedb.org/3/movie/${movie.id}?api_key=$apiKey&language=en-US";

    client ??= http.Client();

    // Membuat koneksi dengan API
    var response = await client.get(url);

    // ubah data API menjadi bentuk json
    var data = json.decode(response.body);

    // mengambil data json yang memiliki nilai key "genres" dan dimasukkan kedalam List
    List genres = (data as Map<String, dynamic>)['genres'];
    String language;

    // mengambil data json yang memiliki nilai key "original_language" lalu diubah ke dalam String
    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'ja':
        language = "Japanese";
        break;
      case 'id':
        language = "Indonesia";
        break;
      case 'ko':
        language = "Korea";
        break;
      case 'en':
        language = "English";
        break;
    }

    // mengembalikan objek berupa MovieDetail
    return MovieDetail(
      movie,
      language: language,
      // mengambil nilai json dengan key "name" kemudian diubah menjadi List<String>
      genres: genres
          .map((e) => (e as Map<String, dynamic>)['name'].toString())
          .toList(),
    );
  }

  // Method untuk mendapatkan aktor dari film yang dipilih
  static Future<List<Credit>> getCredits(int movieID,
      {http.Client client}) async {
    // membuat variabel untuk menampung URL API
    String url =
        "https://api.themoviedb.org/3/movie/$movieID/credits?api_key=$apiKey";
    client ??= http.Client();
    // membuat koneksi dengan API
    var response = await client.get(url);
    // ubah data API menjadi bentuk Json
    var data = json.decode(response.body);

    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((e) => Credit(
            name: (e as Map<String, dynamic>)['name'],
            profilePath: (e as Map<String, dynamic>)['profile_path']))
        .take(8)
        .toList();
  }
}
