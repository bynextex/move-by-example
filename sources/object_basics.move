module move_by_example::object_basics {
    use std::string::{Self, String};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    /// An owned object containing simple fields
    struct Note has key, store {
        id: UID,
        title: String,
        body: String,
    }

    /// Create and transfer an owned object to caller
    public fun create_note(
        title_bytes: vector<u8>,
        body_bytes: vector<u8>,
        ctx: &mut TxContext
    ) {
        let note = Note {
            id: object::new(ctx),
            title: string::utf8(title_bytes),
            body: string::utf8(body_bytes),
        };
        transfer::public_transfer(note, tx_context::sender(ctx));
    }

    /// Transfer an existing note to a new owner
    public fun transfer_note(note: Note, recipient: address) {
        transfer::public_transfer(note, recipient);
    }

    /// Delete (burn) an owned note
    public fun delete_note(note: Note) {
        let Note { id, title: _, body: _ } = note;
        object::delete(id);
    }
}
