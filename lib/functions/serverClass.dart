class Server{
  int id;
  String name;
  String dns;

  Server(this.id, this.name, this.dns);

  static List<Server> getServers(){
    return <Server>[
      Server(1,'Google DNS 1', '8.8.8.8'),
      Server(1,'Google DNS 2', '8.8.4.4'),
    ];
  }
}