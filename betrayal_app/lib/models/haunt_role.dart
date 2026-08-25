enum HauntRole {
  survivor('Sobrevivente', 'sobrevivente'),
  traitor('Traidor', 'traidor');

  final String displayName;
  final String urlPath;
  const HauntRole(this.displayName, this.urlPath);
}
