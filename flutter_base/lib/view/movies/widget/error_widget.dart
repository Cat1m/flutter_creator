import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter/bloc/movies_bloc/movies_bloc.dart';
import 'package:sample_flutter/configs/components/internet_exception_widget.dart';
import 'package:sample_flutter/generated/l10n/app_localizations.dart';

class MoviesErrorWidget extends StatelessWidget {
  const MoviesErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (previous, current) =>
          previous.moviesList != current.moviesList,
      builder: (context, state) {
        if (state.moviesList.message.toString() ==
            AppLocalizations.of(context).noInternetConnection) {
          return InternetExceptionWidget(
            onPressed: () {
              context.read<MoviesBloc>().add(MoviesFetch());
            },
          );
        } else {
          return InkWell(
            onTap: () {
              context.read<MoviesBloc>().add(MoviesFetch());
            },
            child: Center(
              child: Text(state.moviesList.message.toString()),
            ),
          );
        }
      },
    );
  }
}
