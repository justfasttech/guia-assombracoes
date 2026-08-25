const Map<String, String> tileNameTranslations = {
  'Cozinha': 'Kitchen',
  'Despensa': 'Larder',
  'Sala de Jantar': 'Dining Room',
  'Sala do Pânico': 'Panic Room',
  'Cemitério': 'Graveyard',
  'Sala da Fornalha': 'Furnace Room',
  'Forno': 'Furnace Room',
  'Laboratório': 'Laboratory',
  'Quartos de Hóspedes': 'Guest Quarters',
  'Quartos de hóspedes': 'Guest Quarters',
  'Quarto Principal': 'Primary Bedroom',
  'Quarto principal': 'Primary Bedroom',
  'Quarto de Inverno': 'Winter Bedroom',
  'Quarto de inverno': 'Winter Bedroom',
  'Biblioteca': 'Library',
  'Salão de Baile': 'Ballroom',
  'Sala de Cirurgia': 'Operating Theatre',
  'Sala de Operações': 'Operating Theatre',
  'Sala de Lixo': 'Junk Room',
  'Observatório': 'Observatory',
  'Capela': 'Chapel',
  'Berçário': 'Nursery',
  'Arsenal': 'Armory',
  'Sala Ritual': 'Ritual Room',
  'Catacumbas': 'Catacombs',
  'Torre': 'Tower',
  'Galeria': 'Gallery',
  'Corredor de Estatuas': 'Statuary Corridor',
  'Conservatório': 'Conservatory',
  'Caverna Subterrânea': 'Underground Cavern',
  'Lago Subterrâneo': 'Underground Lake',
  'Quarto Sangrento': 'Bloody Room',
  'Sala Carbonizada': 'Charred Room',
  'Sala Desmoronada': 'Collapsed Room',
  'Sala Desabada': 'Collapsed Room',
  'Sala de Amostras': 'Specimen Room',
  'Sala de Jogos': 'Game Room',
  'Quarto Insonorizado': 'Soundproofed Room',
  'Ginásio': 'Gymnasium',
  'Cofre': 'Vault',
  'Corredor Estatuário': 'Statuary Corridor',
  'Adega': 'Wine Cellar',
  'Cripta': 'Crypt',
  'Masmorra': 'Dungeon',
  'Abismo': 'Chasm',
  'Elevador Místico': 'Mystic Elevator',
  'Sala do Órgão': 'Organ Room',
  'Pátio': 'Patio',
  'Jardins': 'Gardens',
  'Sala de Estar': 'Drawing Room',
  'Varanda': 'Balcony',
  'Sacada': 'Balcony',
  'Sótão': 'Attic',
  'Corredor Rangente': 'Creaky Hallway',
  'Corredor Empoeirado': 'Dusty Hallway',
  'Hall de Entrada': 'Entrance Hall',
  'Saguão': 'Foyer',
  'Escadaria Principal': 'Grand Staircase',
  'Alojamento dos Servos': "Servants' Quarters",
  'Sala de Sessão Espírita': 'Séance Room',
  'Quarto': 'Bedroom',
};

const Map<String, String> floorTranslations = {
  'Térreo': 'Ground',
  'Piso Superior': 'Upper',
  'Porão': 'Basement',
  'Cave': 'Basement',
  'Chão': 'Ground',
};

String annotateTileLine(String line) {
  final trimmed = line.trim().replaceAll(RegExp(r':$'), '').replaceAll(RegExp(r':\s*$'), '');

  final dashIndex = trimmed.indexOf(RegExp(r'\s[–\-]\s*'));
  if (dashIndex < 0) {
    final englishName = tileNameTranslations[trimmed];
    if (englishName != null) return '$trimmed ($englishName)';
    return line;
  }

  final roomPart = trimmed.substring(0, dashIndex).trim().replaceAll(RegExp(r':$'), '').trim();
  final floorPart = trimmed.substring(dashIndex).replaceFirst(RegExp(r'^[\s–\-]+'), '').trim();

  final englishRoom = tileNameTranslations[roomPart];

  final floorParts = floorPart.split('/').map((f) {
    final ft = f.trim();
    final eng = floorTranslations[ft];
    return eng != null ? '$ft ($eng)' : ft;
  }).join('/');

  if (englishRoom != null) {
    return '$roomPart ($englishRoom) – $floorParts';
  }

  return '$roomPart – $floorParts';
}
