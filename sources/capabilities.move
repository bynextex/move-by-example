module move_by_example::capabilities {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    /// Admin capability granting privileged actions
    struct AdminCap has key, store {
        id: UID,
    }

    /// Managed configuration object
    struct Config has key {
        id: UID,
        fee_basis_points: u16,
    }

    /// Module initializer: runs once on package publish
    fun init(ctx: &mut TxContext) {
        // Mint the AdminCap and deliver to package publisher
        let admin_cap = AdminCap {
            id: object::new(ctx),
        };
        transfer::public_transfer(admin_cap, tx_context::sender(ctx));

        // Create shared config
        let config = Config {
            id: object::new(ctx),
            fee_basis_points: 100, // 1%
        };
        transfer::share_object(config);
    }

    /// Privileged entrypoint: only holders of AdminCap can adjust fees
    public fun update_fee(
        _cap: &AdminCap,
        config: &mut Config,
        new_fee_basis_points: u16
    ) {
        config.fee_basis_points = new_fee_basis_points;
    }

    /// Public view function
    public fun fee_basis_points(config: &Config): u16 {
        config.fee_basis_points
    }
}
