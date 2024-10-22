Config.VehiclesWithColor = {

}
  
Config.VehiclesModelNameBcso = {
    ['scorcher'] = 'scorcher',
    ['polstanierr'] = 'polstanierr',
    ['poltorencer'] = 'poltorencer',
    ['polstalkerr'] = 'polstalkerr',
    ['verus'] = 'verus',
    ['polfugitiver'] = 'polfugitiver',
    ['polalamor2'] = 'polalamor2',
    ['polgresleyr'] = 'polgresleyr',
    ['polbuffalor'] = 'polbuffalor',
    ['polscoutr'] = 'polscoutr',
    ['polbisonr'] = 'polbisonr',
    ['polcarar'] = 'polcarar',
    ['lspdbuffsumk'] = 'lspdbuffsumk',
    ['lspdbuffalostxum'] = 'lspdbuffalostxum',
    ['apoliceu14'] = 'apoliceu14',
    ['polspeedor'] = 'polspeedor',
    ['polbuffalor2'] = 'polbuffalor2',
    ['poldmntr'] = 'poldmntr',
    ['polcoquetter'] = 'polcoquetter',
}
  
Config.BcsoOrderGrades = { 
    { grade = 'boss', name = "Boss" }, 
    { grade = 'undersheriff', name = "undersheriff" }, 
    { grade = 'assistsheriff', name = "assistsheriff" }, 
    { grade = 'chefdeputy', name = "chefdeputy" }, 
    { grade = 'major', name = "major" }, 
    { grade = 'captain', name = "captain" }, 
    { grade = 'lieutenant', name = "lieutenant" }, 
    { grade = 'mastersergeant', name = "mastersergeant" }, 
    { grade = 'sergeant', name = "sergeant" }, 
    { grade = 'caporal', name = "caporal" }, 
    { grade = 'masterdeputy', name = "masterdeputy" },
    { grade = 'seniordeputy', name = "seniordeputy" },
    { grade = 'deputytre', name = "deputytre" },
    { grade = 'deputytwo', name = "deputytwo" },
    { grade = 'deputyone', name = "deputyone" },
    { grade = 'recruit', name = "recruit" }
}

Config.AuthorizedVehiclesBcso = {
    recruit = {
        vehicules = {
            {model = 'scorcher'},
            {model = 'polstanierr'},
        }
    },
  
    deputyone = {
        grades = { 'recruit' },
        vehicules = {
            {model = 'poltorencer'},
        }
    },

    deputytwo = {
        grades = { 'recruit', 'deputyone' },
        vehicules = {
            {model = 'polstalkerr'},
            {model = 'verus'},
        }
    },
    
    deputytre = {
        grades = { 'recruit', 'deputyone', 'deputytwo' },
        vehicules = {
            {model = 'polfugitiver'},
            {model = 'polalamor2'},
        }
    },

    seniordeputy = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre' },
        vehicules = {
            {model = 'polgresleyr'},
            {model = 'polbuffalor'},
        }
    },

    masterdeputy = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy' },
        vehicules = {
            {model = 'polscoutr'},
            {model = 'polbisonr'},
        }
    },

    caporal = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy' },
        vehicules = {
            {model = 'polcarar'},
            {model = 'lspdbuffsumk'},
            {model = 'lspdbuffalostxum'},
            {model = 'apoliceu14'},
        }
    },
    sergeant = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal' },
        vehicules = {
            {model = 'polspeedor'},
        }
    },

    mastersergeant = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant' },
        vehicules = {
            {model = 'polbuffalor2'},
        }
    },
    
    lieutenant = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant' },
        vehicules = {
            {model = 'poldmntr'},
        }
    },
    captain = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant', 'lieutenant' },
        vehicules = {
            {model = 'polcoquetter'},
        }
    },
    major = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant', 'lieutenant', 'captain' },
    },
    chefdeputy = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant', 'lieutenant', 'captain' },
    },
    assistsheriff = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant', 'lieutenant', 'captain' },
    },
    undersheriff = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant', 'lieutenant', 'captain' },
    },
    boss = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant', 'lieutenant', 'captain' },
    }
}