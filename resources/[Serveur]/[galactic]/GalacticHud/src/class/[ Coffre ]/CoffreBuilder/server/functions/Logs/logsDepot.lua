function _GamemodeCoffreBuilder:logsDepot(source, xPlayer, itemName, itemId, itemCount)

     local Title = "Items Dépose - Coffre : "..self.jobCoffre
     local Message
     local WeebHook

     -- Logs Job
     if self.jobCoffre == "ltd_sud" then
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "avocat" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "boatseller" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "burgershot" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "journalist" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "mecano2" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "realestateagent" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "ambulance" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "label" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "mecano" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "planeseller" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "taxi" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "tequilala" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "unicorn" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     elseif self.jobCoffre == "cardealer" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsDepot
     end


     ---LOGS LEGAL
     self:sendWebHook(Title, Message, WeebHook, 65280)
     
     ---ADMIN
     self:sendWebHook(Title, Message, exports.Tree:serveurConfig().Logs.ChestLogsDepot, 65280)
end