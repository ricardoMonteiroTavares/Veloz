import 'dart:io';
import 'package:http/http.dart' as http;

class Metrics {

  /* 
    Função que testa o latência da rede
      Entrada: O ip do site
      Saída: o latência em milisegundos
  */
  Future<int> latencyTest(String ip) async{
    int latency = 0;                               // Contador de latency
    DateTime i, f;                              // Variáveis que obtém a data e hora do sistema
    Socket s;                                   // Variável que permitirá a conexão

    // Bloco de código que fará o teste 15 vezes
    for(int j = 0; j < 15; j++){
      i = DateTime.now();                       // Inicia o contador
      try{
        s = await Socket.connect(ip,80);          // O socket tenta abrir a conexão
        f = DateTime.now();                       // Após a mensagem de retorno, termina o contador
        s.close();                                // Fecha a conexão
        latency += f.difference(i).inMilliseconds;   // Adiciona o tempo cronometrado ao contador latency
      }catch(e){
        return -1;
      }
     
    }
    return (latency/15).round();                   // Retorna a média de latency
  }

  /* 
    Função que testa a velocidade e upload da rede
      Entrada: O endereço de host em http/https do site
      Saída: a velocidade em kbps
  */
  Future<int> downloadTest(String host) async{
    int time;                                   // Contador de tempo necessário para fazer o download
    int length;                                 // Contador do tamanho da página descargada em bits
    DateTime i, f;                              // Variáveis que obtém a data e hora do sistema

    i = DateTime.now();                         // Inicia o contador
    try{
      final response = await http.get(host);      // Faz a descarga do site usando o método GET da extensão http 
      f = DateTime.now();                         // Após a descarga, fecha o contador
      
      // Se o status foi de sucesso?
      if(response.statusCode == 200){
        length = (response.contentLength*8);      // Adiciona ao contador de tamanho, o tamanho da página em bits
        time = f.difference(i).inMilliseconds;    // Adiciona o tempo cronometrado ao contador de tempo
        double vel = (length)/(time);             // Faz a conta de velocidade em kbps
        return vel.round();                       // Retorna a velocidade arredondada
      }
      return -1;    // Se não foi bem sucedido retorna -1
    }catch(e){
      return -1;    // Se deu erro ao abrir também retorna -1
    }
  }

  /* 
    Função que testa a velocidade de upload da rede
      Entrada: O ip do site
      Saída: a velocidade em kbps
  */
  Future<int> uploadTest(String host) async {
    int time;                                   // Contador de tempo necessário para fazer o upload
    DateTime i, f;                              // Variáveis que obtém a data e hora do sistema
   
    // Bloco de código que cria o pacote de upload de 64 Kbytes
    String data = '0'*63924; 
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"title": "Hello", "body": "{$data}", "userId": 1}';
    
    i = DateTime.now();                                                       // Inicia o contador                                
    try{
      final response = await http.post(host, headers: headers, body: json);      // Envia o pacote para o ip
      f = DateTime.now();                                                       // Após o término do envio do pacote, termina o contador    
    
      // Se o status foi de sucesso?
      if(response.statusCode == 200){
        time = f.difference(i).inMilliseconds;                  // Adiciona o tempo cronometrado ao contador de tempo
        double vel = ((64000*8)/(time));                        // Faz a conta de velocidade em kbps
        return vel.round();                                     // Retorna a velocidade arredondada
      }
      return -1;    // Se não foi bem sucedido retorna -1
    }catch(e){
      return -1;   // Se ocorreu erro na tentativa de conexão também retorna -1 
    }
  }
}
