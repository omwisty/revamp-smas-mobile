class ReportRequestModel {
  String? dateFrom;
  String? dateTo;

  ReportRequestModel({
    this.dateFrom,
    this.dateTo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_from'] = dateFrom!;
    data['date_to'] = dateTo!;
    return data;
  }
}