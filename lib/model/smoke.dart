import 'package:sigara_metre/pages/home/enum/stress_enum.dart';

class Smoke {
  DateTime
      dateTime; // yıl/ay/gün ve saat/dakika/saniye (son sigara bilgisini göstermek için)
  int stress; // 3-stressli 2-normal 1-iyi
  Smoke(this.dateTime, Stress stress) {
    switch (stress) {
      case Stress.LOW:
        this.stress = 1;
        break;
      case Stress.MEDIUM:
        this.stress = 2;
        break;
      case Stress.HIGH:
        this.stress = 3;
    }
  }
  Smoke.fromMap(Map<String, dynamic> map) {
    this.dateTime = DateTime.fromMicrosecondsSinceEpoch(map['datetime'] as int);
    this.stress = map['stress'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["datetime"] = this.dateTime.toUtc().microsecondsSinceEpoch;
    map["stress"] = this.stress;
    return map;
  }
}
