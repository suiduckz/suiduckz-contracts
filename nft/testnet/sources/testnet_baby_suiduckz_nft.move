module baby_suiduckz_testnet::nft {

    use sui::object;
    use sui::tx_context;
    use sui::transfer;
    use std::string;

    /// NFT
    public struct BabySuiDuckz has key, store {
        id: object::UID,
        name: string::String,
        image_url: string::String,
    }

    /// Counter
    public struct Counter has key {
        id: object::UID,
        value: u64,
    }

    /// INIT
    fun init(ctx: &mut tx_context::TxContext) {
        let counter = Counter {
            id: object::new(ctx),
            value: 0,
        };

        transfer::share_object(counter);
    }

    /// MINT
    public fun mint(counter: &mut Counter, ctx: &mut tx_context::TxContext) {

        counter.value = counter.value + 1;

        // sementara tanpa dynamic string dulu (biar aman)
        let nft = BabySuiDuckz {
            id: object::new(ctx),
            name: string::utf8(b"Testnet Baby Suiduckz NFT"),
            image_url: string::utf8(b"https://i.imgur.com/0pP6wna.jpeg"),
        };

        transfer::transfer(nft, tx_context::sender(ctx));
    }
}
