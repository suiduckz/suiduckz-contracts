module suiduckz::testnet_baby_suiduckz_nft {

    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    /// 🔥 MAX SUPPLY
    const MAX_SUPPLY: u64 = 2700;

    /// NFT STRUCT
    struct NFT has key, store {
        id: UID,
        name: vector<u8>,
        url: vector<u8>,
    }

    /// SUPPLY TRACKER
    struct Supply has key {
        id: UID,
        total: u64,
    }

    /// INIT (jalan sekali pas deploy)
    public fun init(ctx: &mut TxContext) {
        let supply = Supply {
            id: object::new(ctx),
            total: 0,
        };

        transfer::share_object(supply);
    }

    /// MINT FUNCTION
    public entry fun mint(
        supply: &mut Supply,
        ctx: &mut TxContext
    ) {
        assert!(supply.total < MAX_SUPPLY, 0);

        let nft = NFT {
            id: object::new(ctx),
            name: b"Testnet Baby Suiduckz NFT",
            url: b"https://i.imgur.com/tElnLzR.jpeg",
        };

        supply.total = supply.total + 1;

        transfer::public_transfer(nft, tx_context::sender(ctx));
    }
}
