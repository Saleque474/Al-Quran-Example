import 'package:al_quran/settings_data/settings_data.dart';
import 'package:flutter/material.dart';
import 'package:al_quran/Classes/classes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurahPage extends StatefulWidget {
  final Surah surah;
  const SurahPage(this.surah, {Key? key}) : super(key: key);

  @override
  _SurahPageState createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  List<Ayat> ayats = [];
  bool showSettings = false;
  double arabicFontSize = 16;
  double banglaFontSize = 16;
  double englishFontSize = 16;
  bool showArabic = true;
  bool showBangla = true;
  bool showEnglish = true;

  @override
  void initState() {
    for (int i = 0; i < widget.surah.ayats.length; i++) {
      ayats.add(Ayat(
        ayat: widget.surah.ayats[i]["Ayat"],
        ayatNo: widget.surah.ayats[i]["Ayat No"],
        banglaTranslation: widget.surah.ayats[i]["Bangla Translation"],
        englishTranslation: widget.surah.ayats[i]["English Translation"],
      ));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SettingsData>(
        stream: LoadData().stream(),
        builder: (context, snapshot) {
          arabicFontSize =
              snapshot.hasData ? snapshot.data!.arabicFontSize : 16;
          banglaFontSize =
              snapshot.hasData ? snapshot.data!.banglaFontSize : 16;
          englishFontSize =
              snapshot.hasData ? snapshot.data!.englishFontSize : 16;
          showArabic = snapshot.hasData ? snapshot.data!.showArabic : true;
          showBangla = snapshot.hasData ? snapshot.data!.showBangla : true;
          showEnglish = snapshot.hasData ? snapshot.data!.showEnglish : true;

          return Scaffold(
            backgroundColor: Color(0xFF91C3A6),
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SettingsPage()));
                    },
                    icon: Icon(Icons.settings))
              ],
              backgroundColor: Color(0xFF469565),
              title: Text(
                widget.surah.name,
                style: TextStyle(fontSize: 20, fontFamily: "Kalpurush"),
              ),
              centerTitle: true,
            ),
            body: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: ayats.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Color(0xFFb4dbbc),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, -1),
                              color: Colors.black26,
                              blurRadius: 7)
                        ]),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ayats[index].ayatNo.toString()),
                        showArabic
                            ? Align(
                                alignment: Alignment(1, 0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ayats[index].ayat,
                                    style: TextStyle(
                                        fontFamily: "Katibeh",
                                        fontSize: arabicFontSize),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        showBangla
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Bangla \n" + ayats[index].banglaTranslation,
                                  style: TextStyle(
                                      fontFamily: "Kalpurush",
                                      fontSize: banglaFontSize),
                                ),
                              )
                            : SizedBox(),
                        showEnglish
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "English \n" +
                                      ayats[index].englishTranslation,
                                  style: TextStyle(
                                      fontFamily: "Lato",
                                      fontSize: englishFontSize),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  );
                }),
          );
        });
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double arabicFontSize = 16;
  double banglaFontSize = 16;
  double englishFontSize = 16;
  bool showArabic = true;
  bool showBangla = true;
  bool showEnglish = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SettingsData>(
        stream: LoadData().stream(),
        builder: (context, snapshot) {
          arabicFontSize =
              snapshot.hasData ? snapshot.data!.arabicFontSize : 16;
          banglaFontSize =
              snapshot.hasData ? snapshot.data!.banglaFontSize : 16;
          englishFontSize =
              snapshot.hasData ? snapshot.data!.englishFontSize : 16;
          showArabic = snapshot.hasData ? snapshot.data!.showArabic : true;
          showBangla = snapshot.hasData ? snapshot.data!.showBangla : true;
          showEnglish = snapshot.hasData ? snapshot.data!.showEnglish : true;

          return Scaffold(
            backgroundColor: Color(0xFF91C3A6),
            appBar: AppBar(
              backgroundColor: Color(0xFF469565),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.pages))
              ],
              title: Text("Settings"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  fontSizeChanger("arabicFontSize", "Arabic", arabicFontSize),
                  visibaleLang("showArabic", "Arabic", showArabic),
                  fontSizeChanger("banglaFontSize", "Bangla", banglaFontSize),
                  visibaleLang("showBangla", "Bangla", showBangla),
                  fontSizeChanger(
                      "englishFontSize", "English", englishFontSize),
                  visibaleLang("showEnglish", "English", showEnglish),
                ],
              ),
            ),
          );
        });
  }

  Widget fontSizeChanger(String key, String name, double fontSize) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Color(0xFFb4dbbc),
          borderRadius: BorderRadius.circular(
            10,
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(1, -1), color: Colors.black26, blurRadius: 7)
          ]),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "$name Font Size",
            style: TextStyle(fontSize: fontSize),
          ),
          Slider(
            onChanged: (val) {
              print(val);
              doubleSetter(key, val);
            },
            value: fontSize,
            max: 45,
            min: 4,
            divisions: 42,
          )
        ],
      ),
    );
  }

  doubleSetter(String key, double value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setDouble(key, value);
  }

  Widget visibaleLang(String key, String name, bool show) {
    return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Color(0xFFb4dbbc),
            borderRadius: BorderRadius.circular(
              10,
            ),
            boxShadow: [
              BoxShadow(
                  offset: Offset(1, -1), color: Colors.black26, blurRadius: 7)
            ]),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Show $name"),
            Checkbox(
                value: show,
                onChanged: (val) {
                  boolSetter(key, val);
                })
          ],
        ));
  }

  boolSetter(String key, bool? val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, val!);
  }
}
