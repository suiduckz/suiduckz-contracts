module baby_suiduckz_testnet::nft {

    use sui::object::{UID, new};
    use sui::tx_context::{TxContext, sender};
    use sui::transfer;
    use sui::display;
    use std::string::{String, utf8};
    use std::vector;

    /// NFT
    public struct BabySuiDuckz has key, store {
        id: UID,
        name: String,
        description: String,
        image_url: String,
    }

    /// GLOBAL COUNTER
    public struct Counter has key {
        id: UID,
        value: u64,
    }

    /// INIT → bikin counter + display
    fun init(ctx: &mut TxContext) {
        // init counter
        let counter = Counter {
            id: new(ctx),
            value: 0,
        };
        transfer::share_object(counter);

        // init display
        let keys = vector[
            utf8(b"name"),
            utf8(b"description"),
            utf8(b"image_url"),
        ];

        let values = vector[
            utf8(b"{name}"),
            utf8(b"{description}"),
            utf8(b"{image_url}"),
        ];

        let d = display::new_with_fields<BabySuiDuckz>(&keys, &values, ctx);
        display::update_version(&d);
    }

    /// MINT DENGAN NOMOR
    public fun mint(counter: &mut Counter, ctx: &mut TxContext) {

        // increment
        counter.value = counter.value + 1;

        // convert number → string
        let num_str = std::string::utf8(std::string::to_bytes(&counter.value));

        let name = std::string::concat(
            utf8(b"Testnet Baby Suiduckz NFT #"),
            num_str
        );

        let nft = BabySuiDuckz {
            id: new(ctx),
            name: name,
            description: utf8(b"This NFT has no monetary value and is for testing purposes only (Testnet)."),
            image_url: utf8(b"https://i.imgur.com/0pP6wna.jpeg"),
        };

        transfer::transfer(nft, sender(ctx));
    }
}
