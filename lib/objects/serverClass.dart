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
      Server(2,'Google DNS 2', '8.8.4.4', 'https://www.wikipedia.org/', 'assets/google.svg'),
    ];
  }
}
