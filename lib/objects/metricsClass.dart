import 'dart:io';
import 'package:http/http.dart' as http;

class Metrics {
  Future<int> pingTest(String ip) async{
    int ping = 0;
    DateTime i, f;
    Socket s;
    for(int j = 0; j < 15; j++){
      i = DateTime.now();
      s = await Socket.connect(ip,80);
      f = DateTime.now();
      s.close();
      ping += f.difference(i).inMilliseconds;
    }
    return (ping/15).round();
  }
  Future<int> downloadTest(String host) async{
    int vel = 0;
    int length = 0;
    DateTime i, f;
    for(int j = 0; j < 15; j++){
      i = DateTime.now();
      final response = await http.get(host);
      f = DateTime.now();
      length += (response.contentLength*8);
      vel += f.difference(i).inMilliseconds;
    }
    double velMed = (length/15)/(vel/15);
    
    return velMed.round();   
  }

  Future<int> uploadTest(String ip) async {
    int vel = 0;
    DateTime i, f;
    Socket s;
    String data = '\0'*64000;
    int port = 80;
    print(port);
    for(int j = 0; j < 15; j++){
      s = await Socket.connect(ip, port);
      i = DateTime.now();
      s.write(data);
      f = DateTime.now();
      s.close();
      vel += f.difference(i).inMilliseconds;
    }

    double velMed = ((64000*8)/(vel/15))/1000;
    print((64000*8));
    print((vel/15));
    print(velMed);
    return velMed.round();
  }
}