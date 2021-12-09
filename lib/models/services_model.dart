class ServicesModel {
  String? title;
  String? requirements;
  String? serviceTime;

  ServicesModel({this.title, this.requirements, this.serviceTime});

  // receiving data from server
  factory ServicesModel.fromMap(map) {
    return ServicesModel(
      title: map['title'],
      requirements: map['requirements'],
      serviceTime: map['service time'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'requirements': requirements,
      'service time': serviceTime,
      
    };
  }
}
