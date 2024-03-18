// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

contract ElectionManagement {
    // Struct for an election
    struct Election {
        string name;
        uint startTime;
        uint endTime;
        address[] candidates;
        address[] voters;
    }

    // Mapping of election ID to election details
    mapping(uint => Election) public elections;
    uint public electionsCount;

    // Create a new election
    function createElection(string memory _name, uint _durationInHours, address[] memory _candidates) public {
        electionsCount++;
        Election storage newElection = elections[electionsCount];
        newElection.name = _name;
        newElection.startTime = block.timestamp;
        newElection.endTime = block.timestamp + (_durationInHours * 1 hours);
        newElection.candidates = _candidates;
    }

    // Add voters to an election
    function addVoters(uint _electionId, address[] memory _voters) public {
        Election storage election = elections[_electionId];
        for(uint i = 0; i < _voters.length; i++) {
            election.voters.push(_voters[i]);
        }
    }

    // Close an election
    function closeElection(uint _electionId) public {
        Election storage election = elections[_electionId];
        require(block.timestamp >= election.endTime, "Election is not yet over");
        delete elections[_electionId];
    }
}