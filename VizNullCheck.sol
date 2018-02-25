pragma solidity ^0.4.16;


contract VizNullCheck {

  //Uninitialized storage variable declarations
  //initialized to 0s
  struct Struct {
    address owner;
    string  name;
  }
  
  address addr;
  string str;
  bytes32 keyword;
  int[7] staticArray;
  uint8[] dynamicArray;
  Struct userStruct;
  mapping(uint8 => bytes32) map;
  

  function nullValues(){
    bool  isNull;

    //check for zero address
    isNull = (addr == address(0x0));
    isNull = (addr == 0x0);
    //string doesn't provide length method
    //convert str to bytes and check its length
    isNull = (bytes(str).length == 0);
    //for bytes bytearray check zero
    isNull = (keyword == 0  ||  keyword == 0x0);
    //for dynamic array check length
    isNull = (dynamicArray.length == 0);
    //for static array check depends on the element type
    isNull = (staticArray[0] == 0);
    //Struct - check for some attribute of struct for 0 value
    isNull = (userStruct.owner == 0x0);
    isNull = (bytes(userStruct.name).length == 0);
    //mapping - all keys have 0 values i.e., all keys exist
    isNull = (map[19] == 0x0);
  }
}
