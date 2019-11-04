# Veloz

---

## Descrição

É um aplicativo que faz testes de Ping, Download e Upload usando os principais sites acessados no Brasil. E mostra gráficos dos testes, além do cálculo dos valores médios e a variação mínima e máxima de acordo com site escolhido.

---

## Motivação

Ele foi desenvolvido como projeto de aplicação para a matéria de Redes 1 para Sistemas de Informação, ministrado pelo Professor Flávio Seixas na Universidade Federal Fluminense.

---

## Orientações para a leitura do aplicativo

1. Foi desenvolvido com base no padrão BLoC do Flutter.
2. O código dentro da pasta lib está inteiramente comentado
3. Dentro da pasta lib têm as seguintes pastas
  * HistoryPage, HomePage, TestPage: Que são as páginas de Histórico (onde são mostrados os gráficos), Início e de Testes do aplicativo
  * objects: São classes responsáveis pelo teste em si (metricsClass.dart), gerenciamento dos servidores de teste (serverClass.dart), banco de dados SQLite (dataase.dart) e seu conversor dos valores vindos do banco de dados para uma classe onde será usado para geração dos gráficos (resultClass.dart)
  * functions: São funções comuns que são usados em mais de uma Página e que não há a necessidade de se criar uma nova classe
