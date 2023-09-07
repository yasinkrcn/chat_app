import 'dart:convert';

import 'package:chat_app/feature/auth/data/repositories/auth_repo_impl.dart';

import 'package:chat_app/feature/message/data/datasources/message_remote_data_source.dart';
import 'package:chat_app/feature/message/data/repositories/message_repo_impl.dart';
import 'package:chat_app/feature/message/presentation/view_model/chat_view_model.dart';
import 'package:chat_app/feature/message/presentation/view_model/message_view_model.dart';
import 'package:chat_app/feature/settings/data/datasources/settings_remote_data_source.dart';
import 'package:chat_app/feature/settings/data/repositories/settings_repo_impl.dart';
import 'package:chat_app/feature/settings/domain/repositories/settings_repo.dart';
import 'package:chat_app/feature/settings/presentation/view_model/settings_view_model.dart';
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

  sl.registerSingletonAsync<UserModel>(
    () async {
      final authRepository = sl<AuthRepository>();

      UserModel user = UserModel();

      bool isUserActive = FirebaseAuth.instance.currentUser?.uid != null;

      if (isUserActive) {
        var res = await authRepository.getUserInfo(userId: FirebaseAuth.instance.currentUser!.uid);

        res.fold((failure) {
          user;
        }, (data) {
          user = data;
        });
      }

      return user;
    },
  );

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

  //* Bottom Navigation Bar
  sl.registerLazySingleton(() => BottomNavBarViewModel());

  // //* Message

  sl.registerLazySingleton(() => MessageRemoteDataSource());

  sl.registerLazySingleton<MessageRepo>(() => MessageRepositoryImpl(sl()));

  sl.registerLazySingleton(() => MessageViewModel(messageRepo: sl()));
  sl.registerLazySingleton(() => ChatViewModel(messageRepo: sl()));

  //* Settings

  sl.registerLazySingleton(() => SettingsRemoteDataSource());

  sl.registerLazySingleton<SettingsRepo>(() => SettingsRepoImpl(sl()));

  sl.registerLazySingleton(() => SettingsViewModel());
}
