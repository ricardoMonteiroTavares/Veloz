class Server{
  int id;
  String name;
  String dns;

  Server(this.id, this.name, this.dns);

  static List<Server> getServers(){
    return <Server>[
      Server(1,'Google DNS 1', '185.201.54.47'),
      Server(2,'Google DNS 2', '8.8.4.4'),
    ];
  }
}
