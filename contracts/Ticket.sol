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
        id = setTicketId();
        eventType = _eventType;
        ticketStatus = _ticketStatus;
        transferStatus = _transferStatus;
        eventName = _eventName;
        eventDate = _eventDate;
        eventDescription = _eventDescription;
        price = _price;
        owner = _owner;
    }

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

    function changePrice(uint256 _price) external isOwner {
        require(_price != price, "The price is the same");
        price = _price;
    }

    function setTransferStatus(TransferStatus newStatus) external {
        transferStatus = newStatus;
        getTransferStatus();
        emit newTransferStatus("Transfer status changed");
    }

    function setTicketStatus(TicketStatus newStatus) external {
        ticketStatus = newStatus;
        getTicketStatus();
        emit newTicketStatus("Ticket status changed");
    }

    function changeOwner(address newOwner) external isOwner {
        owner = newOwner;
    }

    function setTicketId() private view returns (uint256) {
        uint256 num = uint256(
            keccak256(abi.encodePacked(msg.sender, block.timestamp, block.difficulty))
        );
        return num;
    }

    function getTicketData()
        public
        view
        returns (
            address,
            uint256,
            string memory,
            string memory,
            string memory,
            EventType,
            TicketStatus,
            TransferStatus,
            uint256,
            address
        )
    {
        return (
            address(this),
            id,
            eventName,
            eventDate,
            eventDescription,
            eventType,
            ticketStatus,
            transferStatus,
            price,
            owner
        );
    }
}
