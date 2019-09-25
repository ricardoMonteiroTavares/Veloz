import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Metrics {

  /* 
    Função que testa o ping da rede
      Entrada: O ip do site
      Saída: o ping em milisegundos
  */
  Future<int> pingTest(String ip) async{
    int ping = 0;                               // Contador de ping
    DateTime i, f;                              // Variáveis que obtém a data e hora do sistema
    Socket s;                                   // Variável que permitirá a conexão

    // Bloco de código que fará o teste 15 vezes
    for(int j = 0; j < 15; j++){
      i = DateTime.now();                       // Inicia o contador
      s = await Socket.connect(ip,80);          // O socket tenta abrir a conexão
      f = DateTime.now();                       // Após a mensagem de retorno, termina o contador
      s.close();                                // Fecha a conexão
      ping += f.difference(i).inMilliseconds;   // Adiciona o tempo cronometrado ao contador ping
    }
    return (ping/15).round();                   // Retorna a média de ping
  }

  /* 
    Função que testa a velocidade e upload da rede
      Entrada: O endereço de host em http/https do site
      Saída: a velocidade em kbps
  */
  Future<int> downloadTest(String host) async{
    int time = 0;                               // Contador de tempo necessário para fazer o download
    int length = 0;                             // Contador do tamanho da página descargada em bits
    DateTime i, f;                              // Variáveis que obtém a data e hora do sistema

    // Bloco de código que fará o teste 15 vezes
    for(int j = 0; j < 15; j++){
      i = DateTime.now();                       // Inicia o contador
      final response = await http.get(host);    // Faz a descarga do site usando o método GET da extensão http 
      f = DateTime.now();                       // Após a descarga, fecha o contador
      length += (response.contentLength*8);     // Adiciona ao contador de tamanho, o tamanho da página em bits
      time += f.difference(i).inMilliseconds;   // Adiciona o tempo cronometrado ao contador de tempo
    }
    double velMed = (length/15)/(time/15);      // Faz a conta de velocidade média em kbps
    print('download');
    print((length/15));
    print((time/15));
    print(velMed);
    print('\n');
    return velMed.round();                      // Retorna a velocidade média arredondada
  }

  /* 
    Função que testa a velocidade de upload da rede
      Entrada: O ip do site
      Saída: a velocidade em kbps
  */
  Future<int> uploadTest(String ip) async {
    int time = 0;                               // Contador de tempo necessário para fazer o upload
    DateTime i, f;                              // Variáveis que obtém a data e hora do sistema
    Socket s;                                   // Variável que permitirá a conexão
    List<int> data = utf8.encode(('\0'*64000)); // Cria o pacote de upload de 64 Kbytes

    // Bloco de código que fará o teste 15 vezes
    for(int j = 0; j < 15; j++){
      s = await Socket.connect(ip, 80);         // O socket tenta abrir a conexão
      i = DateTime.now();                       // Inicia o contador
      s.add(data);                              // Envia o pacote para o ip
      f = DateTime.now();                       // Após o término do envio do pacote, termina o contador
      s.close();                                // Fecha a conexão
      time += f.difference(i).inMilliseconds;   // Adiciona o tempo cronometrado ao contador de tempo
    }

    double velMed = ((64000*8)/(time/15));      // Faz a conta de velocidade média em kbps
    print('upload');
    print((64000*8));
    print((time/15));
    print(velMed);
    print('\n');
    return velMed.round();                      // Retorna a velocidade média arredondada
  }
}