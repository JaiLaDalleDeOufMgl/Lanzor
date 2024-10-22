Gamemode = {};
Gamemode.is_server = IsDuplicityVersion();
Gamemode.current_resource = GetCurrentResourceName();
local current_resource = exports.Tree:serveurConfig().Serveur.hudScript;

local modules = {};
local _require = require;
local _path = './?.lua;';


---@param modname string
---@return any
function require(modname)

    if type(modname) ~= 'string' then return; end

    local mod_id = ('%s.%s'):format(current_resource, modname);
    local module = modules[mod_id];

    if (not module) then

        if (module == false) then
            error(("^1circular-dependency occurred when loading module '%s'^0"):format(modname), 0);
        end

        local success, result = pcall(_require, modname);

        if (success) then
            modules[mod_id] = result;
            return result;
        end

        local modpath = modname:gsub('%.', '/');

        for path in _path:gmatch('[^;]+') do

            local script = path:gsub('?', modpath):gsub('%.+%/+', '');
            local resourceFile = LoadResourceFile(current_resource, script);

            if (resourceFile) then

                modules[mod_id] = false;
                script = ('@@%s/%s'):format(current_resource, script)

                local chunk, err = load(resourceFile, script)

                if (err or not chunk) then
                    modules[mod_id] = nil;
                    return error(err or ("Unable to load module '%s'"):format(modname), 0);
                end

                module = chunk(modname) or true;
                modules[mod_id] = module;

                return module;

            end

        end

        return error(("module ^7\'^3%s^7\'^1 not found^0"):format(modname), 0);

    end

    return module;

end

Gamemode.enums = require 'src.enums.index';