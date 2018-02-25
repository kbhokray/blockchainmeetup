pragma solidity ^0.4.11;

contract Shippable {
    
    enum ShipmentStatus { InTransit, Delivered }
    struct Shippment {
        string orderId;
        string itemId;
        address from;
        address to;
        address shipper;
        ShipmentStatus status;
    }
    
    mapping(address => bool) registeredShipper;
    mapping(string => Shippment) shipments;

    modifier onlyRegisteredShipper() {
        //check if registered shipper
        require (registeredShipper[msg.sender] != false );
        _;
    }

    function isInTransit(string orderId) 
    constant 
    public 
    returns(bool) {
        //return true check shipment for the order exists, else return false
        if(bytes(shipments[orderId].orderId).length != 0) {
            return true;
        } else {
            return false;
        }
    }

    function ship(string orderId, string itemId, address from, address to) 
    onlyRegisteredShipper 
    public {
        //add to shipments        
        shipments[orderId] = Shippment ({      
            orderId: orderId,
            itemId: itemId,
            from: from,
            to: to,
            shipper: msg.sender,
            status: ShipmentStatus.InTransit
        });
    }
    
    function updateShipmentStatus(string orderId) 
    onlyRegisteredShipper
    public {
        //check shipment for the orderId exists
        require (shipments[orderId].to != 0x0);
        
        //verify that the function caller is the shipper
        require (msg.sender == shipments[orderId].shipper);
        
        //verify that the status is valid
        require (shipments[orderId].status == ShipmentStatus.InTransit);
        // require (status == uint8(ShipmentStatus.Delivered));
        
        //update shipment status
        shipments[orderId].status = ShipmentStatus.Delivered;
    }
    
    function getShipmentStatus(string orderId) 
    constant
    public
    returns (ShipmentStatus) {
        //return shipment status of the order
        return shipments[orderId].status;
    }
    
    function getShipper(string orderId) 
    constant
    public
    returns (address) {
        //return the shipper of the order
        return shipments[orderId].shipper;
    }
    
    function addShipper(address shipper) public {
        //add to registered shippers
        registeredShipper[shipper] = true;
    }
    
    function isShipper(address shipper) 
    constant 
    public 
    returns(bool) {
        //check if registered shipper
        return registeredShipper[shipper];
    }
}
