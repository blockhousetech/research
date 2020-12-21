pragma solidity >=0.4.25 <0.6.0;

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

       assert(State == StateType.Created);
    }

    function StartThermostat() public
    {
        if (Installer != msg.sender || State != StateType.Created)
        {
            revert();
        }

       assert(State == StateType.Created);

        State = StateType.InUse;

       assert(State == StateType.InUse);
    }

    function SetTargetTemperature(int targetTemperature) public
    {
        if (User != msg.sender || State != StateType.InUse)
        {
            revert();
        }

       assert(State == StateType.InUse);

        TargetTemperature = targetTemperature;

       assert(State == StateType.InUse);
    }

    function SetMode(ModeEnum mode) public
    {
        if (User != msg.sender || State != StateType.InUse)
        {
            revert();
        }
       assert(State == StateType.InUse);

        Mode = mode;

       assert(State == StateType.InUse);
    }
}