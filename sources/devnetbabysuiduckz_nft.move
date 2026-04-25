module baby::suiduckz_nft { 

    use std::string;
    use sui::object::{UID, ID};
    use sui::object;
    use sui::tx_context::{TxContext};
    use sui::transfer;
    use sui::event;
    use sui::url::{Self, Url};
    use sui::table::{Table};

    /// =========================
    /// NFT STRUCT
    /// =========================

    public struct DevnetBabySuiduckzNFT has key, store {
        id: UID,
        name: string::String,
        description: string::String,
        url: Url,
    }

    /// =========================
    /// GLOBAL STATE
    /// =========================

    public struct Supply has key {
        id: UID,
        total_minted: u64,
        max_supply: u64,
    }

    public struct MintedRegistry has key {
        id: UID,
        minted: Table<address, bool>,
    }

    /// =========================
    /// EVENT
    /// =========================

    public struct NFTMinted has copy, drop {
        object_id: ID,
        creator: address,
        name: string::String,
    }

    /// =========================
    /// INITIALIZATION
    /// =========================

    /// Must be called once after deployment
    public entry fun init(ctx: &mut TxContext) {

        let supply = Supply {
            id: object::new(ctx),
            total_minted: 0,
            max_supply: 2700,
        };

        let registry = MintedRegistry {
            id: object::new(ctx),
            minted: Table::new(ctx),
        };

        transfer::share_object(supply);
        transfer::share_object(registry);
    }

    /// =========================
    /// MINT FUNCTION
    /// =========================

    /// Rules:
    /// - Max supply: 2700
    /// - One NFT per wallet
    public entry fun mint(
        supply: &mut Supply,
        registry: &mut MintedRegistry,
        ctx: &mut TxContext
    ) {
        let sender = tx_context::sender(ctx);

        /// Check supply limit
        assert!(supply.total_minted < supply.max_supply, 0);

        /// Check if already minted
        assert!(!Table::contains(&registry.minted, sender), 1);

        let nft = DevnetBabySuiduckzNFT {
            id: object::new(ctx),
            name: string::utf8(b"Devnet Baby Suiduckz NFT"),
            description: string::utf8(
                b"This is a Devnet NFT. It has no monetary value."
            ),
            url: url::new_unsafe_from_bytes(
                b"https://i.imgur.com/tElnLzR.jpeg"
            ),
        };

        /// Update state
        supply.total_minted = supply.total_minted + 1;
        Table::add(&mut registry.minted, sender, true);

        event::emit(NFTMinted {
            object_id: object::id(&nft),
            creator: sender,
            name: nft.name,
        });

        transfer::public_transfer(nft, sender);
    }
}
