import 'package:bloc/bloc.dart';
import 'package:bookly_app/Features/home/presentation/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/data/repos/Home_repo.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:equatable/equatable.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.homeRepo) : super(FeaturedBooksInitial());
  final HomeRepo homeRepo;

  Future<void> fetchBooksFeatured() async {
    emit(FeaturedBooksLoading());
    var result = await homeRepo.fetchFeaturedBooks();
    result.fold(
      (Failure) {
        emit(FeaturedBooksFailure(Failure.errMessage));
      },
      (books) {
        emit(FeaturedBooksSuccess(books));
      },
    );
  }
}
