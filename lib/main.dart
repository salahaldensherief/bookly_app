import 'package:bookly_app/Features/home/presentation/data/repos/home_repo_impl.dart';
import 'package:bookly_app/Features/home/presentation/maneger/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/maneger/newest_books_cubit/newest_books_cubit_cubit.dart';
import 'package:bookly_app/core/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Features/Splash/presentation/views/splash_view.dart';
import 'constants.dart';
import 'core/utils/app_router.dart';

void main() {
  setupServiceLocator();
  runApp(const Bookly());
}

class Bookly extends StatelessWidget {
  const Bookly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  FeaturedBooksCubit(getIt.get<HomeRepoImpl>())
                    ..fetchBooksFeatured(),
        ),
        BlocProvider(
          create:
              (context) =>
                  NewestBooksCubit(getIt.get<HomeRepoImpl>())
                    ..fetchNewestBooks(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme: GoogleFonts.montserratTextTheme(
            ThemeData.dark().textTheme,
          ),
        ),
      ),
    );
  }
}
