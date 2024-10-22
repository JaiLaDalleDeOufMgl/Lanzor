-- Webhook for instapic posts, recommended to be a public channel
INSTAPIC_WEBHOOK = exports.Tree:serveurConfig().Logs.PhoneInstaPic
-- Webhook for birdy posts, recommended to be a public channel
BIRDY_WEBHOOK =  exports.Tree:serveurConfig().Logs.PhoneBirdy

-- Discord webhook for server logs
LOGS = {
    Calls = exports.Tree:serveurConfig().Logs.PhoneCalls,
    Messages = exports.Tree:serveurConfig().Logs.PhoneMessages,
    InstaPic = exports.Tree:serveurConfig().Logs.PhoneInstaPic,
    Birdy = exports.Tree:serveurConfig().Logs.PhoneBirdy,
    YellowPages = exports.Tree:serveurConfig().Logs.PhoneYellowPages,
    Marketplace = exports.Tree:serveurConfig().Logs.PhoneMarketPlace,
    Mail = exports.Tree:serveurConfig().Logs.PhoneMails,
    Wallet = exports.Tree:serveurConfig().Logs.PhoneWallets,
    DarkChat = exports.Tree:serveurConfig().Logs.PhoneDarkChat,
    Services = exports.Tree:serveurConfig().Logs.PhoneServices,
    Crypto = exports.Tree:serveurConfig().Logs.PhoneCryptos,
    Trendy = exports.Tree:serveurConfig().Logs.PhoneTrendy,
    Uploads = exports.Tree:serveurConfig().Logs.PhoneUploads,
}
-- Set your API keys for uploading media here.
-- Please note that the API key needs to match the correct upload method defined in Config.UploadMethod.
-- The default upload method is Fivemanage
-- We STRONGLY discourage using Discord as an upload method, as uploaded files may become inaccessible after a while.
-- You can get your API keys from https://fivemanage.com/
-- A video tutorial for how to set up Fivemanage can be found here: https://www.youtube.com/watch?v=y3bCaHS6Moc
API_KEYS = {
    Video = "XCW7K3AZ9COCe5TcjBGRfdn1m9Rkofer",
    Image = "XCW7K3AZ9COCe5TcjBGRfdn1m9Rkofer",
    Audio = "XCW7K3AZ9COCe5TcjBGRfdn1m9Rkofer",
}