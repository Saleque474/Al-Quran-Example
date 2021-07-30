import 'package:shared_preferences/shared_preferences.dart';

class SettingsData {
  double arabicFontSize;
  double banglaFontSize;
  double englishFontSize;
  bool showArabic;
  bool showBangla;
  bool showEnglish;
  SettingsData(
    this.arabicFontSize,
    this.banglaFontSize,
    this.englishFontSize,
    this.showArabic,
    this.showBangla,
    this.showEnglish,
  );
}

class LoadData {
  double arabicFontSize = 16;
  double banglaFontSize = 16;
  double englishFontSize = 16;
  bool showArabic = true;
  bool showBangla = true;
  bool showEnglish = true;
  Stream<SettingsData> stream() async* {
    SharedPreferences pref = await SharedPreferences.getInstance();
    yield* Stream.periodic(Duration(milliseconds: 300), (t) {
      arabicFontSize = pref.getDouble("arabicFontSize") ?? 16;
      banglaFontSize = pref.getDouble("banglaFontSize") ?? 16;
      englishFontSize = pref.getDouble("englishFontSize") ?? 16;
      showArabic = pref.getBool("showArabic") ?? true;
      showBangla = pref.getBool("showBangla") ?? true;
      showEnglish = pref.getBool("showEnglish") ?? true;
      return SettingsData(
        arabicFontSize,
        banglaFontSize,
        englishFontSize,
        showArabic,
        showBangla,
        showEnglish,
      );
    });
  }
}
