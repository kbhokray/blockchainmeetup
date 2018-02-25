pragma solidity ^0.4.16;

contract VizStorage {
    
    // deploy this contract, call @checkMemoryLocation
    // with an array param, ex: [1,2,3]
    // debug the transaction and check the variables in  
    // state and local locations in the debugger
    
    uint[] stateArray1; // the data location of stateArray1 is storage
    uint[] stateArray2 = [5, 6 ,7, 8];
    uint[] stateArray3 = [9, 10, 11, 12];

    // the data location of memoryArray is memory
    function checkMemoryLocation(uint[] memoryArray) public {
        
        // works, copies the whole array to storage
        stateArray1 = memoryArray; 
        // works, assigns a pointer, data location of y is storage
        var storagePointer = stateArray1; 
        // fine, returns the 2nd element
        storagePointer[2]; 
        // fine, modifies stateArray1 through storagePointer
        storagePointer.length = 2;
        
        // fine, clears the array, also modifies storagePointer
        delete stateArray1;
        
        // error since storageArrayFunction expects storage array reference
        // storageArrayFunction(memoryArray);
        
        // changes stateArray2
        storageArrayFunction(stateArray2);
        // doesn't change stateArray2 since data is copied into new memoryArray 
        memoryArrayFunction(stateArray2);
        
        // array literals are memory array of fixed size
        uint[3] memory fixedSizeArrayInit = [uint(1), 2, 3];

        // throws error, since array literals are of fixed size 
        // memoryArrayFunction([uint(1), 2, 3]);

        // The following does not work; it would need to create a new temporary /
        // unnamed array in storage, but storage is "statically" allocated:
        // storagePointer = memoryArray;
        
        // delete assigns memory array to location of array
        // but storagePointer is storage pointer, so this doesn't compile 
        // delete storagePointer;

    }

    function storageArrayFunction(uint[] storage stateArrayParam) internal {
        // creates a reference to stateArray2
        // modifies stateArray2
        stateArrayParam[0] = 13;
        stateArrayParam = stateArray3;
        stateArrayParam[0] = 14;
    }
    
    function memoryArrayFunction(uint[] memoryArrayParam) view public {
        // creates an independent, temporary copy in memory
        // modifies memoryArrayParam whithout changing stateArray2
        memoryArrayParam[0] = 15;
        //copies stateArray3 into memoryArrayParam
        memoryArrayParam = stateArray3;
        // modifies memoryArrayParam whithout changing stateArray3
        memoryArrayParam[0] = 16;
    }
}
