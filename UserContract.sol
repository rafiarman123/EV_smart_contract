// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

// Creating an interface to interact with the ChargingStation contract [5] [6]
interface StationInterface {
    function getAdmin() external view returns (address);
    function getMinimumDeposit() external view returns (uint256);
    function getElectricityCost() external view returns (uint256);
}

contract UserContract {
    // Import interface to interact with the deployed ChargingStation contract [5] [6]
    StationInterface stationContract;

    // Addresses of user and the admin
    address public user;
    address public admin;

    // Start and end values to track electricity consumption
    uint256 start;
    uint256 end;

    // Enum to represent the current status
    enum ContractStatus {
        DEPLOYED,
        DEPOSITED,
        CHARGING,
        AWAITING_PAYMENT,
        INACTIVE
    }

    // Set status to DEPLOYED after initialization
    ContractStatus public status = ContractStatus.DEPLOYED;

    // Constructor will run when someone deploys the contract [1]
    // _stationAddress: Address of the deployed ChargingStation contract

    constructor(address _stationAddress) {
        
        // Setting the user to the address of the user deploying this contract
        user = msg.sender;
        
        // Create stationContract to interact with the deployed ChargingStation contract
        stationContract = StationInterface(_stationAddress);
        
        // Get address of the admin from ChargingStation contract
        admin = stationContract.getAdmin();
    }

    // Function to make a deposit to the contract [7]
    function makeDeposit() public payable {
        
        // Make sure only the user is able to make a deposit
        require(
            msg.sender == user,
            "Only the creator of this contract can make a deposit."
        );

        // Make sure that the contract is currently in DEPLOYED status
        require(
            status == ContractStatus.DEPLOYED,
            "You have already made a deposit for this contract."
        );

        // Make sure that the deposit amount exceeds the minimum deposit
        require(
            msg.value >= stationContract.getMinimumDeposit(),
            "Amount is less than the minimum deposit amount."
        );

        // Set the status to DEPOSITED
        status = ContractStatus.DEPOSITED;
    }

    // Function to start the charging process
    function startCharging() public returns (bool success) {
        
        // Make sure only the user can start charging
        require(
            msg.sender == user,
            "Only the user who has deployed the contract can start charging."
        );

        // Make sure the contract is currently in DEPOSITED status
        require(
            status == ContractStatus.DEPOSITED,
            "You have not made a deposit or the charging is complete."
        );

        // Read the amount of electricity tracked at the start of the process
        // In a real app this needs to be programmed, for demonstration purposes we fix a fictional amount
        start = 287456;

        // Set the status to CHARGING
        status = ContractStatus.CHARGING;

        // In case all of the above statements are successful, return true and start charging
        return true;
    }

    // Function to stop the charging process
    function endCharging() public returns (bool success) {
        
        // Make sure only the user can stop charging
        require(
            msg.sender == user,
            "Only the user who has deployed the contract can end charging."
        );

        // Make sure that the contract is currently in CHARGING status
        require(
            status == ContractStatus.CHARGING,
            "You can only end the charging process if you are currently charging."
        );

        // Set the status to AWAITING_PAYMENT
        status = ContractStatus.AWAITING_PAYMENT;

        // Call the completeTransaction function (defined below)
        // This function will send the proper amount of ETH to the user and admin
        
        require(
            completeTransaction(),
            "An error occurred during the transaction."
        );

        // Set the status to INACTIVE
        status = ContractStatus.INACTIVE;

        // Self destruct this contract [7]
        selfdestruct(payable(msg.sender));

        // In case all of the above statements are successful, return true
        return true;
    }

    // Function to complete the transaction (transfer charging cost to the admin and remaining deposit to the user)
    function completeTransaction() internal returns (bool success) {
        
        // Read the amount of electricity tracked at the start of the process
        // In a real app this needs to be programmed, for demonstration purposes we fix a fictional amount
        end = 287516;

        // Call the endCharging function from the ChargingStation contract and obtain the electricityUsed
        uint256 electricityUsed = end - start;

        // Calculate the total cost of the charging process
        uint256 totalCost = electricityUsed * stationContract.getElectricityCost();

        // Make sure that deposit is enough to pay the cost
        require(
            address(this).balance >= totalCost,
            "Cost exceeded the deposit."
        );

        // Send the totalCost to the admin [7]
        require(
            payable(admin).send(totalCost),
            "Failed to transfer funds."
        );

        // Send the remaining deposit back to the user [7]
        require(
            payable(user).send(address(this).balance - totalCost),
            "Failed to return deposit."
        );

        // In case all of the above statements are successful, return true
        return true;
    }
}
