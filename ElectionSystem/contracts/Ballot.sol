// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Ballot {
    
     event ballotRequested(address, string);
     event testEvent(string);
    string public message;

    uint voterCount = 0;
    uint voteCount = 0;
    uint candidateCount = 1;
    uint private countResult = 0;
    address public officialAddress;
    string public officialName;    
    

    struct voter{
        string voterName;
        bool hasVoted;
    }
       
    //struct candidate{
    //    string office;
    //    string candidateName;
        //string party;
    //    uint cID;
    //}

    struct vote{
        uint8 p;
        uint8 h;
        uint8 g;
        uint8 a;
        uint8 s;
        uint8 c;
        
    }
    
    //mapping (uint => candidate) candidates;
    
    mapping (uint => vote) private votes;
    mapping (address => voter) public voterRegistry;
    
    enum State { Created, Voting, Ended }
    State public state;

    //MODIFIERS
    modifier condition(bool _condition) {
        require((_condition));
        _;
    }

    modifier officialOnly() {
        require(msg.sender == officialAddress);
        _;
    }

    modifier inState(State _state) {
        require(state == _state);
        _;
    }

    //FUNCTIONS
    constructor(string memory _message, string memory _officialName)  {
        message = _message;
        officialName = _officialName;
        officialAddress = msg.sender;

        state = State.Created;
        //uint cID = candidateCount++;
        //candidates[cID] = candidate("President", "Calvin Coolidge",  candidateCount); 

        //cID = candidateCount++;
        //candidates[cID] = candidate("President", "John W Davis", candidateCount); 
    
        //cID = candidateCount++;
        //candidates[cID] = candidate("President", "Robert LaFollette", candidateCount); 
        
        //cID = candidateCount++;
        //candidates[cID] = candidate("Representative", "Henry A Cooper", candidateCount); 
        
    }
    
    //THIS WON'T WORK IF YOU DON'T ENTER A NAME
    function registerVoter(address _voterAddress, string memory _voterName) public officialOnly{
        voter memory v;
        v.voterName = _voterName;
        v.hasVoted = false;
        voterRegistry[_voterAddress] = v;
        voterCount++;
    }

    function openPoll() public inState(State.Created) officialOnly {
        state = State.Voting;
    }

    function closePoll() public inState(State.Voting) officialOnly {
        state = State.Ended;
        
    }

    
    function submitVote(uint8 p, uint8 h, uint8 g, uint8 a, uint8 s, uint8 c) public inState(State.Voting){
        message = "failed";
        //make sure voter exists and has not voted
        if(bytes(voterRegistry[msg.sender].voterName).length != 0
        && !voterRegistry[msg.sender].hasVoted){
            vote memory v;
            v.p = p;
            v.h = h;
            v.g = g;
            v.a = a;
            v.s = s;
            v.c = c;
            votes[voteCount] = v;
            voteCount++;
            voterRegistry[msg.sender].hasVoted = true;
            message = "success";
            //emit voteSubmitted();
        }
        
    }
    
    
    //view function are read-only, good for "getters"
    function getVoteCount(uint cID) view public returns(uint) {
        uint result = 0;
        
            for (uint i = 0; i < voteCount; i++) {
                if (votes[i].p  == cID || votes[i].h  == cID || votes[i].g  == cID || votes[i].a  == cID || votes[i].s  == cID || votes[i].c  == cID) {
                    result++;
                }
            }
        
        return result;
        
    }

   function set(string memory _message) public {
       message = _message;
       emit testEvent(_message);
   }
   
   function checkVoted(address  _voterAddress) view public returns(bool){
       if (voterRegistry[_voterAddress].hasVoted) {
           return true;
       } else {
           return false;
       }
   }

    function requestBallot(address _voterAddress, string memory _voterName) public {
     emit ballotRequested(_voterAddress, _voterName);   
    }
    

}

