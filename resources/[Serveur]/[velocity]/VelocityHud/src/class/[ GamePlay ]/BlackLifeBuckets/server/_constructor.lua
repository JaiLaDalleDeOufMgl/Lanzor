_GamemodeBuckets = {}

local __instance = {
    __index = _GamemodeBuckets
}

setmetatable(_GamemodeBuckets, {
    __call = function(_, BucketId)
        local self = setmetatable({}, __instance)

        self.bucket = BucketId

        self.playersInBuckets = {}
        self.objectsInBuckets = {}

        --Functions
        exportMetatable(_GamemodeBuckets, self)

        return (self)
    end
})