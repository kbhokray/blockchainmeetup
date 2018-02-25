pragma solidity ^0.4.11;

contract Orderable {
    
    enum OrderStatus { Active, Complete }
    struct Order {
        string orderId;
        string itemId;
        address from;
        address to;
        uint amount;
        OrderStatus status;
    }
    
    mapping(string => Order) orders;
    
    function placeOrder(string orderId, string itemId, address from, address to, uint amount) public {
        //add to orders
        
        orders[orderId] = Order({
                orderId: orderId,
                itemId: itemId,
                from: from,
                to: to,
                amount: amount,
                status: OrderStatus.Active
            });
    }
    
    function isActiveOrder(string orderId) constant public returns (bool) {
        //exists in orders
        if (bytes(orders[orderId].orderId).length == 0) {
            return false;
        }
        //isActive order
        if (orders[orderId].status == OrderStatus.Complete) {
            return false;
        }

        return true;
    }
    
    function isRecipient(string orderId, address addr) 
    constant 
    public 
    returns (bool){
        //is recipient
        return (orders[orderId].to == addr);
    }

    function getOrderFromAndTo(string orderId) 
    constant 
    public 
    returns (address from, address to) {
        //return from and to
        return (orders[orderId].from, orders[orderId].to);
    }
    
    function getOrderItemId(string orderId)
    constant
    public
    returns (string) {
        //order itemid
        return orders[orderId].itemId;
    }

    function settleOrder(string orderId)
    internal {
        //check contract has sufficient balance
        require (orders[orderId].amount <= this.balance);
        
        //transfer amount
        orders[orderId].from.transfer(orders[orderId].amount);
    
        //delete order
        delete orders[orderId];
    }
}