pragma solidity >=0.4.25 <0.6.0;

contract StorageDeterministicLayout {

    uint[][] ints;

    function t() public {

      ints.length = 3;
      ints[2].length = 2;

      // This pointer will always point to ints[2] even if ints gets resized to some n < 3
      uint[] storage pointer_to_ints_2 = ints[2];

      ints[2][0] = 20;
      ints[2][1] = 21;

     assert(pointer_to_ints_2[0] == 20);
     assert(pointer_to_ints_2[1] == 21);

      // resizing of ints: getting rid of ints[2]
      ints.length = 2;

      // pointer_to_ints_2 (i.e. ints[2]) has length zero so its elements cannot be accessed.
      // So, the following would not raise an error as pointer_to_ints_2[0] creates a silent failure.
      // pointer_to_ints_2[0];// or ints[2][0];
      //assert(false);

      // Re-introduce ints[2] the pointer pointer_to_ints_2 is not a dangling pointer
      // pointing to some invalid part of the storage but a pointer to ints[2]
      ints.length = 3;
      ints[2].length = 2;

     assert(ints[2][0] == 0);
     assert(ints[2][1] == 0);

      pointer_to_ints_2[0] = 20;
      pointer_to_ints_2[1] = 21;

     assert(pointer_to_ints_2[0] == 20);
     assert(pointer_to_ints_2[1] == 21);


    }
}