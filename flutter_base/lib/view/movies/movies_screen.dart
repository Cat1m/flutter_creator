import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter/bloc/movies_bloc/movies_bloc.dart';
import 'package:sample_flutter/configs/components/network_image_widget.dart';
import 'package:sample_flutter/data/response/status.dart';
import 'package:sample_flutter/generated/l10n/app_localizations.dart';
import 'package:sample_flutter/main.dart';
import 'package:sample_flutter/view/movies/widget/error_widget.dart';

import 'widget/widgets.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late MoviesBloc moviesBloc;
  @override
  void initState() {
    super.initState();
    moviesBloc = MoviesBloc(moviesApiRepository: getIt());
  }

  @override
  void dispose() {
    moviesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(AppLocalizations.of(context).popularShows),
          actions: const [
            LogoutButtonWidget(),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: BlocProvider(
          create: (_) => moviesBloc..add(MoviesFetch()),
          child: BlocBuilder<MoviesBloc, MoviesState>(
            buildWhen: (previous, current) =>
                previous.moviesList != current.moviesList,
            builder: (BuildContext context, state) {
              switch (state.moviesList.status) {
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());
                case Status.error:
                  return const MoviesErrorWidget();
                case Status.completed:
                  if (state.moviesList.data == null) {
                    return Text(AppLocalizations.of(context).noDataFound);
                  }
                  final movieList = state.moviesList.data!;
                  return ListView.builder(
                      itemCount: movieList.tvShows.length,
                      itemBuilder: (context, index) {
                        final tvShow = movieList.tvShows[index];
                        return Card(
                          child: ListTile(
                            leading: NetworkImageWidget(
                              borderRadius: 5,
                              imageUrl: tvShow.imageThumbnailPath.toString(),
                            ),
                            title: Text(tvShow.name.toString()),
                            subtitle: Text(tvShow.netWork.toString()),
                            trailing: Text(tvShow.status.toString()),
                          ),
                        );
                      });
                default:
                  return const SizedBox();
              }
            },
          ),
        ));
  }
}
