module testnet_baby_suiduckz::nft {

    use sui::object;
    use sui::tx_context;
    use sui::transfer;
    use std::string;
    use std::vector;

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

    /// INIT (auto jalan saat publish)
    fun init(ctx: &mut tx_context::TxContext) {
        let counter = Counter {
            id: object::new(ctx),
            value: 0,
        };

        transfer::share_object(counter);
    }

    /// 🔥 u64 → string
    fun u64_to_string(n: u64): string::String {
        let mut num = n;
        let mut digits = vector::empty<u8>();

        if (num == 0) {
            vector::push_back(&mut digits, 48);
        };

        while (num > 0) {
            let d = (num % 10) + 48;
            vector::push_back(&mut digits, d);
            num = num / 10;
        };

        let mut bytes = vector::empty<u8>();
        let mut i = vector::length(&digits);

        while (i > 0) {
            i = i - 1;
            vector::push_back(&mut bytes, *vector::borrow(&digits, i));
        };

        string::utf8(bytes)
    }

    /// 🔥 MINT AUTO NUMBER
    public fun mint(counter: &mut Counter, ctx: &mut tx_context::TxContext) {

        counter.value = counter.value + 1;

        let num = u64_to_string(counter.value);

        let base = string::utf8(b"Testnet Baby Suiduckz NFT #");
        let name = string::concat(base, num);

        let nft = BabySuiDuckz {
            id: object::new(ctx),
            name: name,
            image_url: string::utf8(b"https://i.imgur.com/JyYxHwd.jpeg"),
        };

        transfer::transfer(nft, tx_context::sender(ctx));
    }
}
