function MOD_Buckets:AddBucket()
    local NewBucketId = #MOD_Buckets.list + 1

    if (MOD_Buckets.list[NewBucketId]) then print("Error: This bucket already exists") return end

    MOD_Buckets.list[NewBucketId] = _GamemodeBuckets(NewBucketId)

    return (MOD_Buckets.list[NewBucketId])
end