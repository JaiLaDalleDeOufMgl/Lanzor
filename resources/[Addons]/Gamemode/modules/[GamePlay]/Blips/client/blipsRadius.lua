Map = {
  -- {name="Mission Row",color=77, id=60, x=431.09, y=-982.32, z=30.71, r=0.0},
  { name = "Roxwood",              color = 77, id = 183, x = -900.06,          y = 7118.42,          z = -108.19,         r = 0.0 },
  { name = "Commissariat",         color = 77, id = 60,  x = 435.82,           y = -981.93,          z = 30.68,           r = 0.0 },
  { name = "BCSO",                 color = 52, id = 58,  x = 1837.53,          y = 3654.16,          z = 34.29,           r = 0.0 },
  { name = "Hôpital",              color = 2,  id = 61,  scale = 0.6,          x = -1839.18,         y = -382.30,         z = 49.39, r = 0.0 },
  { name = "Hôpital Nord",         color = 2,  id = 61,  scale = 0.6,          x = -59.76,           y = 6520.99,         z = 31.46, r = 0.0 },
  --{name="Sherrif",color=56, id=60, x=-443.08, y = 6016.76, z = 31.4},
  { name = "Benny's",              color = 5,  id = 446, x = -211.27,          y = -1323.20,         z = 30.89,           r = 0 },
  { name = "Ls Custom",            color = 38, id = 72,  x = -331.3797,        y = -109.7054,        z = 39.01394,        r = 0 },
  --{name="Vanilla Unicorn",color=50, id=121,x=129.246, y = -1299.363, z= 29.501},
  --  {name="[Territoire] Bloods",color=1, id=378,x=-1159.92, y = -1514.06, z= 4.16},
  { name = "Gouvernement",         color = 0,  id = 419, x = -421.521,         y = 1137.4470,        z = 325.8540,        r = 0.0 },
  --{name="[Territoire] Bratva",color=0, id=484,x=1364.97, y = -578.8, z= 74.38},
  --{name="[Territoire] Madrazo",color=22, id=378,x=1387.5, y = 1141.64, z= 114.33},
  { name = "Unicorn",              color = 27, id = 121, 12,                   x = 129.246,          y = -1300.6,         z = 29.2,  r = 0 },
  --  {name = "Concession aéronotique", color=1, id=16, 12, x=-964.3, y = -2965.4, z= 13.94},
  -- {name="[Territoire] Bloods",color=1, id=378,x = -1545.39, y = -407.93, z = 41.98, r= 0,
  -- {name="[Territoire] Marabunta",color=26, id=378,x=1256.80, y = -1582.10, z= 54.55, r= 800.0},
  --{name="[Territoire] Vagos",color=5, id=378,x=324.73, y = -2031.74, z= 20.87, r= 800.0},
  --{name="[Territoire] Ballas",color=27, id=378,x=88.05, y = -1925.59, z= 20.79, r= 800.0},
  --{name="[Territoire] Families",color=2, id=378,x=-165.40, y = -1632.77, z= 33.65, r= 800.0},
  { name = "Zone de Chasse",       color = 1,  id = 141, x = -567.27,          y = 5253.18,          z = 70.46,           r = 3000.0 },
  --{name="Boucherie",color=34, id=478, x = 960.84, y = -2111.57, z = 31.94, r= 0.0},
  --{name="Maze Bank Arena",color=0, id=647, x = -322.9858, y = -1970.9514, z = 66.7998, r= 0.0},
  { name = "FIB",                  color = 0,  id = 419, x = 2520.839,         y = -415.0426,        z = 94.12384,        r = 0.0 },
  { name = "Malibu",               color = 0,  id = 124, x = -824.129,         y = -1221.953,        z = 7.365,           r = 0.0 },


  --{name="Acheteur de poisson",color=51, id=480, x = 1961.89, y = 5184.36, z = 47.98, r= 0.0},
  --{name="Pêche",color=38, id=480, x = 2073.23, y = 4554.31, z = 31.31, r= 0.0},
  --{name="Hopital",color=2, id=61,x=286.6, y = -582.8, z= 43.3},
  --{name="Commissariat de Police",color=29, id=60,x=425.1, y = -979.5, z= 30.7},
  --{name="Quartier Yakuza",color=68, id=378,x=-1059.5769, y = -1028.1550, z= 30.7},

  { name = "Tequilala",            color = 27, id = 93,  x = -562.00,          y = 286.76,           z = 82.17,           r = 0.0 },
  { name = "Bahama Mama",          color = 27, id = 93,  x = -1388.4260253906, y = -586.92169189453, z = 30.218647003174, r = 0.0 },
  { name = "RA Records",           color = 27, id = 564, x = 471.7398,         y = -114.692,         z = 62.7641,         r = 0.0 },
  { name = "[Métier LIBRE] Casse", color = 28, id = 643, x = -511.76,          y = -1753.97,         z = 18.9,            r = 0.0 },
  --{name="Ile Bora Bora",color=15, id=570, x = -3507.3279, y = 7864.8369, z = 17.2281, r= 0.0},
  --{name="Restaurant Italien",color=6, id=681, x = 804.4954, y = -747.5833, z = 26.78, r= 0.0},

}

Citizen.CreateThread(function()
  for i = 1, #Map, 1 do
    local blip = AddBlipForCoord(Map[i].x, Map[i].y, Map[i].z)
    SetBlipSprite(blip, Map[i].id)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.5)
    SetBlipColour(blip, Map[i].color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Map[i].name)
    EndTextCommandSetBlipName(blip)
    local zoneblip = AddBlipForRadius(Map[i].x, Map[i].y, Map[i].z, Map[i].r)
    SetBlipSprite(zoneblip, 1)
    SetBlipColour(zoneblip, Map[i].color)
    SetBlipAlpha(zoneblip, 100)
  end
end)
