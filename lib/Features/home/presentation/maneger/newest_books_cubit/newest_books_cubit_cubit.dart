import 'package:bloc/bloc.dart';
import 'package:bookly_app/Features/home/presentation/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/data/repos/Home_repo.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:equatable/equatable.dart';

part 'newest_books_cubit_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksCubitState> {
  NewestBooksCubit(this.homeRepo) : super(NewestBooksCubitInitial());

  final HomeRepo homeRepo;

  Future<void> fetchNewestBooks() async {
    emit(NewestBooksCubitLoading());
    var result = await homeRepo.fetchBestSellerBooks();
    result.fold(
      (Failure) {
        emit(NewestBooksCubitFailure(Failure.errMessage));
      },
      (books) {
        emit(NewestBooksCubitSuccess(books));
      },
    );
  }
}
