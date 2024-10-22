function MOD_Buckets:DeleteBucketById(bucketId)
    MOD_Buckets.list[bucketId] = nil

    print("Bucket deleted")
end