int avg(List<double> data){
  return ((data.reduce((curr, next) => curr + next))/data.length).round();
}