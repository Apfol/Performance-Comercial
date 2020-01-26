import 'dart:convert';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  String valor;
  String totalImpInc;
  String coUsuario;
  DateTime dataEmissao;
  String comissaoCn;

  Report(
      {this.valor,
      this.totalImpInc,
      this.coUsuario,
      this.dataEmissao,
      this.comissaoCn});

  factory Report.fromJson(Map<String, dynamic> json) => Report(
      valor: json["valor"],
      totalImpInc: json["total_imp_inc"],
      coUsuario: json["co_usuario"],
      dataEmissao: DateTime.parse(json["data_emissao"]),
      comissaoCn: json["comissao_cn"]);

  Map<String, dynamic> toJson() => {
        "valor": valor,
        "total_imp_inc": totalImpInc,
        "co_usuario": coUsuario,
        "data_emissao":
            "${dataEmissao.year.toString().padLeft(4, '0')}-${dataEmissao.month.toString().padLeft(2, '0')}-${dataEmissao.day.toString().padLeft(2, '0')}",
        "comissao_cn": comissaoCn,
      };
}
