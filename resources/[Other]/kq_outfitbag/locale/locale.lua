-- To edit the messages edit the ones on the right side, not the ones inside the square brackets.
-- '..exports.Tree:serveurConfig().Serveur.color..' e.g. are colors. '..exports.Tree:serveurConfig().Serveur.color..' being red, ~b~ being blue, ~y~ yellow etc.


Locale = {
    ['Open Bag'] = 'Ouvrir le Sac',
    ['Outfit bag'] = 'Sac de Tenue',
    ['Pickup the bag'] = 'Ramasser le Sac',
    ['Make public'] = 'Rendre Public',
    ['Make private'] = 'Rendre Privé',
    [''..exports.Tree:serveurConfig().Serveur.color..'This outfit isn\'t suitable for you'] = exports.Tree:serveurConfig().Serveur.color..'Cette tenue ne vous convient pas',
    ['~w~[~g~{OPEK_KEYBIND}~w~] to open [~g~{PICKUP_KEYBIND}~w~] to pickup the bag'] = '~w~[~g~{OPEK_KEYBIND}~w~] pour ouvrir [~g~{PICKUP_KEYBIND}~w~] pour ramsser votre sac',
    ['~w~Press [~g~{PUBLIC_KEYBIND}~w~] to open make the bag '..exports.Tree:serveurConfig().Serveur.color..'private'] = '~w~ [~g~{PUBLIC_KEYBIND}~w~] pour rendre votre sac '..exports.Tree:serveurConfig().Serveur.color..'private',
    ['~w~Press [~g~{PUBLIC_KEYBIND}~w~] to open make the bag ~g~public'] = '~w~ [~g~{PUBLIC_KEYBIND}~w~] pour rendre votre sac ~g~public',
    ['~w~[~g~{OPEN_KEYBIND}~w~] to open the bag'] = '~w~[~g~{OPEN_KEYBIND}~w~] pour ouvrir votre sac',
    [''..exports.Tree:serveurConfig().Serveur.color..'Wait a bit before you switch outfits again'] = exports.Tree:serveurConfig().Serveur.color..'Attendez un peu avant de changer à nouveau de tenue',
}
