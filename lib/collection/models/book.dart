// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
    int pk;
    String model;
    Fields fields;

    Book({
        required this.pk,
        required this.model,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        pk: json["pk"],
        model: json["model"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "model": model,
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
    int review_points;
    int review_count;

    Fields({
        required this.title,
        required this.authors,
        required this.categories,
        required this.thumbnail,
        required this.description,
        required this.publishedYear,
        required this.review_count,
        required this.review_points
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        authors: json["authors"],
        categories: json["categories"],
        thumbnail: json["thumbnail"],
        description: json["description"],
        publishedYear: json["published_year"],
        review_count: json["review_count"],
        review_points: json["review_points"]
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "authors": authors,
        "categories": categories,
        "thumbnail": thumbnail,
        "description": description,
        "published_year": publishedYear,
        "review_count": review_count,
        "review_points": review_points
    };
}
