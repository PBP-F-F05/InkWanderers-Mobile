// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    Model model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String title;
    String authors;
    String categories;
    String thumbnail;
    String description;
    int publishedYear;
    bool isBorrowed;
    int reviewCount;
    int reviewPoints;

    Fields({
        required this.title,
        required this.authors,
        required this.categories,
        required this.thumbnail,
        required this.description,
        required this.publishedYear,
        required this.isBorrowed,
        required this.reviewCount,
        required this.reviewPoints,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        authors: json["authors"],
        categories: json["categories"],
        thumbnail: json["thumbnail"],
        description: json["description"],
        publishedYear: json["published_year"],
        isBorrowed: json["is_borrowed"],
        reviewCount: json["review_count"],
        reviewPoints: json["review_points"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "authors": authors,
        "categories": categories,
        "thumbnail": thumbnail,
        "description": description,
        "published_year": publishedYear,
        "is_borrowed": isBorrowed,
        "review_count": reviewCount,
        "review_points": reviewPoints,
    };
}

enum Model {
    BOOK_BOOK
}

final modelValues = EnumValues({
    "book.book": Model.BOOK_BOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
