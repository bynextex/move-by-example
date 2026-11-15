module move_by_example::custom_coin {
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    /// One-time witness for coin initialization
    struct CUSTOM_COIN has drop {}

    /// Initializer: registers custom currency and transfers TreasuryCap to deployer
    fun init(witness: CUSTOM_COIN, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency(
            witness,
            9,                             // Decimals
            b"EXM",                        // Symbol
            b"Example Coin",               // Name
            b"Example token for Sui Move", // Description
            option::none(),                // Icon url
            ctx
        );
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
    }

    /// Mint new coins with TreasuryCap authority
    public fun mint(
        treasury_cap: &mut TreasuryCap<CUSTOM_COIN>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        let coin = coin::mint(treasury_cap, amount, ctx);
        transfer::public_transfer(coin, recipient);
    }

    /// Burn coins using TreasuryCap
    public fun burn(
        treasury_cap: &mut TreasuryCap<CUSTOM_COIN>,
        coin: Coin<CUSTOM_COIN>
    ) {
        coin::burn(treasury_cap, coin);
    }
}
