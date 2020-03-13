## Arbitrary write storage
All data in a smart contract share a single storage space, and if data is arbitrarily written to the storage, it can cause data to overwrite each other. There is no problem writing to the store, but authentication is required and only a few people can write to the store.
Bug type: context-related bug