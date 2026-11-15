module move_by_example::counter_shared {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    /// A shared state counter anyone can increment
    struct Counter has key {
        id: UID,
        owner: address,
        value: u64,
    }

    /// Create and share a new counter instance
    public fun create_counter(ctx: &mut TxContext) {
        let counter = Counter {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            value: 0,
        };
        transfer::share_object(counter);
    }

    /// Increment counter value (callable by anyone)
    public fun increment(counter: &mut Counter) {
        counter.value = counter.value + 1;
    }

    /// Reset counter to zero (only owner)
    public fun reset(counter: &mut Counter, ctx: &TxContext) {
        assert!(counter.owner == tx_context::sender(ctx), 0);
        counter.value = 0;
    }

    /// View function returning current counter value
    public fun value(counter: &Counter): u64 {
        counter.value
    }
}
