pragma solidity >=0.4.25 <0.6.0;


contract DefectiveComponentCounter {

     //Set of States
    enum StateType {Create, ComputeTotal}

    //List of properties
    StateType State;
    address Manufacturer;
    int[12] DefectiveComponentsCount;
    int Total;

    // constructor function
    constructor(int[12] memory defectiveComponentsCount) public
    {
        Manufacturer = msg.sender;
        DefectiveComponentsCount = defectiveComponentsCount;
        Total = 0;
        State = StateType.Create;

       assert(State == StateType.Create);
    }

    // call this function to send a request
    function ComputeTotal() public
    {
        if (Manufacturer != msg.sender)
        {
            revert();
        }

       assert(State == StateType.Create);

        // calculate total for only the first 12 values, in case more than 12 are entered
        for (uint i = 0; i < 12; i++)
        {
            Total += DefectiveComponentsCount[i];
        }

        State = StateType.ComputeTotal;

       assert(State == StateType.ComputeTotal);
    }

    // add the required getter function for array DefectiveComponentsCount
    function GetDefectiveComponentsCount() public view returns (int[12] memory) {
        return DefectiveComponentsCount;
    }
}