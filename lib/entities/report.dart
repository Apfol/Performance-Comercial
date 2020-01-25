import 'dart:convert';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  String valor;
  String totalImpInc;

  Report({
    this.valor,
    this.totalImpInc,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        valor: json["valor"],
        totalImpInc: json["total_imp_inc"],
      );

  Map<String, dynamic> toJson() => {
        "valor": valor,
        "total_imp_inc": totalImpInc,
      };
}
