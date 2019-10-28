/* Classe responsável por listar todos os servidores
  diponíveis para teste.
   */
class Server{
  int id;
  String name;
  String dns;
  String host;
  String icon;

  Server(this.id, this.name, this.dns, this.host, this.icon);

  static List<Server> getServers(){
    return <Server>[
      Server(1,'Wikipédia', '185.201.54.47', 'https://www.wikipedia.org/', 'assets/wikipedia.svg'),
      Server(2,'Google', '216.58.222.68', 'https://www.google.com/', 'assets/google.svg'),
      Server(3,'Twitter', '104.244.42.65', 'https://twitter.com/', 'assets/google.svg'),
      Server(4,'Facebook', '157.240.12.35', 'https://www.facebook.com/', 'assets/google.svg'),
    ];
  }
}
