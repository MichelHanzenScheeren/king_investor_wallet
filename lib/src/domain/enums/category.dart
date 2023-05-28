enum Category {
  stock(name: 'Ações', abbreviation: 'Ação'),
  reit(name: 'Fundos imobiliários', abbreviation: 'FII');

  const Category({required this.name, required this.abbreviation});

  final String name;
  final String abbreviation;
}
