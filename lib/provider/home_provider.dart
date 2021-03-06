import 'package:flutter/material.dart';
import 'package:sigara_metre/pages/home/enum/stress_enum.dart';
import 'package:sigara_metre/model/smoke.dart';
import 'package:sigara_metre/repository/smoke_repository.dart';

enum TextState { INIT, LOADING, DONE }

class HomeProvider with ChangeNotifier {
  /* Properties */
  static List<Smoke> smokes = [];
  TextState textState = TextState.INIT;
  int intTotalSmoke = 0;
  int intTodaySmoke = 0;
  String strLastSmokeTime = "";

  // Future<List<Smoke>> getAllSmoke() async {
  //   // smoke liste boş ise sql den çek
  //   if (smokes.isEmpty) {
  //     smokes = await _getAllSmokeFromDB();
  //   }
  //   return smokes;
  // }

  /* Methods */
  void addSmoke(Stress stress) async {
    // eklenen sigara oluşturulur
    DateTime dateTimeNow = DateTime.now();
    Smoke smoke = Smoke(dateTimeNow, stress);
    // eklenen sigara db ve stackteki listeye kayıt edilir
    await SmokeRepository().insert(smoke);
    // last,today,total bilgileri yeniden alınır
    getCounts();
  }

  void getCounts() async {
    // last,today,total yazıları gizlenir
    if (textState != TextState.INIT) {
      textState = TextState.LOADING; // textler gizlenir
      notifyListeners();
    }

    List<Smoke> smokes = await SmokeRepository().getAll();
    // total count
    intTotalSmoke = smokes.length;
    // today count
    List<Smoke> tempSmokes = List.from(smokes);
    DateTime today = DateTime.now();
    tempSmokes = tempSmokes
        .where((x) =>
            x.dateTime.year == today.year &&
            x.dateTime.month == today.month &&
            x.dateTime.day == today.day)
        .toList(); // bugünkiler alınır
    intTodaySmoke = tempSmokes.length;
    // last smoke time long
    tempSmokes = List.from(smokes);
    tempSmokes.sort(
      (a, b) => (a.dateTime.toUtc().microsecondsSinceEpoch >
              b.dateTime.toUtc().microsecondsSinceEpoch)
          ? 1
          : 0,
    );
    Smoke tempSmoke;
    String _timeLongText = "";
    if (tempSmokes.length > 0) {
      tempSmoke = tempSmokes[tempSmokes.length - 1];
    }
    if (tempSmoke != null) {
      Duration timeDiff = today.difference(tempSmoke.dateTime);
      int inDays = timeDiff.inDays;
      int inHours = timeDiff.inHours;
      int inMinutes = timeDiff.inMinutes;
      int inSeconds = timeDiff.inSeconds;
      int tempResult = 0;
      if (inDays > 30) {
        tempResult = (inDays / 30).floor();
        _timeLongText += "$tempResult Month ";
        tempResult *= 30; // day
        inDays -= tempResult;
        tempResult *= 24; // hour
        inHours -= tempResult;
        tempResult *= 60; // minutes
        inMinutes -= tempResult;
        tempResult *= 60; // seconds
        inSeconds -= tempResult;
      }
      if (inDays > 0) {
        tempResult = inDays;
        _timeLongText += "$tempResult Day ";
        inDays -= tempResult;
        tempResult *= 24; // hour
        inHours -= tempResult;
        tempResult *= 60; // minutes
        inMinutes -= tempResult;
        tempResult *= 60; // seconds
        inSeconds -= tempResult;
      } else {
        if (inHours > 0) {
          tempResult = inHours;
          _timeLongText += "${tempResult}H ";
          inHours -= tempResult;
          tempResult *= 60; // minutes
          inMinutes -= tempResult;
          tempResult *= 60; // seconds
          inSeconds -= tempResult;
        }
        if (inMinutes > 0) {
          tempResult = inMinutes;
          _timeLongText += "${tempResult}m ";
          inMinutes -= tempResult;
          tempResult *= 60; // seconds
          inSeconds -= tempResult;
        }
        if (inSeconds >= 0) {
          // >= sebebi, yeni eklenen ile şu anki zamanın farkı 0 sn 10milisaniye falan olduğu için
          tempResult = inSeconds;
          if (_timeLongText.isEmpty && tempResult < 10) {
            _timeLongText = "Now";
          } else {
            _timeLongText += "${tempResult}s ";
          }
        }
      }
    }

    strLastSmokeTime = _timeLongText;

    textState = TextState.DONE; // textler görünür yapılır
    notifyListeners();
  }
}
