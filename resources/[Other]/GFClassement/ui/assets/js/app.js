$(document).ready(function() {

    var WeaponIcons = {
        WEAPON_UNARMED : "UNARMED",
        WEAPON_KNIFE : "164px-Knife-icon.png",
        WEAPON_KNUCKLE : "Knuckles-icon.png",
        WEAPON_NIGHTSTICK : "164px-Nightstick-icon.png",
        WEAPON_HAMMER : "164px-Hammer-icon.png",
        WEAPON_BAT : "164px-Baseball-bat-icon.png",
        WEAPON_GOLFCLUB : "164px-Golf-club-icon.png",
        WEAPON_CROWBAR : "164px-Crowbar-icon.png",
        WEAPON_BOTTLE : "Broken-bottle-icon.png",
        WEAPON_DAGGER : "164px-Antique-cavalry-dagger-icon.png",
        WEAPON_HATCHET : "164px-Hatchet-icon.png",
        WEAPON_MACHETE : "164px-Machete-icon.png",
        WEAPON_FLASHLIGHT : "164px-Flashlight-icon.png",
        WEAPON_SWITCHBLADE : "164px-Switch-blade-icon.png",
        WEAPON_PROXMINE : "Proximity-mines-icon.png",
        WEAPON_BZGAS : "56px-Bz-gas-icon.png",
        WEAPON_SMOKEGRENADE : "56px-Tear-gas-icon.png",
        WEAPON_MOLOTOV : "120px-Molotov-icon.png",
        WEAPON_FIREEXTINGUISHER : "51px-Fire2.png",
        WEAPON_PETROLCAN : "94px-Petrolcan-icon.png",
        WEAPON_SNOWBALL : "Snowball-icon.png",
        WEAPON_FLARE : "Flare-icon.png",
        WEAPON_BALL : "Ball-icon.png",
        WEAPON_REVOLVER : "164px-Heavy-revolver-icon.png",
        WEAPON_POOLCUE : "164px-Pool-cue-icon.png",
        WEAPON_PIPEWRENCH : "164px-Pipe-wrench-icon.png",
        WEAPON_PISTOL : "Pistol-icon.png",
        WEAPON_PISTOL_MK2 : "Pistol-mk2-icon.png",
        WEAPON_COMBATPISTOL : "Combat-pistol-icon.png",
        WEAPON_APPISTOL : "Appistol-icon.png",
        WEAPON_PISTOL50 : "weapon_pistol50.png",
        WEAPON_SNSPISTOL : "Sns-pistol-icon.png",
        WEAPON_HEAVYPISTOL : "Heavy-pistol-icon.png",
        WEAPON_VINTAGEPISTOL : "Vintage-pistol-icon.png",
        WEAPON_STUNGUN : "Stungun-icon.png",
        WEAPON_FLAREGUN : "Flaregun-icon.png",
        WEAPON_MARKSMANPISTOL : "164px-Marksman-pistol-icon.png",
        WEAPON_MICROSMG : "164px-Micro-smg-icon.png",
        WEAPON_MINISMG : "164px-Mini-smg-icon.png",
        WEAPON_SMG : "164px-Smg-icon.png",
        WEAPON_SMG_MK2 : "164px-Smg-mk2-icon.png",
        WEAPON_ASSAULTSMG : "164px-Assault-smg-icon.png",
        WEAPON_MG : "164px-Mg-icon.png",
        WEAPON_COMBATMG : "164px-Combat-mg-icon.png",
        WEAPON_COMBATMG_MK2 : "164px-Combat-mg-mk2-icon.png",
        WEAPON_COMBATPDW : "164px-Combat-mg-mk2-icon.png",
        WEAPON_GUSENBERG : "164px-Gusenberg-sweeper-icon.png",
        WEAPON_MACHINEPISTOL : "164px-Machine-pistol-icon.png",
        WEAPON_ASSAULTRIFLE : "164px-Assault-rifle-icon.png",
        WEAPON_ASSAULTRIFLE_MK2 : "164px-Assault-rifle-mk2-icon.png",
        WEAPON_CARBINERIFLE : "164px-Carbine-rifle-icon.png",
        WEAPON_CARBINERIFLE_MK2 : "164px-Carbine-rifle-mk2-icon.png",
        WEAPON_SCAR : "164px-Carbine-rifle-mk2-icon.png",
        WEAPON_M4A1 : "164px-Carbine-rifle-mk2-icon.png",
        WEAPON_ADVANCEDRIFLE : "164px-Advanced-rifle-icon.png",
        WEAPON_SPECIALCARBINE : "164px-Special-carbine-icon.png",
        WEAPON_BULLPUPRIFLE : "164px-Bullpup-rifle-icon.png",
        WEAPON_COMPACTRIFLE : "164px-Compact-rifle-icon.png",
        WEAPON_PUMPSHOTGUN : "164px-Pump-shotgun-icon.png",
        //WEAPON_SWEEPERSHOTGUN : "164px-Sweeper-shotgun-icon.png",
        WEAPON_SAWNOFFSHOTGUN : "164px-Sawed-off-shotgun-icon.png",
        WEAPON_BULLPUPSHOTGUN : "164px-Bullpup-shotgun-icon.png",
        WEAPON_ASSAULTSHOTGUN : "164px-Assault-shotgun-icon.png",
        WEAPON_MUSKET : "164px-Musket-icon.png",
        WEAPON_HEAVYSHOTGUN : "164px-Heavy-shotgun-icon.png",
        WEAPON_DBSHOTGUN : "164px-Double-barrel-shotgun-icon.png",
        WEAPON_SNIPERRIFLE : "164px-Sniper-rifle-icon.png",
        WEAPON_HEAVYSNIPER : "164px-Heavy-sniper-icon.png",
        WEAPON_HEAVYSNIPER_MK2 : "164px-Heavy-sniper-mk2-icon.png",
        WEAPON_MARKSMANRIFLE : "164px-Heavy-sniper-mk2-icon.png",
        WEAPON_GRENADELAUNCHER : "164px-Grenade-launcher-icon.png",
        WEAPON_GRENADELAUNCHER_SMOKE : "164px-Grenade-launcher-icon.png",
        WEAPON_RPG : "164px-Rocket-launcher-icon.png",
        WEAPON_MINIGUN : "164px-Minigun-icon.png",
        WEAPON_FIREWORK : "164px-Firework-launcher-icon.png",
        WEAPON_RAILGUN : "164px-Railgun-icon.png",
        WEAPON_HOMINGLAUNCHER : "164px-Homing-launcher-icon.png",
        WEAPON_GRENADE : "Grenade-icon.png",
        WEAPON_STICKYBOMB : "Sticky-bomb-icon.png",
        WEAPON_COMPACTLAUNCHER : "164px-Grenade-compact-launcher-icon.png",
        WEAPON_SNSPISTOL_MK2 : "Sns-pistol-mk2-icon.png",
        WEAPON_REVOLVER_MK2 : "164px-Heavy-revolver-mk2-icon.png",
        WEAPON_DOUBLEACTION : "164px-Double-action-revolver-icon.png",
        WEAPON_SPECIALCARBINE_MK2 : "164px-Special-carbine-mk2-icon.png",
        WEAPON_BULLPUPRIFLE_MK2 : "164px-Bullpup-rifle-mk2-icon.png",
        WEAPON_PUMPSHOTGUN_MK2 : "164px-Pump-shotgun-mk2-icon.png",
        WEAPON_MARKSMANRIFLE_MK2 : "164px-Marksman-rifle-mk2-icon.png",
        WEAPON_RAYPISTOL : "164px-Railgun-icon.png",
        WEAPON_RAYCARBINE : "164px-Unholy-hellbringer-icon.png",
        WEAPON_RAYMINIGUN : "164px-Widowmaker-icon.png",
        //WEAPON_DIGISCANNER : "WEAPON_DIGISCANNER",
        WEAPON_NAVYREVOLVER : "164px-Navy-revolver-icon.png",
        WEAPON_CERAMICPISTOL : "Ceramic-pistol-icon.png",
        WEAPON_STONE_HATCHET : "164px-Stone-hatchet-icon.png",
        WEAPON_PIPEBOMB : "164px-Pipe-bomb-icon.png",
        GADGET_PARACHUTE : "93px-Parachute-icon.png",
        WEAPON_GADGETPISTOL : "164px-Perico-pistol-icon.png",
        WEAPON_MILITARYRIFLE : "164px-Military-rifle-icon.png",
        WEAPON_COMBATSHOTGUN : "164px-Combat-shotgun-icon.png",
        WEAPON_AUTOSHOTGUN : "164px-Sweeper-shotgun-icon.png"
    }

    $('.noti-trigger').click(function() {
        let status = $(this).data('status');
        noti(status);
    });

    window.addEventListener('message', function(e) {
        var data = e.data
        switch (data.action) {
            case "notification": 
                noti(data.status);
                break;
            case "addKill": 
                addKill(data.killer, WeaponIcons[data.weapon], data.victim);
                break;
            case "updateRank":
                var ranktext = data.rank
                if (data.rank == 1) {
                    ranktext = data.rank +'/'+ data.howMany + '<img src="assets/img/leaderboard/trophy.png" width="30px" alt="Trophy">'
                } else if (data.rank == 2) {
                    ranktext = data.rank +'/'+ data.howMany + '<img src="assets/img/leaderboard/medal-second.png" width="30px" alt="Trophy">'
                } else if (data.rank == 3) {
                    ranktext = data.rank +'/'+ data.howMany + '<img src="assets/img/leaderboard/medal-third.png" width="30px" alt="Trophy">'
                } else {
                    ranktext = data.rank+'/'+data.howMany
                }
                var out = `${ranktext} | <i class="fa-solid fa-crosshairs"></i> ${data.kills} | <i class="fa-solid fa-skull"></i> ${data.deaths} | ${data.kd.toFixed(2)} K/D`
                $('#my-placement-container').html(out);
                break;
            case "populateLeaderBoard": 
                $('#leaderboard-content').html("");
                $.each(data.data, function(key, value) {
                    var ranktext = value.rank
                    if (value.rank == 1) {
                        ranktext = '<img src="assets/img/leaderboard/trophy.png" width="30px" alt="Trophy">'
                    } else if (value.rank == 2) {
                        ranktext = '<img src="assets/img/leaderboard/medal-second.png" width="30px" alt="Trophy">'
                    } else if (value.rank == 3) {
                        ranktext = '<img src="assets/img/leaderboard/medal-third.png" width="30px" alt="Trophy">'
                    }
                    var out = `<div class="leaderboard-item">
                    <div class="leaderboard-item-rank">
                        ${ranktext}
                    </div>
                    <div class="leaderboard-item-name">${value.name}</div>
                    <div class="leaderboard-item-score">
                        <div class="leaderboard-item-score-item">
                            ${value.kills} <i class="fa-solid fa-crosshairs"></i>
                        </div>
                        <div class="leaderboard-item-score-item">
                            ${value.deaths} <i class="fa-solid fa-skull"></i>
                        </div>
                        <div class="leaderboard-item-score-item">
                            ${value.kd.toFixed(2)} K/D
                        </div>
                    </div>
                </div>`
                    $("#leaderboard-content").append(out);
                });
                break;
            case "setLeaderboard":
                $('#leaderboard').css('opacity', data.opacity + '%');
                break;
        }
    });

    let leaveZoneText = 'Vous quittez la zone gunfight'
    let enterZoneText = 'Vous entrez dans la zone de gunfight'

    function noti(status) {
        if (status == 'leave') {
            if ($('#noti-title').hasClass('enter')) {
                $('#noti-title').removeClass('enter');
            }
            if ($('#square-icon').hasClass('enter-bg-icon')) {
                $('#square-icon').removeClass('enter-bg-icon');
            }
            $('#noti-title').addClass('leave');
            $('#square-icon').addClass('leave-bg-icon');
            $('#my-placement').css('opacity', '0%');
            $('#noti-text').empty().append(leaveZoneText);
        }else {
            if ($('#noti-title').hasClass('leave')) {
                $('#noti-title').removeClass('leave');
            }
            if ($('#square-icon').hasClass('leave-bg-icon')) {
                $('#square-icon').removeClass('leave-bg-icon');
            }
            $('#noti-title').addClass('enter');
            $('#square-icon').addClass('enter-bg-icon');
            $('#my-placement').css('opacity', '100%');
            $('#noti-text').empty().append(enterZoneText);
        }

        $('#noti').css('top', '5vh');
        $('#noti').css('opacity', '100%');

        setTimeout(function() {
            $('#noti').css('top', '-20vh');
            $('#noti').css('opacity', '0%');
        }, 3000);
    }

    // KILLFEED
    $('.killfeed-trigger').click(function() {
        let status = $(this).data('kill');
        let weapon = WeaponIcons[Object.keys(WeaponIcons)[Math.floor(Math.random() * Object.keys(WeaponIcons).length)]];
        let killer = Math.floor(Math.random() * 100);
        let victim = Math.floor(Math.random() * 100);
        addKill(killer, weapon, victim);
    });

    function addKill(killer, weapon, victim) {
        if(weapon !=="UNARMED") {
            let kill = `
            <div class="killfeed-item">
                <div class="killfeed-item-killer">
                    <div class="killfeed-item-left-name">${killer}</div>
                </div>
                <div class="killfeed-item-weapon">
                    <img src="assets/img/weapons/${weapon}" alt="">
                </div>
                <div class="killfeed-item-victim">
                    <div class="killfeed-item-right-name"><font color="red">${victim}</font></div>
                </div>
            </div>`;
            $('.killfeed-container').prepend(kill);
            
            setTimeout(function() {
                removeFromKillfeed();
            }, 5000);
        } else {
            let kill = `
            <div class="killfeed-item">
                <div class="killfeed-item-killer">
                    <div class="killfeed-item-left-name">${killer}</div>
                </div>
                <div class="killfeed-item-weapon">
                    <i class="fa-solid fa-skull fa-spin"></i>
                </div>
                <div class="killfeed-item-victim">
                    <div class="killfeed-item-right-name"><font color="red">${victim}</font></div>
                </div>
            </div>`;
            $('.killfeed-container').prepend(kill);
            
            setTimeout(function() {
                removeFromKillfeed();
            }, 5000);
        }
    };

    function removeFromKillfeed() {
        let lastItem = $(document).find('.killfeed-item').last();
        lastItem.css("opacity", "0");
        setTimeout(function() {
            lastItem.remove();
        }, 100);
    }

    // LEADERBOARD
    $('.leaderboard-trigger').click(function() {
        if($('#leaderboard').css('opacity') == 0) {
            $('#leaderboard').css('opacity', '100%');
        }else {
            $('#leaderboard').css('opacity', '0%');
        }
    });

});