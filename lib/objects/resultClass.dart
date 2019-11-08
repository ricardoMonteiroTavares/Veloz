/*  Classe responsável por armazenar os resultados
 obtidos nos testes ou provenientes do Banco de Dados

 */
class ResultTest{
  int idServer;

  int latencyAvg;
  int downAvg;
  int upAvg;
  String date;

  ResultTest({this.idServer, this.latencyAvg, this.downAvg, this.upAvg, this.date});

  // Função que converte os dados recebidos do banco de dados em uma classe ResultTest 
  factory ResultTest.fromMap(Map<String, dynamic> json) => new ResultTest(
        idServer: json["IDSERVER"],
        latencyAvg: json["LATENCYAVG"],
        downAvg: json["DOWNAVG"],
        upAvg: json["UPAVG"],
        date: json["DATE"],
      );
}

  