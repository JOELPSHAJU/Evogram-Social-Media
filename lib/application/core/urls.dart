String baseurl = 'https://3b5xb3l8-7002.inc1.devtunnels.ms/api';
//signup
String signup = '/users/send-otp';
String otpurl = '/users/verify-otp';
String loginurl = '/users/login';
//post
const String addpostUrl = '/posts/addPost';
const String getallPost = '/posts/getpost';
String addposturl = '/posts/addPost';
String fetchposturl = '/posts/getpost';
String fetchuserposturl = '/posts/getuserpost';
String deleteposturln = '/posts/delete-post';
String editposturl = '/posts/update-post';
String followersposturl = '/posts/allfollowingsPost';
String postlikeurl = '/posts/like-post';
String postunlikeurl = '/posts/unlike-post';
String fetchcommentsurl = '/posts/fetch-comments';
String addcommenturl = '/posts/add-comment';
String deletecommenturl = '/posts/delete-comment';
String saveposturl = '/posts/savePost';
String unsaveposturl = '/posts/savePosts';
String reportposturl = '/posts/report-post';
String savedposturl = '/posts/savePosts';
String exploreposturl = '/posts/exploreposts';
//users
String connectioncounturl = '/users/get-count';
String loginuserurl = '/users/getuser';
String editprofileurl = '/users/edit-profile';
String suggessionurl = '/users/fetch-users';
String followuserurl = '/users/follow';
String unfollowuserurl = '/users/unfollow';
String isfollowingurl = '/users/isFollowing';
String fetchfollowingurl = '/users/fetch-following';
String fetchfollowersurl = '/users/fetch-followers';
String searchusersurl = '/users/searchallusers?searchQuery=';
String getSingleuserurl = '/users/get-single-user';
String notificationurl = '/users/notifications';
String logginedUser = '/users/getuser';
String editProfile = '/users/edit-profile';
String getFollowing = '/users/fetch-following';
String getFollowers = '/users/fetch-followers';
String followUser = '/users/follow';
String unfollowUser = '/users/unfollow';
String suggessions = '/users/fetch-users';
String getSingleUser = '/users/get-single-user';
String getConnections = '/users/get-count';
String searchAllUsersurl = '/users/searchallusers?searchQuery=';
//chats
//chat urls
  const String createConversationurl = '/chats/conversation';
  const String getAllConversationsurl = '/chats/conversation';
  const String addMessageurl = '/chats/message';
  const String getAllMessagesurl = '/chats/message';

//google urls
const String googleLoginurl = '/users/google-login';
const String verifyOtpReset = '/users/verifyOtp?email=';
const String forgotPasswordurl = '/users/forgotPassword?email=';
const String updatePasswordurl = '/users/changepassword';

class PostUrls {
//post Urls
  static const String addpostUrl = '/posts/addPost';
  static const String getallPost = '/posts/getpost';
  static const String deletePost = '/posts/delete-post';
  static const String updatePost = '/posts/update-post';
  static const String getPostByUserId = '/posts/getuserpost';
  static const String likePost = '/posts/like-post';
  static const String unlikePost = '/posts/unlike-post';
  static const String commentPost = '/posts/add-comment';
  static const String getAllComments = '/posts/fetch-comments';
  static const String deleteComments = '/posts/delete-comment';
  static const String replayComments = '/posts/comments/reply-to';
  static const String allFollowingsPost = '/posts/allfollowingsPost';
  static const String savePost = '/posts/savePost';
  static const String fetchSavedPost = '/posts/savePosts';
  static const String removeSavedPost = '/posts/savePosts';
  static const String explorePosts = '/posts/exploreposts';

}
