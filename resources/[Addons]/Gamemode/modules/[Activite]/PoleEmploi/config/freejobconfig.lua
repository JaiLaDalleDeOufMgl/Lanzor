

FreeJobConfig = {

PoleEmploi = {
    {x = -268.81, y = -956.35, z = 31.22}
},
Jardinier = {
    {x = 1724.557, y = 4641.883789, z = 42.875}
},
JardinierRecolte = {
    {x = 2933.42, y = 4691.32, z = 50.75} 
},

Ped = {
    {position = vector4(-269.21, -955.45, 30.22, 197.77), pedModel = "a_f_y_femaleagent"}, -- Ped Pôle Emploi
    {position = vector4(1724.557, 4641.883789, 42.875, 112.975), pedModel = "a_m_y_vindouche_01"},-- Ped Jardinier LE DARON A TONNIO 
    {position = vector4(738.2346, 134.9391, 79.72369, 238.295), pedModel = "a_m_y_vinewood_01"}-- Ped Elec
    
},


Libre = {
    {label = "Jardinier", name = "jardinier", objectif = "Tu vas récolter des plantes", message = "~o~Rends toi là-bas, ton patron t'attend", x = 1724.557, y = 4641.883789, z = 42.875},
},

PrixVenteJardinier = math.random(38, 60),

---- Blips ----

BlipsPoleEmploi = true, 
BlipsPoleEmploiName = 'Pôle Emploi', 
BlipsPoleEmploiId = 457, 
BlipsPoleEmploiTaille = 0.6, 
BlipsPoleEmploiCouleur = 38, 

BlipsJardinier = true, 
BlipsJardinierName = '[Pôle Emploi] Jardinier', 
BlipsJardinierId = 480, 
BlipsJardinierTaille = 0.6, 
BlipsJardinierCouleur = 25,


BlipsPoleEmploiPosition = {
    {x = -265.20, y = -963.53, z = 31.22}
},
BlipsJardinierPosition = {
    {x = 1724.557, y = 4641.883789, z = 42.875}
},    

---- Marker ----

MarkerType = 22, 
MarkerSizeLargeur = 0.3, 
MarkerSizeEpaisseur = 0.3,
MarkerSizeHauteur = 0.3,
MarkerDistance = 15.0,
MarkerColorR = 130, 
MarkerColorG = 0, 
MarkerColorB = 184, 
MarkerOpacite = 255, 
MarkerSaute = true, 
MarkerTourne = true, 


---- Text ---- 

TextDistance = 2.0,
Text = "Appuyez sur ["..exports.Tree:serveurConfig().Serveur.color.."E~s~] pour accèder au "..exports.Tree:serveurConfig().Serveur.color.."pôle emploi", 
TextJardinier = "Appuyez sur ["..exports.Tree:serveurConfig().Serveur.color.."E~s~] pour "..exports.Tree:serveurConfig().Serveur.color.."parler à ton patron",
TextJardinierRecolte = "Appuyez sur ["..exports.Tree:serveurConfig().Serveur.color.."E~s~] pour "..exports.Tree:serveurConfig().Serveur.color.."récolter des plantes",

}