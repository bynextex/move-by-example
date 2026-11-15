module move_by_example::hello_world {
    use std::string::{Self, String};
    use sui::event;
    use sui::tx_context::{Self, TxContext};

    /// Event emitted when greeting is triggered
    struct Greeting has copy, drop {
        sender: address,
        message: String,
    }

    /// Public entry function emitting a custom greeting event
    public fun say_hello(ctx: &mut TxContext) {
        event::emit(Greeting {
            sender: tx_context::sender(ctx),
            message: string::utf8(b"Hello, Sui Move!"),
        });
    }
}
