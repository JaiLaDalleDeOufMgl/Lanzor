

PoliceConfigAAA = {

amende = {
    ["amende "] = {
      {label = 'Usage abusif du klaxon', price = 200},
      {label = 'Franchir une ligne continue', price = 50},
      {label = 'Circulation à contresens', price = 150},
      {label = 'Demi-tour non autorisé', price = 100},
      {label = 'Circulation hors-route', price = 250},
      {label = 'Stationnement gênant / interdit', price = 200},
      {label = 'Non-respect d\'un stop', price = 100},
      {label = 'Véhicule non en état', price = 500},
      {label = 'Conduite sans permis', price = 700},
      {label = 'Délit de fuite', price = 4200},
      {label = 'Excès de vitesse < 5 kmh', price = 625},
      {label = 'Excès de vitesse 5-15 kmh', price = 1250},
      {label = 'Excès de vitesse 15-30 kmh', price = 1875},
      {label = 'Excès de vitesse > 30 kmh', price = 2500},
      {label = 'Dégradation de la voie publique', price = 3750},
      {label = 'Trouble à l\'ordre publique', price = 3750},
      {label = 'Entrave opération de police', price = 7500},
      {label = 'Insulte envers / entre civils', price = 1250},
      {label = 'Menace verbale ou intimidation envers civil', price = 5000},
      {label = 'Menace verbale ou intimidation envers policier', price = 7500},
      {label = 'Manifestation illégale', price = 6250},
      {label = 'Tentative de corruption', price = 2500},
      {label = 'Arme blanche sortie en ville', price = 10000},
      {label = 'Arme léthale sortie en ville', price = 25000},
      {label = 'Port d\'arme illégal', price = 50000},
      {label = 'Pris en flag lockpick', price = 2500},
      {label = 'Vol de voiture', price = 3750},
      {label = 'Vente de drogue', price = 37500},
      {label = 'Fabrication de drogue', price = 50000},
      {label = 'Possession de drogue', price = 30000},
      {label = 'Prise d\'ôtage civil', price = 41250},
      {label = 'Prise d\'ôtage agent de l\'état', price = 62500},
      {label = 'Braquage supérette', price = 20000},
      {label = 'Braquage de banque', price = 50000},
      {label = 'Tir sur civil', price = 50000},
      {label = 'Tir sur agent de l\'état', price = 62500},
      {label = 'Tentative de meurtre sur civil', price = 50000},
      {label = 'Tentative de meurtre sur agent de l\'état', price = 62500},
      {label = 'Meurtre sur civil', price = 62500},
      {label = 'Meurte sur agent de l\'état', price = 75000},
    }
  },
}

Config.VehiclesWithColor = {
  ['nkcruiser'] = true,
  ['nkbuffalos'] = true,
  ['nktorrence'] = true,
  ['nkscout'] = true,
  ['nkcoquette'] = true,
  ['code3bmw'] = true
}

Config.VehiclesModelName = {
  ['LSPDscorcher'] = 'Vélo',
  ['nkcruiser'] = 'Police Cruiser',
  ['nkbuffalos'] = 'Buffalo Bravado S',
  ['LSPDtorrence'] = 'Vapid Torrence',
  ['nktorrence'] = 'Vapid Torrence',
  ['code3bmw'] = 'Moto BMW',
  ['nkscout'] = 'Vapid Scout',
  ['police2b'] = 'Buffalo Bravado',
  ['nkgranger2'] = 'Granger',
  ['lspdcara'] = 'Caracara',
  ['lspdbuffsumk'] = 'Bravado Unmarked',
  ['lspdbuffalostxum'] = 'STX Bravado Unmarked',
  ['poltaxi'] = 'Taxi Unmarked',
  ['LSPDbus'] = 'Bus Pénitencier',
  ['riot'] = 'Riot',
  ['nkcoquette'] = 'Corvette (VIR)',
  ['LSPDraiden'] = 'Raiden (VIR)',
}

Config.LspdOrderGrades = { 
  { grade = 'boss', name = "Boss" }, 
  { grade = 'assistantboss', name = "Boss" }, 
  { grade = 'deputy', name = "Boss" }, 
  { grade = 'commander', name = "Commandant" }, 
  { grade = 'capitaine', name = "Capitaine" }, 
  { grade = 'lieutenant', name = "Lieutenant" }, 
  { grade = 'sergeant', name = "Sergent" }, 
  { grade = 'officer', name = "Officier" }, 
  { grade = 'recruit', name = "Rookie" }
}

Config.AuthorizedVehiclesLspd = {
  recruit = {
    vehicules = {
      {model = 'LSPDscorcher'},
      {model = 'LSPDtorrence'},
      {model = 'nkbuffalos'},
    }
  },

  officer = {
    grades = { 'recruit' },
    vehicules = {
      {model = 'police2b'},
      {model = 'nktorrence'},
    }
  },

  sergeant = {
    grades = { 'recruit', 'officer' },
    vehicules = {
      {model = 'code3bmw'},
      {model = 'nkscout'},
      {model = 'police2b'},
      {model = 'nkgranger2'},
      {model = 'lspdbuffsumk'},
      {model = 'lspdbuffalostxum'},
      {model = 'poltaxi'},
      {model = 'LSPDbus'},
      {model = 'riot'},
      {model = 'lspdcara'},
    }
  },

  lieutenant = {
    grades = { 'recruit', 'officer', 'sergeant' },
    vehicules = {
      {model = 'nkcoquette'},
      {model = 'LSPDraiden'},
    }
  },

  capitaine = {
    grades = { 'recruit', 'officer', 'sergeant', 'lieutenant' }
  },

  commander = {
    grades = { 'recruit', 'officer', 'sergeant', 'lieutenant' }
  },

  deputy = {
    grades = { 'recruit', 'officer', 'sergeant', 'lieutenant' }
  },

  assistantboss = {
    grades = { 'recruit', 'officer', 'sergeant', 'lieutenant' }
  },

  boss = {
    grades = { 'recruit', 'officer', 'sergeant', 'lieutenant' }
  },
}