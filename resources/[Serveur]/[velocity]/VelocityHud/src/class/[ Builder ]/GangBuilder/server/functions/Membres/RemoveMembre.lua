function _GamemodeGangBuilder:RemoveMembre(license, unemployed)
    print('REMOVE PLAYER', license, unemployed)
    if (self.membres[license]) then
        self.membres[license] = nil

        if (unemployed) then
            local xPlayer = ESX.GetPlayerFromIdentifier(license)

            if (xPlayer) then
                xPlayer.setJob2("unemployed2", 0);
            else
                MySQL.Async.execute("UPDATE users SET job2 = @job2, job2_grade = @job2_grade WHERE identifier = @identifier", {
                    ["@job2"] = "unemployed2",
                    ["@job2_grade"] = 0,
                    ["@identifier"] = license
                });
            end
        end

        self:UpdateEvent("Gamemode:GangBuilder:ReceiveMembres", self.membres)

        self:SaveOnBdd()
    end
end