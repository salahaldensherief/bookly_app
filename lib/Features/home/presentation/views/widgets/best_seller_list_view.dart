import 'package:bookly_app/Features/home/presentation/maneger/newest_books_cubit/newest_books_cubit_cubit.dart';
import 'package:bookly_app/core/utils/custom_loading_indicator.dart';
import 'package:bookly_app/core/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'best_seller_list_view_item.dart';

class BestSellerListView extends StatelessWidget {
  const BestSellerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewestBooksCubit, NewestBooksCubitState>(
      builder: (context, state) {
        if (state is NewestBooksCubitSuccess) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: BookListViewItem(bookModel: state.books[index]),
              );
            },
          );
        } else if (state is NewestBooksCubitFailure) {
          return CustomErrorWidget(errMassege: state.errMassege);
        } else {
          return CustomLoadingIndicator();
        }
      },
    );
  }
}
