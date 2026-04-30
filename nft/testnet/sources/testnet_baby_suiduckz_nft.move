module baby_suiduckz_testnet::nft {

    use sui::object::{UID, new};
    use sui::tx_context::{TxContext, sender};
    use sui::transfer;

    public struct BabySuiDuckz has key, store {
        id: UID,
    }

    public entry fun mint(ctx: &mut TxContext) {
        let nft = BabySuiDuckz {
            id: new(ctx),
        };

        transfer::transfer(nft, sender(ctx));
    }
}
