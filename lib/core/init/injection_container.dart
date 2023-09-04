import 'dart:convert';

import 'package:chat_app/feature/auth/data/repositories/auth_repo_impl.dart';
import 'package:chat_app/feature/auth/presentation/view_model/login_view_model.dart';
import 'package:chat_app/feature/auth/presentation/view_model/register_view_model.dart';
import 'package:chat_app/feature/auth/presentation/view_model/verify_email_view_model.dart';
import 'package:chat_app/feature/message/data/datasources/message_remote_data_source.dart';
import 'package:chat_app/feature/message/data/repositories/message_repo_impl.dart';
import 'package:chat_app/feature/message/presentation/view_model/chat_view_model.dart';
import 'package:chat_app/feature/message/presentation/view_model/message_view_model.dart';
import 'package:get_it/get_it.dart';

import 'package:chat_app/core/_core_exports.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //? SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton<SharedPreferencesRepository>(() => SharedPreferencesRepositoryImpl(sl()));

  sl.registerLazySingleton(() => GetDataFromKey(sl()));
  sl.registerLazySingleton(() => RemoveDataFromKey(sl()));
  sl.registerLazySingleton(() => SaveDataFromKey(sl()));

  // sl.registerLazySingleton(() => UserModel());

  // sl.registerSingletonAsync<UserModel>(
  //   () async {
  //     final getDataFromKey = sl<GetDataFromKey>();
  //     final getDataFromKeyEither =
  //         await getDataFromKey(SharedPreferenceKeyParams(key: SharedPreferencesKeys.CACHE_USER_INFO));

  //     return getDataFromKeyEither.fold(
  //       (failure) {
  //         return UserModel();
  //       },
  //       (jsonData) {
  //         Map<String, dynamic> data = json.decode(jsonData);

  //         UserModel localAccount = UserModel.fromMap(data);
  //         return localAccount;
  //       },
  //     );
  //   },
  // );

  //* Authentication

  sl.registerLazySingleton(() => AuthRemoteDataSource());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginViewModel());
  sl.registerLazySingleton(() => RegisterViewModel());
  sl.registerLazySingleton(() => VerifyEmailViewModel());

  // //* Message

  sl.registerLazySingleton(() => MessageRemoteDataSource());

  sl.registerLazySingleton<MessageRepo>(() => MessageRepositoryImpl(sl()));

  sl.registerLazySingleton(() => MessageViewModel(messageRepo: sl()));
  sl.registerLazySingleton(() => ChatViewModel(messageRepo: sl()));
}
