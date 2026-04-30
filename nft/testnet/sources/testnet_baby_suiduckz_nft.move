module baby_suiduckz_testnet::nft {

    // pakai fully-qualified, jadi gak ada duplicate alias warning
    public struct BabySuiDuckz has key, store {
        id: sui::object::UID,
    }

    // gak perlu `entry` kalau sudah `public`
    public fun mint(ctx: &mut sui::tx_context::TxContext) {
        let nft = BabySuiDuckz {
            id: sui::object::new(ctx),
        };

        sui::transfer::transfer(nft, sui::tx_context::sender(ctx));
    }
}
