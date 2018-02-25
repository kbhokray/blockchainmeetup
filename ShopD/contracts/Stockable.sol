pragma solidity ^0.4.11;

contract Stockable {

    enum ItemStatus { ForSale, InUse }
    
    struct Item {
        string itemId;
        string itemName;
        uint price;
        address owner;
        ItemStatus status;
    }
    
    mapping(string => Item) stock;
    
    function isInStock(string itemId) constant public returns(bool) {
        //return true check the itemid is in stock else return false
        return (bytes(stock[itemId].itemId).length != 0);
    }
    
    function addToStock(address owner, string itemId, string itemName, uint price) public returns(bool) {
        //add item to stock

        Item memory item;
        item = Item({
            itemId: itemId,
            itemName: itemName,
            price: price,
            owner: owner,
            status: ItemStatus.ForSale
        });
        stock[itemId] = item;
        return true;
    }
    
    function isBuyable(address orderer, string itemId, uint payment) constant public returns (bool){
        //return false if item is not in stock (use isInStock function)
        if (!isInStock(itemId)) {
            return false;
        }
        //return false if orderer is the same as item owner
        if (getOwner(itemId) == orderer) {
            return false;
        }
        
        //return false if item status is not ForSale
        if (stock[itemId].status != ItemStatus.ForSale) {
            return false;
        }
        
        //return false if item price is more than payment
    
        if (stock[itemId].price > payment) {

            return false;
        }
        return true;
    }
    
    function getOwner(string itemId) constant public returns (address) {
        //return item owner
        return stock[itemId].owner;
    }
    
    function changeOwner(string itemId, address newOwner) internal {
        //change item owner to newOwner
        stock[itemId].owner = newOwner;
        
        //change item status to InUse
        stock[itemId].status = ItemStatus.InUse;
    }
}