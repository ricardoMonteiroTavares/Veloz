class Server{
  int id;
  String name;
  String dns;
  String host;

  Server(this.id, this.name, this.dns, this.host);

  static List<Server> getServers(){
    return <Server>[
      Server(1,'Google DNS 1', '185.201.54.47', 'https://www.wikipedia.org/'),
      Server(2,'Google DNS 2', '8.8.4.4', 'https://www.wikipedia.org/'),
    ];
  }
}
