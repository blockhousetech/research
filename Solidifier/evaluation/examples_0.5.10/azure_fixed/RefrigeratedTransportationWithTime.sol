pragma solidity >=0.4.25 <0.6.0;


contract RefrigeratedTransportationWithTime
{
    //Set of States
    enum StateType { Created, InTransit, Completed, OutOfCompliance}
    enum SensorType { None, Humidity, Temperature }

    //List of properties
    StateType State;
    address Owner;
    address InitiatingCounterparty;
    address Counterparty;
    address PreviousCounterparty;
    address Device;
    address SupplyChainOwner;
    address SupplyChainObserver;
    int MinHumidity;
    int MaxHumidity;
    int MinTemperature;
    int MaxTemperature;
    SensorType ComplianceSensorType;
    int ComplianceSensorReading;
    bool ComplianceStatus;
    enum ComplianceDetailEnum {NA, HumidityOutOfRange, TemperatureOutOfRange}
    ComplianceDetailEnum ComplianceDetail;
    uint LastSensorUpdateTimestamp;

    constructor(address device, address supplyChainOwner, address supplyChainObserver, int minHumidity, int maxHumidity, int minTemperature, int maxTemperature) public
    {
        ComplianceStatus = true;
        ComplianceSensorReading = -1;
        InitiatingCounterparty = msg.sender;
        Owner = InitiatingCounterparty;
        Counterparty = InitiatingCounterparty;
        Device = device;
        SupplyChainOwner = supplyChainOwner;
        SupplyChainObserver = supplyChainObserver;
        MinHumidity = minHumidity;
        MaxHumidity = maxHumidity;
        MinTemperature = minTemperature;
        MaxTemperature = maxTemperature;
        State = StateType.Created;
        ComplianceDetail = ComplianceDetailEnum.NA;

       assert(State == StateType.Created);
    }

    function IngestTelemetry(int humidity, int temperature, uint timestamp) public
    {
        if (Device != msg.sender
            || State == StateType.OutOfCompliance
            || State == StateType.Completed)
        {
            revert();
        }

       assert(State == StateType.Created ||
                            State == StateType.InTransit);

        LastSensorUpdateTimestamp = timestamp;

        if (humidity > MaxHumidity || humidity < MinHumidity)
        {
            ComplianceSensorType = SensorType.Humidity;
            ComplianceSensorReading = humidity;
            ComplianceDetail = ComplianceDetailEnum.HumidityOutOfRange;
            ComplianceStatus = false;
        }
        else if (temperature > MaxTemperature || temperature < MinTemperature)
        {
            ComplianceSensorType = SensorType.Temperature;
            ComplianceSensorReading = temperature;
            ComplianceDetail = ComplianceDetailEnum.TemperatureOutOfRange;
            ComplianceStatus = false;
        }

        if (ComplianceStatus == false)
        {
            State = StateType.OutOfCompliance;
        }

       assert(State == StateType.Created ||
                            State == StateType.InTransit ||
                            State == StateType.OutOfCompliance);
    }

    function TransferResponsibility(address newCounterparty) public
    {
        if ((InitiatingCounterparty != msg.sender && Counterparty != msg.sender)
            || State == StateType.Completed
            || State == StateType.OutOfCompliance
            || newCounterparty == Device)
        {
            revert();
        }

       assert(State == StateType.Created ||
                            State == StateType.InTransit);

        if (State == StateType.Created)
        {
            State = StateType.InTransit;
        }

        PreviousCounterparty = Counterparty;
        Counterparty = newCounterparty;

       assert(State == StateType.InTransit);
    }

    function Complete() public
    {
        if ((Owner != msg.sender && SupplyChainOwner != msg.sender)
            || State == StateType.Completed
            || State == StateType.OutOfCompliance)
        {
            revert();
        }

        //FIX: Add precondition
        if (State == StateType.Created)
        {
            revert();
        }

       assert(State == StateType.InTransit);

        State = StateType.Completed;
        PreviousCounterparty = Counterparty;
        Counterparty = address(0);

       assert(State == StateType.Completed);
    }
}