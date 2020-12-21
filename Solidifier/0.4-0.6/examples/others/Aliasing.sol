pragma solidity ^0.5.10;

library Verification {
    function Assert  (bool b) public;
    function Assume  (bool b) public;
    function CexPrinti  (uint i) public;
}

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

       Verification.Assert(aliased_ms.i == 1);
       Verification.Assert(ms.i == 1);

        aliased_ms.i = 2;

       Verification.Assert(aliased_ms.i == 2);
       Verification.Assert(ms.i == 2);

        // Deep copy into memory

        // Creates a new copy of s into memory
        // Hence ms and aliased_ms are not aliased anymore

        ms = s;

       Verification.Assert(ms.i == 0);
       Verification.Assert(aliased_ms.i == 2);

        // There is not aliasing between memory and storage
        ms.i = 1;

       Verification.Assert(ms.i == 1);
       Verification.Assert(s.i == 0);

        // Storage aliasing; aliased_s is a storage pointer
        // as opposed to a storage reference like s and s2;
        S storage aliased_s = s;

        aliased_s.i = 3;

       Verification.Assert(s.i == 3);
       Verification.Assert(aliased_s.i == 3);

        // Aliased to s2 now
        aliased_s = s2;

       Verification.Assert(aliased_s.i == 2);

        aliased_s.i = 4;

       Verification.Assert(aliased_s.i == 4);
       Verification.Assert(s2.i == 4);


        // Deep copy of s2 into s
        s = aliased_s;

       Verification.Assert(s.i == 4);

        s.i = 5;

       Verification.Assert(s.i == 5);
       Verification.Assert(aliased_s.i == 4);
       Verification.Assert(s2.i == 4);


        // Deep copy from memory to storage
        ms.i = 6;

        s = ms;

       Verification.Assert(s.i == 6);
       Verification.Assert(ms.i == 6);

        s.i = 7;

       Verification.Assert(s.i == 7);
       Verification.Assert(ms.i == 6);

    }
}