import 'dart:io';

class Metrics {
  Future<int> pingTest(String ip) async{
    int ping = 0;
    for(int i = 0; i < 15; i++){
      DateTime i = DateTime.now();
      Socket s = await Socket.connect(ip,80);
      DateTime f = DateTime.now();
      s.close();
      ping += f.difference(i).inMilliseconds;
    }
    return (ping/15).round();
  }
}