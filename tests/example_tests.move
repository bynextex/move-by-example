#[test_only]
module move_by_example::example_tests {
    use sui::test_scenario::{Self as ts};
    use move_by_example::counter_shared::{Self, Counter};
    use move_by_example::object_basics::{Self, Note};

    const USER1: address = @0xAAA;
    const USER2: address = @0xBBB;

    #[test]
    fun test_counter_shared_flow() {
        let mut scenario = ts::begin(USER1);

        // User1 creates counter
        ts::next_tx(&mut scenario, USER1);
        {
            counter_shared::create_counter(ts::ctx(&mut scenario));
        };

        // User2 increments counter
        ts::next_tx(&mut scenario, USER2);
        {
            let mut counter = ts::take_shared<Counter>(&scenario);
            assert!(counter_shared::value(&counter) == 0, 0);

            counter_shared::increment(&mut counter);
            assert!(counter_shared::value(&counter) == 1, 1);

            ts::return_shared(counter);
        };

        // User1 resets counter
        ts::next_tx(&mut scenario, USER1);
        {
            let mut counter = ts::take_shared<Counter>(&scenario);
            assert!(counter_shared::value(&counter) == 1, 2);

            counter_shared::reset(&mut counter, ts::ctx(&mut scenario));
            assert!(counter_shared::value(&counter) == 0, 3);

            ts::return_shared(counter);
        };

        ts::end(scenario);
    }

    #[test]
    fun test_note_lifecycle() {
        let mut scenario = ts::begin(USER1);

        // User1 creates note
        ts::next_tx(&mut scenario, USER1);
        {
            object_basics::create_note(b"Title", b"Body content", ts::ctx(&mut scenario));
        };

        // User1 transfers to User2
        ts::next_tx(&mut scenario, USER1);
        {
            let note = ts::take_from_sender<Note>(&scenario);
            object_basics::transfer_note(note, USER2);
        };

        // User2 deletes the note
        ts::next_tx(&mut scenario, USER2);
        {
            let note = ts::take_from_sender<Note>(&scenario);
            object_basics::delete_note(note);
        };

        ts::end(scenario);
    }
}
