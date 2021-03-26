import 'package:sigara_metre/pages/home/enum/stress_enum.dart';

class Smoke {
  DateTime
      dateTime; // yıl/ay/gün ve saat/dakika/saniye (son sigara bilgisini göstermek için)
  Stress stress; // 2-stressli 1-normal 0-iyi
  Smoke(this.dateTime, Stress stress);
  Smoke.fromMap(Map<String, dynamic> map) {
    this.dateTime = DateTime.fromMicrosecondsSinceEpoch(map['datetime'] as int);
    switch (map['stress'] as int) {
      case 2:
        this.stress = Stress.LOW;
        break;
      case 1:
        this.stress = Stress.MEDIUM;
        break;
      case 0:
        this.stress = Stress.HIGH;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["datetime"] = this.dateTime.toUtc().microsecondsSinceEpoch;
    map["stress"] = this.stress;
    switch (this.stress) {
      case Stress.LOW:
        map["stress"] = 2;
        break;
      case Stress.MEDIUM:
        map["stress"] = 1;
        break;
      case Stress.HIGH:
        map["stress"] = 0;
    }
    return map;
  }
}
