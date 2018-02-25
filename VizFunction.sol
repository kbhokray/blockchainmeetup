pragma solidity ^0.4.16;

contract VizFunction {
	uint contractState = 1;
	string contractStateString = "state";
	
	function getBalance() constant public returns(uint) {
        //helper function to get this contracts balance
        return(this.balance);
	}
	
	//call @getBalance before and after calling this
	function payableFunction() public payable {
	    //set the amount to be sent using the 
	    //"Value" input in the left hand section in remix
	    uint amountSent = msg.value;
	}
	
	function readStateConst() constant public returns(uint state) {
	    //return state without altering it
	    //return value = 1
	    //contractState after return = 1
		return contractState;
	}
	
	function readStateConstMult(uint mult) constant public returns(uint state) {
	    //return state after multiplying it with @mult
	    //return value = contractState * mult
	    //contractState after return = 1
	    contractState = contractState * mult;
		return contractState;
	}
	
	function readStateSendMult(uint mult) public {
	    //return state after multiplying it with @mult
	    //return value = transaction details (tx hash, etc)
	    //contractState after return = contractState * mult
		contractState = contractState * mult;
	}
	

    function readStateExt() constant external returns(uint state) {
        //same as @readStateConst
	    //can be called by users and other contracts
	    //due to external modifier
	    //public vs external here: https://ethereum.stackexchange.com/a/19391/5791
		return contractState;
	}
	
    function readStateInternal() constant internal returns(uint state) {
        //same as @readStateConst
	    //cannot be called by users and other contractState
	    //due to internal modifier
	    //but can be called from internal function
		return contractState;
    }

    function callReadStateInternal() constant public returns(uint state) {
        //can call @readStateInternal
	    uint internalState = readStateInternal();
		return internalState;
    }
    

	function readMultipleStates() constant public returns (uint state, string stateString){
	    //can send return values as well
		state = contractState;
		stateString = contractStateString;       
	}

	function callReadMultipleStates() constant public returns (uint, string) {
	    //type inferred by compiler
		var (state, stateString) = readMultipleStates();
		//send multiple values without assigning to return vars
		return(state, stateString);
	}
}
