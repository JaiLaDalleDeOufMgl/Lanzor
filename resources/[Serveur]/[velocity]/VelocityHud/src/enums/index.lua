local enums = {}

---PLAYER
enums.Player = require 'src.enums.Player.ePlayer'



---[ Builder ]
enums.GangBuilder = require 'src.enums.[ Builder ].GangBuilder.eGangBuilder'



--[ GamePlay ]
enums.Vehicle = require 'src.enums.[ GamePlay ].Vehicle.eVehicle'
enums.Garage = require 'src.enums.[ GamePlay ].Garage.eGarage'
enums.Pound = require 'src.enums.[ GamePlay ].Pound.ePound'

enums.Society = require 'src.enums.[ GamePlay ].Society.eSociety'

enums.ClotheShop = require 'src.enums.[ GamePlay ].ClotheShop.eClotheShop'



--[ Illegal ]
enums.Labos = require 'src.enums.[ Illegal ].Labos.eLabosIndex'
enums.SellDrugs = require 'src.enums.[ Illegal ].SellDrugs.eSellDrugs'

return enums