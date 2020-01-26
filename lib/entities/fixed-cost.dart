import 'dart:convert';

FixedCost fixedCostFromJson(String str) => FixedCost.fromJson(json.decode(str));

String fixedCostToJson(FixedCost data) => json.encode(data.toJson());

class FixedCost {
  String brutSalario;
  String liqSalario;
  String coUsuario;
  DateTime dtAlteracao;

  FixedCost({
    this.brutSalario,
    this.liqSalario,
    this.coUsuario,
    this.dtAlteracao,
  });

  factory FixedCost.fromJson(Map<String, dynamic> json) => FixedCost(
        brutSalario: json["brut_salario"],
        liqSalario: json["liq_salario"],
        coUsuario: json["co_usuario"],
        dtAlteracao: DateTime.parse(json["dt_alteracao"]),
      );

  Map<String, dynamic> toJson() => {
        "brut_salario": brutSalario,
        "liq_salario": liqSalario,
        "co_usuario": coUsuario,
        "dt_alteracao":
            "${dtAlteracao.year.toString().padLeft(4, '0')}-${dtAlteracao.month.toString().padLeft(2, '0')}-${dtAlteracao.day.toString().padLeft(2, '0')}",
      };
}
