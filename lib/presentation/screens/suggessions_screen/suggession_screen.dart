import 'package:evogram/application/core/constants.dart';
import 'package:evogram/presentation/bloc/fetch_suggession_user_bloc/fetch_suggession_user_bloc.dart';
import 'package:evogram/presentation/bloc/follow_unfollow_user_bloc/follow_unfollow_user_bloc.dart';
import 'package:evogram/presentation/screens/suggessions_screen/followers_loading.dart';
import 'package:evogram/presentation/screens/widgets/text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SuggessionScreen extends StatefulWidget {
  const SuggessionScreen({super.key});

  @override
  State<SuggessionScreen> createState() => _SuggessionScreenState();
}

class _SuggessionScreenState extends State<SuggessionScreen> {
  @override
  void initState() {
    context
        .read<FetchSuggessionUserBloc>()
        .add(SuggessionUserInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: Color.fromARGB(255, 196, 196, 196),
          ),
        ),
        backgroundColor:
            Theme.of(context).brightness == Brightness.light ? white : black,
        surfaceTintColor:
            Theme.of(context).brightness == Brightness.light ? white : black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: appbarTitle(title: 'Suggessions'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FollowUnfollowUserBloc(),
          ),
          BlocProvider(
            create: (context) => FetchSuggessionUserBloc()
              ..add(SuggessionUserInitialFetchEvent()),
          ),
        ],
        child: BlocListener<FollowUnfollowUserBloc, FollowUnfollowUserState>(
          listener: (context, followState) {
            if (followState is FollowUserSuccesfulState ||
                followState is UnFollowUserSuccesfulState) {
              // Refetch suggestions after follow/unfollow action
              context
                  .read<FetchSuggessionUserBloc>()
                  .add(SuggessionUserInitialFetchEvent());
            }
          },
          child: BlocBuilder<FetchSuggessionUserBloc, FetchSuggessionUserState>(
            builder: (context, state) {
              if (state is FetchSuggessionSucessState) {
                if (state.suggessionUserModel.data.isEmpty) {
                  return const Center(
                    child: Text(
                      'No suggestions available at the moment.',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                } else {
                  // Display list of suggestions
                  return ListView.builder(
                      itemCount: state.suggessionUserModel.data.length,
                      itemBuilder: (context, index) {
                        if (kDebugMode) {
                          print(state.suggessionUserModel.data);
                        }
                        var suggession = state.suggessionUserModel.data[index];

                        return BlocBuilder<FollowUnfollowUserBloc,
                            FollowUnfollowUserState>(
                          builder: (context, followstate) {
                            if (state is FollowUserLoadingState) {
                              Center(
                                child: LoadingAnimationWidget.discreteCircle(
                                    color: white, size: 50),
                              );
                            }
                            return ListTile(
                              leading: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            suggession.profilePic.toString()),
                                        fit: BoxFit.cover)),
                              ),
                              title: Text(
                                suggession.userName.toString(),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                suggession.name != null
                                    ? suggession.name.toString()
                                    : 'guest10${index}23$index',
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              trailing: MaterialButton(
                                  minWidth: 80,
                                  height: 27,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side:
                                          const BorderSide(color: blueaccent2)),
                                  onPressed: () {
                                    return context
                                        .read<FollowUnfollowUserBloc>()
                                        .add(FollowUserButtonClickEvent(
                                            followeesId:
                                                suggession.id.toString()));
                                  },
                                  child: const Text('Follow',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: blueaccent2,
                                          fontSize: 13))),
                            );
                          },
                        );
                      });
                }
              } else if (state is FetchSuggessionLoadingState) {
                return followersLoading(context);
              } else if (state is FetchSuggessionUserErrorState) {
                return const Center(
                  child: Text(
                    'Failed to load suggestions. Please try again later.',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    'No suggestions available at the moment.',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
