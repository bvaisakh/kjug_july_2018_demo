pragma solidity 0.4.24;


contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Candidates Collection
    mapping(uint => Candidate) public candidates;

    // Collection of accounts that have voted
    mapping(address => bool) public voters;
    
    // Candidates Count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate(string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender], "Already voted.");

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate.");

        // record that the voter has voted
        voters[msg.sender] = true;
        
        // update candidate vote count
        candidates[_candidateId].voteCount ++;

        // emit voted event
        emit votedEvent(_candidateId);
    }
}