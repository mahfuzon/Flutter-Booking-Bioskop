part of 'extensions.dart';

extension FirebaseUserExtension on FirebaseUser {
  User convertToUser({
    String name = "No Name",
    List<String> selectedGenres = const [],
    String selectedLanguage = 'Indonesian',
    int balance = 50000,
  }) =>
      User(
        this.uid,
        this.email,
        name: name,
        selectedLanguage: selectedLanguage,
        selectedGenres: selectedGenres,
        balance: balance,
      );
}
