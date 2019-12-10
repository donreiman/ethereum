pragma solidity >= 0.4.22 < 0.7.0;

contract Election {
    struct Candidate {
        uint candidateId;
        string name;
        uint votes;
    }

    event NewCandidate (
        uint indexed _candidateId,
        string name,
        uint votes
    );

    event VoteCast (
        uint indexed _candidateId
    );

    // mapping between candidate ids and candidate structs
    mapping(uint => Candidate) public candidates;
    // account has already voted during the lifetime of the contract
    mapping(address => bool) public voters;
    uint public candidatesCount;
    uint maxCandidates;
    bool ended;
    address owner;

    constructor(uint _maxCandidates) public {
        require(_maxCandidates >= 2, 'too few candidates');
        maxCandidates = _maxCandidates;
        ended = false;
        owner = msg.sender;
        candidatesCount = 0;
    }

    function addCandidate(string memory name) public {
        require(!ended, 'election is over');
        require(msg.sender == owner, 'unauthorized');
        require(candidatesCount <= maxCandidates, 'too many candidates');

        candidatesCount++;
        candidates[candidatesCount - 1] = Candidate(candidatesCount, name, 0);
        emit NewCandidate(
            candidates[candidatesCount - 1].candidateId,
            candidates[candidatesCount - 1].name,
            candidates[candidatesCount - 1].votes
        );
    }

    function castVote(uint candidateId) public {
        require(!ended, 'election is over');
        require(!voters[msg.sender], 'already voted');

        voters[msg.sender] = true;
        candidates[candidateId].votes++;
        emit VoteCast(candidateId);
    }

    function endVoting() public {
        require(msg.sender == owner, 'unauthorized');
        ended = true;
    }

    function getCandidate(uint candidateId) public view returns (uint, string memory, uint) {
        require(candidateId >= 0 && candidateId < candidatesCount, 'out of range');
        Candidate memory candidate = candidates[candidateId];
        return (candidate.candidateId, candidate.name, candidate.votes);
    }

    function getName(uint candidateId) public view returns (string memory) {
        require(candidateId >= 0 && candidateId < candidatesCount, 'out of range');
        return candidates[candidateId].name;
    }

    function getVotes(uint candidateId) public view returns (uint) {
        require(candidateId >= 0 && candidateId < candidatesCount, 'out of range');
        return candidates[candidateId].votes;
    }
}