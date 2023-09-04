import 'package:chat_app/core/utils/local_data_source/shared_preferences/domain/entities/shared_preferences_keys.dart';

class SharedPreferenceKeyWithValueParams {
  final SharedPreferencesKeys key;
  final String value;

  SharedPreferenceKeyWithValueParams({required this.key, required this.value});
}
