# move-by-example

A collection of clean, annotated Move programming language examples for the Sui blockchain.

Each module isolates a specific Sui concept or architectural pattern with accompanying unit tests.

## Contents

1. **hello_world.move**: Module basics, entry functions, and custom event emission (`event::emit`)
2. **object_basics.move**: Sui object lifecycle (`UID`, `key`, `store`), owned object creation, transfer, and deletion
3. **capabilities.move**: Capability design pattern (`AdminCap`) for access-controlled privileged functions
4. **counter_shared.move**: Shared object pattern (`transfer::share_object`) for multi-user concurrent state
5. **custom_coin.move**: Fungible token standard with one-time witness, `TreasuryCap`, minting, and burning

## Getting Started

### Prerequisites

- Sui CLI (version 1.20+ recommended)

### Build Package

```bash
sui move build
```

### Run Unit Tests

```bash
sui move test
```

## Structure

```text
move-by-example/
├── sources/
│   ├── hello_world.move
│   ├── object_basics.move
│   ├── capabilities.move
│   ├── counter_shared.move
│   └── custom_coin.move
├── tests/
│   └── example_tests.move
├── Move.toml
├── LICENSE
└── README.md
```

## License

MIT License. See LICENSE for details.

Author: bynextex (https://github.com/bynextex) | X: https://x.com/kuntekul
