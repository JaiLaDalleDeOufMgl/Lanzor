SetConvarReplicated('voice_enableRadioAnim', true and '1' or '0')

RegisterNetEvent("tree:radio:getMembers", function(currentChannel)
    local playersInRadios = {}
    local players = exports['pma-voice']:getPlayersInRadioChannel(currentChannel)
    for source, isTalking in pairs(players) do
        table.insert(playersInRadios, {
            source = source,
            name = GetPlayerName(source)
        })
    end
    TriggerClientEvent("tree:radio:setMembers", -1, playersInRadios)
end)