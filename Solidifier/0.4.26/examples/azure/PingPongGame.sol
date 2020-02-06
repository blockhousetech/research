pragma solidity ^0.4.25;

library Verification {
    function Assert  (bool b) public;
    function Assume  (bool b) public;
    function CexPrinti  (uint i) public;
}

contract Starter
{
    enum StateType { GameProvisioned, Pingponging, GameFinished}

    StateType State;

    uint PingPongGameId;
    address GameStarter;
    Player GamePlayer;
    int PingPongTimes;

    constructor (uint gameId) public{
        PingPongGameId = gameId;
        GameStarter = msg.sender;

        GamePlayer = new Player(PingPongGameId);

        State = StateType.GameProvisioned;

        Verification.Assert(State == StateType.GameProvisioned);
    }

    function StartPingPong(int pingPongTimes) public
    {
        Verification.Assert(State == StateType.GameProvisioned);

        PingPongTimes = pingPongTimes;

        State = StateType.Pingponging;

        GamePlayer.Ping(pingPongTimes);

        Verification.Assert(State == StateType.Pingponging ||
                            State == StateType.GameFinished);
    }

    function Pong(int currentPingPongTimes) public
    {
        int remainingPingPongTimes = currentPingPongTimes - 1;

        if(remainingPingPongTimes > 0)
        {
            State = StateType.Pingponging;
            GamePlayer.Ping(remainingPingPongTimes);
        }
        else
        {
            State = StateType.GameFinished;
            GamePlayer.FinishGame();
        }
    }

    function FinishGame() public
    {
        State = StateType.GameFinished;
    }
}

contract Player
{
    enum StateType {PingpongPlayerCreated, PingPonging, GameFinished}

    StateType State;

    address GameStarter;
    uint PingPongGameId;

    constructor (uint pingPongGameId) public {
        GameStarter = msg.sender;
        PingPongGameId = pingPongGameId;

        State = StateType.PingpongPlayerCreated;
    }

    function Ping(int currentPingPongTimes) public
    {
        int remainingPingPongTimes = currentPingPongTimes - 1;

        Starter starter = Starter(msg.sender);
        if(remainingPingPongTimes > 0)
        {
            State = StateType.PingPonging;
            starter.Pong(remainingPingPongTimes);
        }
        else
        {
            State = StateType.GameFinished;
            starter.FinishGame();
        }
    }

    function FinishGame() public
    {
        State = StateType.GameFinished;
    }
}
