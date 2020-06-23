class Values {
  final String country ;
  final double min;
  final double avg;
  final double max;

  Values(
    this.country,
    this.min,
    this.avg,
    this.max,
  );

  static Values fromJson(Map<String,dynamic> json){
    double sum = json['ins'].reduce((a, b) => a + b);
    double ins = sum/json['ins'].length ;
    sum = json['min'].reduce((a, b) => a + b);
    double min = sum/json['min'].length ;
    sum = json['avg'].reduce((a, b) => a + b);
    double avg = sum/json['avg'].length ;
    sum = json['max'].reduce((a, b) => a + b);
    double max = sum/json['max'].length ;
    return Values(json['Country'],min,avg,max) ;
  }
}
