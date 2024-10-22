function MOD_Zones:deleteAllByJobType(jobType)

    for index, zone in pairs(self.list) do
        if (zone.requireJob) then
            if (zone.requireJob.type == jobType) then
                self:delete(zone.id)
            end
        end
    end
end