import 'package:bookly_app/Features/home/presentation/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BookModel>>> fetchBestSellerBooks();
  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks();
  Future<Either<Failure, List<BookModel>>> fetchSimilarBooks({
    required String category,
  });
}
