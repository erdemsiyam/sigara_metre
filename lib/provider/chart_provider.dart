import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sigara_metre/model/smoke.dart';
import 'package:sigara_metre/pages/home/enum/stress_enum.dart';
import 'package:sigara_metre/repository/smoke_repository.dart';

enum ChartData { INIT, LOADING, DONE }

class ChartProvider with ChangeNotifier {
  ChartData chartData = ChartData.INIT;
  List<FlSpot> spotSmokes = [],
      spotStressHigh = [],
      spotStressMedium = [],
      spotStressLow = [];
  List<double> _listSmokeDataHourly = [];
  List<List<double>> _listStressDataHourly = [];

  void deleteAllData() async {
    await SmokeRepository().deleteAll();
  }

  void getChartsData(DateTime startDate, DateTime endDate) async {
    // veriler sıfırlanır ön yüze bildirilir
    if (chartData != ChartData.INIT) {
      chartData = ChartData.LOADING;
      notifyListeners();
    }

    spotSmokes.clear();
    spotStressHigh.clear();
    spotStressMedium.clear();
    spotStressLow.clear();
    _listSmokeDataHourly.clear();
    _listStressDataHourly.clear();

    // girilen başlangıç ve bitiş tarihi arasındaki gün sayısı alınır
    int dayRange = endDate.difference(startDate).inDays + 1;

    // smoke verileri çekilir
    List<Smoke> smokes = await SmokeRepository().getAll();
    List<Smoke> tempSmokes = [];
    // saatlere göre sigara sayısı tutulacak liste oluşturulur
    _listSmokeDataHourly = new List<double>.generate(25, (i) => 0);
    _listStressDataHourly = new List<List<double>>.generate(
        25, (i) => new List<double>.generate(3, (index) => 0));

    // Seçilen Tarih aralığındaki tüm günler için dolaşılır smoke verileri alınır
    List<Smoke> tempSmokes2 = [];
    int dayCount = dayRange;
    for (int i = 0; i < dayCount; i++) {
      // her bir gün kontrol edilir, içinde veri olmayan gün varsa, toplam gün sayısından çıkarılır.
      DateTime nextDay = startDate.add(Duration(days: i));
      tempSmokes2 = smokes
          .where((x) =>
              x.dateTime.year == nextDay.year &&
              x.dateTime.month == nextDay.month &&
              x.dateTime.day == nextDay.day)
          .toList();
      if (tempSmokes2.length <= 0) {
        dayRange -= 1;
      } else {
        // içinde smoke verisi olan gün varsa, o veriler eklenir.
        tempSmokes.addAll(tempSmokes2);
      }
    }

    // Hangi saatte sigara içildi bilgileri listeye eklenir
    for (Smoke smoke in tempSmokes) {
      // içilen smoke sayısı
      _listSmokeDataHourly[smoke.dateTime.hour] += 1;
      // stress değeri eklenir
      _listStressDataHourly[smoke.dateTime.hour][smoke.stress - 1] += 1;
    }

    // Tarih aralığı seçilmişse, içilen sigara ortalaması alınır, ve stress ort.
    if (dayRange > 1) {
      for (int i = 0; i < _listSmokeDataHourly.length; i++) {
        // o saat içinde içilen sigaralar toplamı, kaç gün ise o kadara bölünür
        _listSmokeDataHourly[i] /= dayRange;
        // o saat içindeki stress toplamları, kaç gün ise o kadara bölünür
        _listStressDataHourly[i][0] /= dayRange;
        _listStressDataHourly[i][1] /= dayRange;
        _listStressDataHourly[i][2] /= dayRange;
        // virgülden sonra ilk basamağa kadar yuvarlanır.
        _listSmokeDataHourly[i] =
            double.parse(_listSmokeDataHourly[i].toStringAsFixed(1));
        _listStressDataHourly[i][0] =
            double.parse(_listStressDataHourly[i][0].toStringAsFixed(1));
        _listStressDataHourly[i][1] =
            double.parse(_listStressDataHourly[i][1].toStringAsFixed(1));
        _listStressDataHourly[i][2] =
            double.parse(_listStressDataHourly[i][2].toStringAsFixed(1));
      }
    }

    // Chart dote larına dönüşmesi
    _listSmokeDataHourly.forEach(
      (element) =>
          spotSmokes.add(FlSpot(spotSmokes.length.toDouble(), element)),
    );
    _listStressDataHourly.forEach(
      (element) => {
        spotStressLow.add(FlSpot(spotStressLow.length.toDouble(), element[0])),
        spotStressMedium
            .add(FlSpot(spotStressMedium.length.toDouble(), element[1])),
        spotStressHigh
            .add(FlSpot(spotStressHigh.length.toDouble(), element[2])),
      },
    );

    // veriler eklendi diye ön yüze haber verilir
    chartData = ChartData.DONE;
    notifyListeners();
  }
}
