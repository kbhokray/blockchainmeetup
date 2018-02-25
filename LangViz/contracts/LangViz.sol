pragma solidity ^0.4.16;

contract LangViz {
    
    mapping (address => uint256) balanceOf;
    mapping (bytes4 => string) dictionary;
    
    uint public reward = 1000;

    event EntryAdded(bytes4 key);
    event Reward(address to, bytes4 key);

    function LangViz(uint256 initialSupply) public {
        balanceOf[this] = initialSupply * 10 ** 6;
    }
    
    function addDictionaryEntries(bytes4 key, string value) public {
        dictionary[key] = value;
        EntryAdded(key);
    }

    function getBalance() constant public returns(uint256) {
        return balanceOf[msg.sender];
    }
    
    function translate(bytes4 key, string translation) public {
        require(balanceOf[this] >= 0);
        if(keccak256(dictionary[key]) == keccak256(translation)) {
            balanceOf[this] -= reward;
            balanceOf[msg.sender] += reward;
            Reward(msg.sender, key);
        }
    }
}
