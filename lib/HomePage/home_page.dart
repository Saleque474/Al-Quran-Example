import 'package:al_quran/Classes/classes.dart';
import 'package:al_quran/Data/data.dart';
import 'package:al_quran/SurahPage/surahpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Surah> surahs = [];

  @override
  void initState() {
    for (int i = 0; i < quranData.length; i++) {
      surahs.add(Surah(
          surahNo: quranData[i]["Surah No"],
          name: quranData[i]["Name"],
          ayats: quranData[i]["Ayats"]));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF91C3A6),
        appBar: AppBar(
          title: Text(
            "Al Quran",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFFFFFF)),
          ),
          centerTitle: true,
          elevation: 4,
          backgroundColor: Color(0xFF469565),
        ),
        body: Align(
            alignment: Alignment(0, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ...surahs
                      .map((surah) => Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SurahPage(surah)));
                              },
                              child: Material(
                                color: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 3,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFc0cdc4),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(surah.name),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text("${surah.surahNo}"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList()
                ],
              ),
            )),
      ),
    );
  }
}
