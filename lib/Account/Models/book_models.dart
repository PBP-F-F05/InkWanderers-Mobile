// To parse this JSON data, do
//
//     final historyBookToBook = historyBookToBookFromJson(jsonString);

import 'dart:convert';

HistoryBookToBook historyBookToBookFromJson(String str) => HistoryBookToBook.fromJson(json.decode(str));

String historyBookToBookToJson(HistoryBookToBook data) => json.encode(data.toJson());

class HistoryBookToBook {
    int id;
    HistoryBook historyBook;
    Book book;
    DateTime dateAdded;

    HistoryBookToBook({
        required this.id,
        required this.historyBook,
        required this.book,
        required this.dateAdded,
    });

    factory HistoryBookToBook.fromJson(Map<String, dynamic> json) => HistoryBookToBook(
        id: json["id"],
        historyBook: HistoryBook.fromJson(json["history_book"]),
        book: Book.fromJson(json["book"]),
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "history_book": historyBook.toJson(),
        "book": book.toJson(),
        "date_added": "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
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

class HistoryBook {
    int id;
    Profile profile;

    HistoryBook({
        required this.id,
        required this.profile,
    });

    factory HistoryBook.fromJson(Map<String, dynamic> json) => HistoryBook(
        id: json["id"],
        profile: Profile.fromJson(json["profile"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "profile": profile.toJson(),
    };
}

class Profile {
    int id;
    User user;
    String profilePictureUrl;
    int limitRent;

    Profile({
        required this.id,
        required this.user,
        required this.profilePictureUrl,
        required this.limitRent,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        user: User.fromJson(json["user"]),
        profilePictureUrl: json["profile_picture_url"],
        limitRent: json["limit_rent"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "profile_picture_url": profilePictureUrl,
        "limit_rent": limitRent,
    };
}

class User {
    int id;
    String password;
    DateTime lastLogin;
    bool isSuperuser;
    String username;
    String firstName;
    String lastName;
    String email;
    bool isStaff;
    bool isActive;
    DateTime dateJoined;
    int role;
    List<dynamic> groups;
    List<dynamic> userPermissions;

    User({
        required this.id,
        required this.password,
        required this.lastLogin,
        required this.isSuperuser,
        required this.username,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.isStaff,
        required this.isActive,
        required this.dateJoined,
        required this.role,
        required this.groups,
        required this.userPermissions,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        password: json["password"],
        lastLogin: DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
        role: json["role"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "last_login": lastLogin.toIso8601String(),
        "is_superuser": isSuperuser,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined.toIso8601String(),
        "role": role,
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
    };
}


// To parse this JSON data, do
//
//     final rankBookToBook = rankBookToBookFromJson(jsonString);


RankBookToBook rankBookToBookFromJson(String str) => RankBookToBook.fromJson(json.decode(str));

String rankBookToBookToJson(RankBookToBook data) => json.encode(data.toJson());

class RankBookToBook {
    int id;
    Book book;
    int booksCount;
    int rankBook;

    RankBookToBook({
        required this.id,
        required this.book,
        required this.booksCount,
        required this.rankBook,
    });

    factory RankBookToBook.fromJson(Map<String, dynamic> json) => RankBookToBook(
        id: json["id"],
        book: Book.fromJson(json["book"]),
        booksCount: json["books_count"],
        rankBook: json["rank_book"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "book": book.toJson(),
        "books_count": booksCount,
        "rank_book": rankBook,
    };
}
