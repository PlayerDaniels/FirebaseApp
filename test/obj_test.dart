import 'package:flutter_test/flutter_test.dart';

abstract class Pessoa {
  late int _id;
  String nome;

  Pessoa(this.nome);

  int get id => _id;

  set id(int id) {
    if (id > 0) {
      _id = id;
    } else {
      throw ArgumentError('Identificador deve ser não negativo.');
    }
  }
}

mixin Ano {
  late int _ano;

  int get ano => _ano;

  set ano(int ano) {
    if (ano > 0) {
      _ano = ano;
    } else {
      throw ArgumentError('Ano deve ser não negativo.');
    }
  }
}

class Aluno extends Pessoa with Ano {
  Aluno(super.nome, int ano) {
    this.ano = ano;
  }
}

class Professor extends Pessoa {
  Professor(super.nome);
}

class Disciplina {
  String nome;

  Disciplina(this.nome);
}

class Turma with Ano {
  Disciplina disciplina;
  Professor professor;
  final List<Aluno> _alunos = [];

  Turma(this.disciplina, this.professor, int ano) {
    this.ano = ano;
  }

  void matricular(Aluno aluno) {
    if (aluno.ano == ano) {
      _alunos.add(aluno);
    } else {
      throw ArgumentError('Ano deve ser mesmo.');
    }
  }
}

class Historico extends Turma {
  Map<Aluno, List<double>> notas = {};

  Historico(super.disciplina, super.professor, super.ano);

  @override
  void matricular(Aluno aluno) {
    super.matricular(aluno);
    notas[aluno] = [];
  }

  double media(Aluno aluno) {
    double media = 0;

    for (double nota in notas[aluno]!) {
      media += nota;
    }

    media /= notas[aluno]!.length;

    return media;
  }

  // Verifica se o aluno foi aprovado
  bool isAprovado(Aluno aluno) {
    return media(aluno) > 6;
  }
}

void main() {
  test('Testar matrícula de alunos', () {
    Disciplina disciplina1 = Disciplina('Flutter');

    Professor professor1 = Professor('João');
    professor1.id = 1;

    Historico historico1 = Historico(
      disciplina1,
      professor1,
      2023,
    );

    Aluno aluno1 = Aluno('Maria', 2023);
    aluno1.id = 2;

    historico1.matricular(aluno1);

    expect(historico1.media(aluno1), 0.0);

    Aluno aluno2 = Aluno('Paula', 2022);

    try {
      aluno2.id = 0;
    } catch (error) {
      expect(error, isA<ArgumentError>());
    }

    try {
      historico1.matricular(aluno2);
    } catch (error) {
      expect(error, isA<ArgumentError>());
    }
  });

  // NOVO TESTE
test('Verificar aprovação do aluno', () {
  Disciplina disciplina1 = Disciplina('Flutter');

  Professor professor1 = Professor('João');
  professor1.id = 1;

  Historico historico1 = Historico(
    disciplina1,
    professor1,
    2023,
  );

  Aluno aluno1 = Aluno('Maria', 2023);
  aluno1.id = 2;

  historico1.matricular(aluno1);

  historico1.notas[aluno1] = [7.0, 8.0, 9.0];

  print('Média: ${historico1.media(aluno1)}');
  print('Aprovado: ${historico1.isAprovado(aluno1)}');

  expect(historico1.media(aluno1), 8.0);
  expect(historico1.isAprovado(aluno1), true);
});
}