pragma solidity ^0.8.0;

contract CarRental {
    struct Car {
        string make;
        string model;
        bool available;
    }
    
    mapping(uint256 => Car) public cars;
    address public owner;
    uint256 public rentalFee;
    
    event CarRented(uint256 carId, address renter);
    
    constructor() {
        owner = msg.sender;
        rentalFee = 1 ether; // Set the rental fee to 1 Ether (adjust as needed)
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action.");
        _;
    }
    
    function addCar(uint256 carId, string memory make, string memory model) public onlyOwner {
        require(!carExists(carId), "Car already exists.");
        cars[carId] = Car(make, model, true);
    }
    
    function rentCar(uint256 carId) public payable {
        require(carExists(carId), "Car does not exist.");
        Car storage car = cars[carId];
        require(car.available, "Car is not available for rental.");
        require(msg.value == rentalFee, "Incorrect rental fee.");
        
        car.available = false;
        emit CarRented(carId, msg.sender);
    }
    
    function returnCar(uint256 carId) public payable {
        require(carExists(carId), "Car does not exist.");
        Car storage car = cars[carId];
        require(!car.available, "Car is already available.");
        require(msg.sender == owner, "Only the contract owner can perform this action.");
        
        car.available = true;
    }
    
    function carExists(uint256 carId) internal view returns (bool) {
        return bytes(cars[carId].make).length > 0;
    }
}
