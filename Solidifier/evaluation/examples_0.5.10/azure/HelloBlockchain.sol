pragma solidity >=0.4.25 <0.6.0;

contract HelloBlockchain
{
     //Set of States
    enum StateType { Request, Respond}

    //List of properties
    StateType State;
    address Requestor;
    address Responder;

    uint RequestMessageCode;
    uint ResponseMessageCode;

    // constructor function
    constructor(uint messageCode) public
    {
        Requestor = msg.sender;
        RequestMessageCode = messageCode;
        State = StateType.Request;
    }

    // call this function to send a request
    function SendRequest(uint requestMessageCode) public
    {
        if (Requestor != msg.sender)
        {
            revert();
        }

       assert(State == StateType.Respond);

        RequestMessageCode = requestMessageCode;
        State = StateType.Request;

       assert(State == StateType.Request);
    }

    // call this function to send a response
    function SendResponse(uint responseMessageCode) public
    {
       assert(State == StateType.Request);

        Responder = msg.sender;

        // call ContractUpdated() to record this action
        ResponseMessageCode = responseMessageCode;
        State = StateType.Respond;

       assert(State == StateType.Respond);
    }
}