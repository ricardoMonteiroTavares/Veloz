class ResultTest{
  int idServer;

  int pingAvg;
  int downAvg;
  int upAvg;
  String date;

  ResultTest({this.idServer, this.pingAvg, this.downAvg, this.upAvg, this.date});

  factory ResultTest.fromMap(Map<String, dynamic> json) => new ResultTest(
        idServer: json["IDSERVER"],
        pingAvg: json["PINGAVG"],
        downAvg: json["DOWNAVG"],
        upAvg: json["UPAVG"],
        date: json["DATE"],
      );
}

  