function _GamemodeCoffreBuilder:logsRetrait(source, xPlayer, itemName, itemCount)

     local Title = "Items Retrait - Coffre : "..self.jobCoffre
     local Message
     local WeebHook

     -- Logs Job
     if self.jobCoffre == "ltd_sud" then
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "avocat" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "boatseller" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "burgershot" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "journalist" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "mecano2" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "realestateagent" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "ambulance" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "label" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "mecano" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "planeseller" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "taxi" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "tequilala" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "unicorn" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     elseif self.jobCoffre == "cardealer" then 
          Message = "Item retiré par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
     end


     ---LOGS LEGAL
     self:sendWebHook(Title, Message, WeebHook, 16711697)
     
     ---ADMIN
     self:sendWebHook(Title, Message, exports.Tree:serveurConfig().Logs.ChestLogsRetrait, 16711697)
end