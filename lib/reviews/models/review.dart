// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';
import 'package:inkwanderers_mobile/Account/Models/account_models.dart';
List<Review> reviewFromJson(String str) => List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
    int id;
    User user;
    Book book;
    int rating;
    String review;

    Review({
        required this.id,
        required this.user,
        required this.book,
        required this.rating,
        required this.review,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        user: User.fromJson(json["user"]),
        book: Book.fromJson(json["book"]),
        rating: json["rating"],
        review: json["review"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "book": book.toJson(),
        "rating": rating,
        "review": review,
    };
}

class Book {
    int id;
    String title;
    String authors;
    String categories;
    String thumbnail;
    String description;
    int publishedYear;
    bool isBorrowed;
    int reviewCount;
    int reviewPoints;

    Book({
        required this.id,
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

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
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
        "id": id,
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

// class User {
//     int id;
//     String password;
//     DateTime lastLogin;
//     bool isSuperuser;
//     String username;
//     String firstName;
//     String lastName;
//     String email;
//     bool isStaff;
//     bool isActive;
//     DateTime dateJoined;
//     int role;
//     List<dynamic> groups;
//     List<dynamic> userPermissions;

//     User({
//         required this.id,
//         required this.password,
//         required this.lastLogin,
//         required this.isSuperuser,
//         required this.username,
//         required this.firstName,
//         required this.lastName,
//         required this.email,
//         required this.isStaff,
//         required this.isActive,
//         required this.dateJoined,
//         required this.role,
//         required this.groups,
//         required this.userPermissions,
//     });

//     factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         password: json["password"],
//         lastLogin: DateTime.parse(json["last_login"]),
//         isSuperuser: json["is_superuser"],
//         username: json["username"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         email: json["email"],
//         isStaff: json["is_staff"],
//         isActive: json["is_active"],
//         dateJoined: DateTime.parse(json["date_joined"]),
//         role: json["role"],
//         groups: List<dynamic>.from(json["groups"].map((x) => x)),
//         userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "password": password,
//         "last_login": lastLogin.toIso8601String(),
//         "is_superuser": isSuperuser,
//         "username": username,
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//         "is_staff": isStaff,
//         "is_active": isActive,
//         "date_joined": dateJoined.toIso8601String(),
//         "role": role,
//         "groups": List<dynamic>.from(groups.map((x) => x)),
//         "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
//     };
// }
