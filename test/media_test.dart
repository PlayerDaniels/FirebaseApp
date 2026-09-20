import 'package:flutter_test/flutter_test.dart';

Map<String, List<double>> alunos = {
  'Maria': [8.0, 9.0],
  'Carla': [8.0, 9.0],
  'Elena': [9.0, 8.0],
  'Luiza': [8.0, 9.0],
};

void main() {
  test('Calcular médias', () {
    Map<String, double> medias = {};

    alunos.forEach((nome, notas) {
      double soma = 0;

      for (double nota in notas) {
        soma += nota;
      }

      medias[nome] = soma / notas.length;
    });

    expect(medias, {
      'Maria': 8.5,
      'Carla': 8.5,
      'Elena': 8.5,
      'Luiza': 8.5,
    });
  });
}