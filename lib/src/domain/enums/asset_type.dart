enum AssetType {
  stock(name: 'Ações', abbreviation: 'Ação'),
  reit(name: 'Fundos imobiliários', abbreviation: 'FII');

  const AssetType({required this.name, required this.abbreviation});

  final String name;
  final String abbreviation;
}
