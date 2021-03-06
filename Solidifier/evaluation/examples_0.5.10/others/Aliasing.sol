pragma solidity >=0.4.25 <0.6.0;

contract Aliasing {

    struct S {
        uint i;
    }

    S s;
    S s2;

    function t() public {
        s.i = 0;
        s2.i = 2;

        // Memory aliasing
        S memory ms;
        S memory aliased_ms = ms;

        ms.i = 1;

       assert(aliased_ms.i == 1);
       assert(ms.i == 1);

        aliased_ms.i = 2;

       assert(aliased_ms.i == 2);
       assert(ms.i == 2);

        // Deep copy into memory

        // Creates a new copy of s into memory
        // Hence ms and aliased_ms are not aliased anymore

        ms = s;

       assert(ms.i == 0);
       assert(aliased_ms.i == 2);

        // There is not aliasing between memory and storage
        ms.i = 1;

       assert(ms.i == 1);
       assert(s.i == 0);

        // Storage aliasing; aliased_s is a storage pointer
        // as opposed to a storage reference like s and s2;
        S storage aliased_s = s;

        aliased_s.i = 3;

       assert(s.i == 3);
       assert(aliased_s.i == 3);

        // Aliased to s2 now
        aliased_s = s2;

       assert(aliased_s.i == 2);

        aliased_s.i = 4;

       assert(aliased_s.i == 4);
       assert(s2.i == 4);


        // Deep copy of s2 into s
        s = aliased_s;

       assert(s.i == 4);

        s.i = 5;

       assert(s.i == 5);
       assert(aliased_s.i == 4);
       assert(s2.i == 4);


        // Deep copy from memory to storage
        ms.i = 6;

        s = ms;

       assert(s.i == 6);
       assert(ms.i == 6);

        s.i = 7;

       assert(s.i == 7);
       assert(ms.i == 6);

    }
}