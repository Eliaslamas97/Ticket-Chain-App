// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

enum EventType {
    SPORTS,
    MUSIC,
    CINEMA
}
enum TicketStatus {
    VALID,
    USED,
    EXPIRED
}
enum TransferStatus {
    TRANSFERIBLE,
    NO_TRANSFERIBLE
}

contract Ticket {
    uint256 private id;
    string private eventName;
    string private eventDate;
    string private eventDescription;
    EventType private eventType;
    TicketStatus private ticketStatus;
    TransferStatus private transferStatus;
    uint256 private price;
    address private owner;

    event newTransferStatus(string);
    event newTicketStatus(string);
    event ShowPrice(uint256 price);

    constructor(
        EventType _eventType,
        TicketStatus _ticketStatus,
        TransferStatus _transferStatus,
        string memory _eventName,
        string memory _eventDate,
        string memory _eventDescription,
        uint256 _price,
        address _owner
    ) {
        // id = setId();
        eventType = _eventType;
        ticketStatus = _ticketStatus;
        transferStatus = _transferStatus;
        eventName = _eventName;
        eventDate = _eventDate;
        eventDescription = _eventDescription;
        price = _price;
        owner = _owner;
    }

    // changePrice()
    // changeTicketStatus()
    modifier isOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function getPrice() public {
        emit ShowPrice(price);
    }

    function getMarketPrice() public view returns (uint256) {
        return price;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function getTicketId() public view returns (uint256) {
        return id;
    }

    function getEventName() public view returns (string memory) {
        return eventName;
    }

    function getTransferStatus() public view returns (TransferStatus) {
        return transferStatus;
    }

    function getTicketStatus() public view returns (TicketStatus) {
        return ticketStatus;
    }

    //changePrice()
    function changePrice(uint256 _price) external isOwner {
        require(_price != price, "The price is the same");
        price = _price;
    }

    //changeTransferStatus()
    function setTransferStatus(TransferStatus newStatus) external {
        transferStatus = newStatus;
        getTransferStatus();
        emit newTransferStatus("Transfer status changed");
    }

    //changeTicketStatus()
    function setTicketStatus(TicketStatus newStatus) external {
        ticketStatus = newStatus;
        getTicketStatus();
        emit newTicketStatus("Ticket status changed");
    }
}
