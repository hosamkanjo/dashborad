

class YearModel {
  final int? id;
  final String name;
  final String startDate;
  final String endDate;

  YearModel({
    this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  factory YearModel.fromJson(Map<String, dynamic> j) => YearModel(
        id: j['id'] is int ? j['id'] : int.tryParse('${j['id']}'),
        name: '${j['name']}',
        startDate: '${j['start_date']}',
        endDate: '${j['end_date']}',
      );
  Map<String, dynamic> toCreateJson() => {
        'name': name,
        'start_date': startDate, 
        'end_date': endDate,     
      };
}