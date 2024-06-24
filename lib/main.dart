import 'package:evogram/application/core/constants.dart';
import 'package:evogram/firebase_options.dart';
import 'package:evogram/presentation/bloc/add_message/add_message_bloc.dart';
import 'package:evogram/presentation/bloc/add_post_bloc/addpost_bloc.dart';
import 'package:evogram/presentation/bloc/all_followers_posts_bloc/all_followers_posts_bloc.dart';
import 'package:evogram/presentation/bloc/comment_post_bloc/comment_post_bloc.dart';
import 'package:evogram/presentation/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:evogram/presentation/bloc/delete_comment_bloc/delete_comment_bloc.dart';
import 'package:evogram/presentation/bloc/edit_post_bloc/edit_post_bloc.dart';
import 'package:evogram/presentation/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_all_conversations_bloc.dart/fetch_all_conversations_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_explore_post_bloc/fetch_explore_post_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_followers/fetch_followers_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_followings_bloc/fetch_followings_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_suggession_user_bloc/fetch_suggession_user_bloc.dart';
import 'package:evogram/presentation/bloc/follow_unfollow_user_bloc/follow_unfollow_user_bloc.dart';
import 'package:evogram/presentation/bloc/forget_password_bloc/forgetpassword_bloc.dart';
import 'package:evogram/presentation/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:evogram/presentation/bloc/get_connections_bloc/get_connections_bloc.dart';
import 'package:evogram/presentation/bloc/like_unlike_post_bloc/like_post_bloc.dart';
import 'package:evogram/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:evogram/presentation/bloc/login_user_bloc/login_user_bloc.dart';
import 'package:evogram/presentation/bloc/otp_bloc/bloc/otp_bloc.dart';
import 'package:evogram/presentation/bloc/profile_details_bloc/profile_details_bloc.dart';
import 'package:evogram/presentation/bloc/profile_posts_bloc/profile_bloc.dart';
import 'package:evogram/presentation/bloc/saved_post_bloc/saved_post_bloc.dart';
import 'package:evogram/presentation/bloc/search_all_users_bloc/search_all_users_bloc.dart';
import 'package:evogram/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:evogram/infrastructure/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:evogram/presentation/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(
          create: (context) => OtpBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => ForgetpasswordBloc(),
        ),
        BlocProvider(
          create: (context) => AddpostBloc(),
        ),
        BlocProvider(
          create: (context) => FetchingUserPostBloc(),
        ),
        BlocProvider(
          create: (context) => LoginUserBloc(),
        ),
        BlocProvider(
          create: (context) => EditPostBloc(),
        ),
        BlocProvider(
          create: (context) => EditProfileBloc(),
        ),
        BlocProvider(
          create: (context) => FollowUnfollowUserBloc(),
        ),
        BlocProvider(
          create: (context) => FetchSuggessionUserBloc(),
        ),
        BlocProvider(
          create: (context) => FetchFollowersBloc(),
        ),
        BlocProvider(
          create: (context) => FetchFollowingsBloc(),
        ),
        BlocProvider(
          create: (context) => AllFollowersPostsBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => CommentPostBloc(),
        ),
        BlocProvider(
          create: (context) => DeleteCommentBloc(),
        ),
        BlocProvider(
          create: (context) => GetCommentsBloc(),
        ),
        BlocProvider(
          create: (context) => FetchSavedPostsBloc(),
        ),
        BlocProvider(
          create: (context) => LikePostBloc(),
        ),
        BlocProvider(
          create: (context) => SavedPostBloc(),
        ),
         BlocProvider(
          create: (context) => FetchAllConversationsBloc(),
        ),
        BlocProvider(
          create: (context) => FetchExplorePostBloc(),
        ),
        BlocProvider(
          create: (context) => SearchAllUsersBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
         BlocProvider(
          create: (context) => GetConnectionsBloc(),
        ),
         BlocProvider(
          create: (context) => AddMessageBloc(),
        ),
        BlocProvider(
          create: (context) => ConversationBloc(),
        ),
      
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        themeMode: ThemeMode.system,
        theme: ThemeData(
            tabBarTheme: const TabBarTheme(
                overlayColor: WidgetStatePropertyAll(
              white,
            )),
            brightness: Brightness.light,
            scaffoldBackgroundColor: white,
            appBarTheme: const AppBarTheme(
              color: white,
              iconTheme: IconThemeData(
                color: black,
              ),
              surfaceTintColor: white,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 20, color: black),
            ),
            primaryColor: blueaccent3,
            fontFamily: GoogleFonts.inter().fontFamily,
            textTheme: TextTheme(
                bodyLarge: GoogleFonts.roboto(),
                bodyMedium: GoogleFonts.roboto(),
                bodySmall: GoogleFonts.roboto())),
        darkTheme: ThemeData.dark(),
        /* dark theme settings */

        // ThemeData(
        //    ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
