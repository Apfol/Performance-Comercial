import 'dart:convert';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  double valor;
  double totalImpInc;
  String coUsuario;
  DateTime dataEmissao;
  double comissaoCn;
  double brutSalario;

  Report(
      {this.valor,
      this.totalImpInc,
      this.coUsuario,
      this.dataEmissao,
      this.comissaoCn,
      this.brutSalario});

  factory Report.fromJson(Map<String, dynamic> json) {
    if (json["brut_salario"] == null) {
      return Report(
        valor: double.parse(json["valor"]),
        totalImpInc: double.parse(json["total_imp_inc"]),
        coUsuario: json["co_usuario"],
        dataEmissao: DateTime.parse(json["data_emissao"]),
        comissaoCn: double.parse(json["comissao_cn"]),
        brutSalario: 0,
      );
    }
    return Report(
      valor: double.parse(json["valor"]),
      totalImpInc: double.parse(json["total_imp_inc"]),
      coUsuario: json["co_usuario"],
      dataEmissao: DateTime.parse(json["data_emissao"]),
      comissaoCn: double.parse(json["comissao_cn"]),
      brutSalario: double.parse(json["brut_salario"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "valor": valor,
        "total_imp_inc": totalImpInc,
        "co_usuario": coUsuario,
        "data_emissao":
            "${dataEmissao.year.toString().padLeft(4, '0')}-${dataEmissao.month.toString().padLeft(2, '0')}-${dataEmissao.day.toString().padLeft(2, '0')}",
        "comissao_cn": comissaoCn,
        "brut_salario": brutSalario
      };
}
