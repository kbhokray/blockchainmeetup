pragma solidity ^0.4.16;

contract VizArrays {
    
    uint8[3] fixedSizeStorageArray;
    uint8[] dynamicStorageArray;
    
    function instantiateArray(uint8[3] arrayParam) public {
        // copies arrayParam from memory to storage
        fixedSizeStorageArray = arrayParam;
        // creates array literal in memory and copies to storage
        // missing third element is initialized to zero value
        fixedSizeStorageArray = [1, 2];
        // not allowed
        // fixedSizeStorageArray = new uint8[](3);
        // error since can't change length of a fixed size array        
        // fixedSizeStorageArray.length = 1;
        // can't add elements to fixed size arrays
        // fixedSizeStorageArray.push(2);
        // allowed
        fixedSizeStorageArray[0] = 3;
        
        // copies arrayParam from memory to storage
        dynamicStorageArray = arrayParam;
        // creates array literal in memory and copies to storage
        dynamicStorageArray = [4, 5, 6];
        // allowed
        dynamicStorageArray = new uint8[](3);
        // true
        dynamicStorageArray.length == 3;
        // deletes elements at index 2
        dynamicStorageArray.length = 2;
        // adds number 7 at index 3
        dynamicStorageArray.push(7);
        // allowed
        dynamicStorageArray[0] = 8;
        // allowed
        dynamicStorageArray = fixedSizeStorageArray;
        // not allowed
        // fixedSizeStorageArray = dynamicStorageArray;
        
        
        uint8[3] memory fixedSizeMemoryArray;
        uint8[] memory dynamicMemoryArray;
        
        // copies arrayParam to fixedSizeMemoryArray
        fixedSizeMemoryArray = arrayParam;
        // error - should intialize all three values
        // fixedSizeMemoryArray = [1, 2];
        // fine
        fixedSizeMemoryArray = [1, 2, 3];
        // error, since uint8[](3) is of type 
        // dynamic memory array of size 3
        // fixedSizeMemoryArray = new uint8[](3);
        // error since can't change length of a fixed size array
        // fixedSizeMemoryArray.length = 1;
        // can't add elements to fixed size arrays
        // fixedSizeMemoryArray.push(2);
        // allowed
        fixedSizeMemoryArray[0] = 3;
        
        // cant convert fixed size array to dynamic memory array
        // dynamicMemoryArray = arrayParam;
        // cant convert fixed size array to dynamic memory array
        // dynamicMemoryArray = [4, 5, 6];
        // allowed
        dynamicMemoryArray = new uint8[](3);
        // true
        dynamicMemoryArray.length == 3;
        // can't change memory array length
        // dynamicMemoryArray.length = 2;
        // no push method for memory arrays
        // can't change memory array length
        // dynamicMemoryArray.push(7);
        // allowed
        dynamicMemoryArray[0] = 8;
        // can't convert a fixed size array to dynamic size memory array
        // dynamicMemoryArray = fixedSizeMemoryArray;
        
        // allowed, copies fixedSizeStorageArray to memory
        fixedSizeMemoryArray = fixedSizeStorageArray;
        // allowed
        fixedSizeStorageArray = fixedSizeMemoryArray;
        // allowed, copies dynamicMemoryArray to storage
        dynamicStorageArray = dynamicMemoryArray;        
        // allowed
        dynamicMemoryArray = dynamicStorageArray;
        // not allowed as dynamic size memory array can't 
        // be assigned to fixed sized array
        // dynamicMemoryArray = fixedSizeStorageArray;
    }
}
