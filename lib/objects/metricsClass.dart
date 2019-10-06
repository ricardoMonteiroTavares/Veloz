import 'dart:io';
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
    int sucess = 0;                             // Contador de pacotes bem sucedidos
    DateTime i, f;                              // Variáveis que obtém a data e hora do sistema

    // Bloco de código que fará o teste 15 vezes
    for(int j = 0; j < 15; j++){
      i = DateTime.now();                       // Inicia o contador
      final response = await http.get(host);    // Faz a descarga do site usando o método GET da extensão http 
      f = DateTime.now();                       // Após a descarga, fecha o contador
      
      // Se o status foi de sucesso?
      if(response.statusCode == 200){
        length += (response.contentLength*8);     // Adiciona ao contador de tamanho, o tamanho da página em bits
        time += f.difference(i).inMilliseconds;   // Adiciona o tempo cronometrado ao contador de tempo
        sucess += 1;                              // Adiciona +1 nos testes de sucesso
      }
    }
    double velMed = (length/sucess)/(time/sucess);  // Faz a conta de velocidade média em kbps

    return velMed.round();                          // Retorna a velocidade média arredondada
  }

  /* 
    Função que testa a velocidade de upload da rede
      Entrada: O ip do site
      Saída: a velocidade em kbps
  */
  Future<int> uploadTest(String host) async {
    int time = 0;                               // Contador de tempo necessário para fazer o upload
    int sucess = 0;                             // Contador de testes bem sucedidos
    DateTime i, f;                              // Variáveis que obtém a data e hora do sistema
   
    // Bloco de código que cria o pacote de upload de 64 Kbytes
    String data = '\0'*63957; 
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"title": "Hello", "body": "{$data}", "userId": 1}';
    
    // Bloco de código que fará o teste 15 vezes
    for(int j = 0; j < 15; j++){
      i = DateTime.now();                                                       // Inicia o contador                                
      final response = await http.post(host, headers: headers, body: json);      // Envia o pacote para o ip
      f = DateTime.now();                                                       // Após o término do envio do pacote, termina o contador    
      // Se o status foi de sucesso?
      if(response.statusCode == 200){
        time += f.difference(i).inMilliseconds;   // Adiciona o tempo cronometrado ao contador de tempo
        sucess += 1;                              // Adiciona +1 nos testes de sucesso
      }
      
    }

    double velMed = (((64000*8)/sucess)/(time/sucess));      // Faz a conta de velocidade média em kbps

    return velMed.round();                                    // Retorna a velocidade média arredondada
  }
}