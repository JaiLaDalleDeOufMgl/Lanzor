SharedPeds = {
    {model = "s_m_y_factory_01", anim = true, coords = vector4(961.705078125, -2111.8132324219, 30.948400497437, 92.426628112793)},
    {model = "s_m_m_movprem_01", anim = true, coords = vector4(-1030.2705078125, -1519.26171875, 4.5943760871887, 291.41311645508)},
    {model = "a_m_y_vindouche_01", anim = true, coords = vector4(2741.0432128906, 3445.732421875, 55.3, 258.86651611328)},
    {model = "a_f_y_femaleagent", anim = true, coords = vector4(-269.57901000977, -955.14025878906, 30.223142623901, 208.89259338379)},
}


CreateThread(function()
    for k,v in pairs(SharedPeds) do 
        local model = GetHashKey(v.model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end
        local ped = CreatePed(4, model, v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, false)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        if v.anim then
            TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
        end
    end
end)