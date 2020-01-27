import 'dart:convert';

import 'package:comercial_performance/entities/monthly-report.dart';
import 'package:comercial_performance/entities/report.dart';
import 'package:comercial_performance/pages/chart-page.dart';
import 'package:flutter/material.dart';

Consultor consultorFromJson(String str) => Consultor.fromJson(json.decode(str));

String consultorToJson(Consultor data) => json.encode(data.toJson());

class Consultor {
  String coUsuario;
  String noUsuario;
  String dsSenha;
  String coUsuarioAutorizacao;
  String nuMatricula;
  DateTime dtNascimento;
  DateTime dtAdmissaoEmpresa;
  String dtDesligamento;
  String dtInclusao;
  DateTime dtExpiracao;
  String nuCpf;
  String nuRg;
  String noOrgaoEmissor;
  String ufOrgaoEmissor;
  String dsEndereco;
  String noEmail;
  String noEmailPessoal;
  String nuTelefone;
  String dtAlteracao;
  String urlFoto;
  String instantMessenger;
  String icq;
  String msn;
  String yms;
  String dsCompEnd;
  String dsBairro;
  String nuCep;
  String noCidade;
  String ufCidade;
  String dtExpedicao;
  String coTipoUsuario;
  String inAtivo;
  String coSistema;
  bool isChecked = false;
  var borderColor = Colors.white;
  List<Report> reports = new List();
  List<MonthlyReport> monthlyReports = new List();
  bool isReportsAssigned = false;
  List<SerieConsultor> serieConsultores = new List();
  bool isSerieSet = false;

  Consultor({
    this.coUsuario,
    this.noUsuario,
    this.dsSenha,
    this.coUsuarioAutorizacao,
    this.nuMatricula,
    this.dtNascimento,
    this.dtAdmissaoEmpresa,
    this.dtDesligamento,
    this.dtInclusao,
    this.dtExpiracao,
    this.nuCpf,
    this.nuRg,
    this.noOrgaoEmissor,
    this.ufOrgaoEmissor,
    this.dsEndereco,
    this.noEmail,
    this.noEmailPessoal,
    this.nuTelefone,
    this.dtAlteracao,
    this.urlFoto,
    this.instantMessenger,
    this.icq,
    this.msn,
    this.yms,
    this.dsCompEnd,
    this.dsBairro,
    this.nuCep,
    this.noCidade,
    this.ufCidade,
    this.dtExpedicao,
    this.coTipoUsuario,
    this.inAtivo,
    this.coSistema,
  });

  setMonthlyReports() {
    if (!isReportsAssigned) {
      double netEarning = 0;
      double fixedCost = 0;
      double commission = 0;

      for (int i = 1; i <= 12; i++) {
        setMonthlyReport(i, netEarning, fixedCost, commission);
      }
      isReportsAssigned = true;
    }
  }

  setMonthlyReport(
      int month, double netEarning, double fixedCost, double commission) {
    for (var r in reports) {
      if (r.dataEmissao.month == month) {
        netEarning += r.valor - (r.valor * (r.totalImpInc / 100));
        commission += (r.valor - (r.valor * (r.totalImpInc / 100))) *
            (r.comissaoCn / 100);
        fixedCost = r.brutSalario;
      }
    }
    if (commission != 0 || netEarning != 0 || fixedCost != 0) {
      switch (month) {
        case DateTime.january:
          monthlyReports.add(
            new MonthlyReport(
                month: "Enero de 2007",
                netEarning: netEarning,
                fixedCost: fixedCost,
                commission: commission,
                profit: netEarning - (fixedCost + commission)),
          );
          break;
        case DateTime.february:
          monthlyReports.add(
            new MonthlyReport(
                month: "Febrero de 2007",
                netEarning: netEarning,
                fixedCost: fixedCost,
                commission: commission,
                profit: netEarning - (fixedCost + commission)),
          );
          break;
        case DateTime.march:
          monthlyReports.add(
            new MonthlyReport(
                month: "Marzo de 2007",
                netEarning: netEarning,
                fixedCost: fixedCost,
                commission: commission,
                profit: netEarning - (fixedCost + commission)),
          );
          break;
        case DateTime.april:
          monthlyReports.add(
            new MonthlyReport(
                month: "Abril de 2007",
                netEarning: netEarning,
                fixedCost: fixedCost,
                commission: commission,
                profit: netEarning - (fixedCost + commission)),
          );
          break;
        case DateTime.may:
          monthlyReports.add(
            new MonthlyReport(
                month: "Mayo de 2007",
                netEarning: netEarning,
                fixedCost: fixedCost,
                commission: commission,
                profit: netEarning - (fixedCost + commission)),
          );
          break;
        case DateTime.june:
          monthlyReports.add(
            new MonthlyReport(
                month: "Junio de 2007",
                netEarning: netEarning,
                fixedCost: fixedCost,
                commission: commission,
                profit: netEarning - (fixedCost + commission)),
          );
          break;
        case DateTime.july:
          monthlyReports.add(
            new MonthlyReport(
                month: "Julio de 2007",
                netEarning: netEarning,
                fixedCost: fixedCost,
                commission: commission,
                profit: netEarning - (fixedCost + commission)),
          );
          break;
        case DateTime.august:
          monthlyReports.add(
            new MonthlyReport(
                month: "Agosto de 2007",
                netEarning: netEarning,
                fixedCost: fixedCost,
                commission: commission,
                profit: netEarning - (fixedCost + commission)),
          );
          break;
        case DateTime.september:
          monthlyReports.add(
            new MonthlyReport(
                month: "Septiembre de 2007",
                netEarning: netEarning,
                fixedCost: fixedCost,
                commission: commission,
                profit: netEarning - (fixedCost + commission)),
          );
          break;
        case DateTime.october:
          monthlyReports.add(
            new MonthlyReport(
                month: "Octubre de 2007",
                netEarning: netEarning,
                fixedCost: fixedCost,
                commission: commission,
                profit: netEarning - (fixedCost + commission)),
          );
          break;
        case DateTime.november:
          monthlyReports.add(
            new MonthlyReport(
                month: "Noviembre de 2007",
                netEarning: netEarning,
                fixedCost: fixedCost,
                commission: commission,
                profit: netEarning - (fixedCost + commission)),
          );
          break;
        case DateTime.december:
          monthlyReports.add(
            new MonthlyReport(
                month: "Diciembre de 2007",
                netEarning: netEarning,
                fixedCost: fixedCost,
                commission: commission,
                profit: netEarning - (fixedCost + commission)),
          );
          break;
        default:
      }
    }
    netEarning = 0;
    fixedCost = 0;
    commission = 0;
  }

  factory Consultor.fromJson(Map<String, dynamic> json) => Consultor(
        coUsuario: json["co_usuario"],
        noUsuario: json["no_usuario"],
        dsSenha: json["ds_senha"],
        coUsuarioAutorizacao: json["co_usuario_autorizacao"],
        nuMatricula: json["nu_matricula"],
        dtNascimento: DateTime.parse(json["dt_nascimento"]),
        dtAdmissaoEmpresa: DateTime.parse(json["dt_admissao_empresa"]),
        dtDesligamento: json["dt_desligamento"],
        dtInclusao: json["dt_inclusao"],
        dtExpiracao: DateTime.parse(json["dt_expiracao"]),
        nuCpf: json["nu_cpf"],
        nuRg: json["nu_rg"],
        noOrgaoEmissor: json["no_orgao_emissor"],
        ufOrgaoEmissor: json["uf_orgao_emissor"],
        dsEndereco: json["ds_endereco"],
        noEmail: json["no_email"],
        noEmailPessoal: json["no_email_pessoal"],
        nuTelefone: json["nu_telefone"],
        dtAlteracao: json["dt_alteracao"],
        urlFoto: json["url_foto"],
        instantMessenger: json["instant_messenger"],
        icq: json["icq"],
        msn: json["msn"],
        yms: json["yms"],
        dsCompEnd: json["ds_comp_end"],
        dsBairro: json["ds_bairro"],
        nuCep: json["nu_cep"],
        noCidade: json["no_cidade"],
        ufCidade: json["uf_cidade"],
        dtExpedicao: json["dt_expedicao"],
        coTipoUsuario: json["co_tipo_usuario"],
        inAtivo: json["in_ativo"],
        coSistema: json["co_sistema"],
      );

  Map<String, dynamic> toJson() => {
        "co_usuario": coUsuario,
        "no_usuario": noUsuario,
        "ds_senha": dsSenha,
        "co_usuario_autorizacao": coUsuarioAutorizacao,
        "nu_matricula": nuMatricula,
        "dt_nascimento":
            "${dtNascimento.year.toString().padLeft(4, '0')}-${dtNascimento.month.toString().padLeft(2, '0')}-${dtNascimento.day.toString().padLeft(2, '0')}",
        "dt_admissao_empresa":
            "${dtAdmissaoEmpresa.year.toString().padLeft(4, '0')}-${dtAdmissaoEmpresa.month.toString().padLeft(2, '0')}-${dtAdmissaoEmpresa.day.toString().padLeft(2, '0')}",
        "dt_desligamento": dtDesligamento,
        "dt_inclusao": dtInclusao,
        "dt_expiracao":
            "${dtExpiracao.year.toString().padLeft(4, '0')}-${dtExpiracao.month.toString().padLeft(2, '0')}-${dtExpiracao.day.toString().padLeft(2, '0')}",
        "nu_cpf": nuCpf,
        "nu_rg": nuRg,
        "no_orgao_emissor": noOrgaoEmissor,
        "uf_orgao_emissor": ufOrgaoEmissor,
        "ds_endereco": dsEndereco,
        "no_email": noEmail,
        "no_email_pessoal": noEmailPessoal,
        "nu_telefone": nuTelefone,
        "dt_alteracao": dtAlteracao,
        "url_foto": urlFoto,
        "instant_messenger": instantMessenger,
        "icq": icq,
        "msn": msn,
        "yms": yms,
        "ds_comp_end": dsCompEnd,
        "ds_bairro": dsBairro,
        "nu_cep": nuCep,
        "no_cidade": noCidade,
        "uf_cidade": ufCidade,
        "dt_expedicao": dtExpedicao,
        "co_tipo_usuario": coTipoUsuario,
        "in_ativo": inAtivo,
        "co_sistema": coSistema,
      };
}
