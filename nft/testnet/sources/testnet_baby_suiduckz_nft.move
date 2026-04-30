module testnet_baby_suiduckz::nft {

    /// NFT
    public struct BabySuiDuckz has key, store {
        id: sui::object::UID,
        name: std::string::String,
        image_url: std::string::String,
        number: u64, // 🔥 penting
    }

    /// Counter
    public struct Counter has key {
        id: sui::object::UID,
        value: u64,
    }

    /// INIT
    fun init(ctx: &mut sui::tx_context::TxContext) {
        let counter = Counter {
            id: sui::object::new(ctx),
            value: 0,
        };

        sui::transfer::share_object(counter);
    }

    /// MINT (AUTO NUMBER)
    public fun mint(counter: &mut Counter, ctx: &mut sui::tx_context::TxContext) {

        counter.value = counter.value + 1;

        let nft = BabySuiDuckz {
            id: sui::object::new(ctx),
            name: std::string::utf8(b"Testnet Baby Suiduckz NFT"),
            image_url: std::string::utf8(b"https://i.imgur.com/JyYxHwd.jpeg"),
            number: counter.value, // 🔥 ini numbering asli
        };

        sui::transfer::transfer(nft, sui::tx_context::sender(ctx));
    }
}
