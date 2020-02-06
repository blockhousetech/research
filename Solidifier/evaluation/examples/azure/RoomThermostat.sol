pragma solidity ^0.4.25;

library Verification {
    function Assert  (bool b) public;
    function Assume  (bool b) public;
    function CexPrinti  (uint i) public;
}

contract RoomThermostat
{
    //Set of States
    enum StateType { Created, InUse}
    
    //List of properties
    StateType State;
    address Installer;
    address User;
    int TargetTemperature;
    enum ModeEnum {Off, Cool, Heat, Auto}
    ModeEnum  Mode;
    
    constructor(address thermostatInstaller, address thermostatUser) public
    {
        Installer = thermostatInstaller;
        User = thermostatUser;
        TargetTemperature = 70;

        Verification.Assert(State == StateType.Created);
    }

    function StartThermostat() public
    {
        if (Installer != msg.sender || State != StateType.Created)
        {
            revert();
        }

        Verification.Assert(State == StateType.Created);

        State = StateType.InUse;

        Verification.Assert(State == StateType.InUse);
    }

    function SetTargetTemperature(int targetTemperature) public
    {
        if (User != msg.sender || State != StateType.InUse)
        {
            revert();
        }

        Verification.Assert(State == StateType.InUse);

        TargetTemperature = targetTemperature;

        Verification.Assert(State == StateType.InUse);
    }

    function SetMode(ModeEnum mode) public
    {
        if (User != msg.sender || State != StateType.InUse)
        {
            revert();
        }
        Verification.Assert(State == StateType.InUse);

        Mode = mode;

        Verification.Assert(State == StateType.InUse);
    }
}