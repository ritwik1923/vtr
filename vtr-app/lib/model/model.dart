import 'dart:convert';
import 'dart:html' show File;

class Photo {
  final String contentType;
  final String path;
  final File image;

  Photo({this.contentType, this.path, this.image});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      contentType: json['contentType'] as String,
      path: json['path'] as String,
      image: json['image'] as File,
    );
  }
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

// Future<List<Photo>> fetchPhotos(http.Client client) async {
//   final response =
//       await client.get('https://jsonplaceholder.typicode.com/photos');

//   return parsePhotos(response.body);
// }
