import 'package:flutter/material.dart';
import 'package:inkwanderers_mobile/reviews/models/review.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:inkwanderers_mobile/Catalogue/models/book.dart' as BookModel;
import 'package:http/http.dart' as http;
import 'dart:convert';
class BookReviewPage extends StatelessWidget {
  final BookModel.Book book;
  BookReviewPage({required this.book});
  Future<List<Review>> fetchReviewsForBook(BookModel.Book book) async {
  // Make an API request to fetch reviews for the selected book
  // You can use the book ID to filter reviews on the server side
  // Replace 'your_api_endpoint' with the actual API endpoint
  final response = await http.get(
    Uri.parse('https://inkwanderers.my.id/reviews/show-reviews/${book.pk}'),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<Review> reviewList = data.map((item) => Review.fromJson(item)).toList();
    return reviewList;
  } else {
    throw Exception('Failed to load reviews');
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews for ${book.fields.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display book information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 209,
                    width: 128,
                    child: Center(
                      child: Image.network(
                        book.fields.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Title: ${book.fields.title}'),
                  const SizedBox(height: 10),
                  Text('Author: ${book.fields.authors}'),
                  const SizedBox(height: 10),
                  Text('Rating: ${(book.fields.reviewPoints.toDouble()/book.fields.reviewCount.toDouble()).toStringAsFixed(2)}'),
                  const SizedBox(height: 10),
                  Text('Description: ${book.fields.description}'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0), // Specify your desired padding
              child: Text(
                'Reviews',
                style: TextStyle(fontSize: 20.0),
              ),
            ),

            // Display reviews
            FutureBuilder(
              future: fetchReviewsForBook(book),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Review> reviews = snapshot.data as List<Review>;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${reviews[index].user.username}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rating: ${reviews[index].rating}'),
                            Text('Review: ${reviews[index].review}'),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );

  }

}