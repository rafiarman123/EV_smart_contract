/*

Instruction for code implementation:
1. Open Remix (http://remix.ethereum.org) in web browser and make sure you have MetaMask connected and two wallets on Kovan testnet with enough Ether to execute transactions
    If you use another testnet you have to change the address of chainlink interface (line 28 CharginStation)
2. Copy + paste both contracts in seperate files in Remix (same folder)
3. Compile ChargingStation.sol
4. Deploy ChargingStation.sol: Select 'Injected Web3' as environment, select account of admin, at contract select 'ChargingStation', 
                                deploy contract (confirm in MetaMask)
5. Compile UserContract.sol
6. Deploy UserContract.sol: Select account of user, at contract select UserContract, copy address of ChargingStation and paste in the field next to deploy button,
                                deploy contract (confirm in MetaMask)
7. Make a deposit: In value, insert an ETH/GWEI/Wei amount (make sure it's higher than minimum deposit and account of user is selected), under Deployed Contracts open
                                UserContract and execute 'makeDeposit' (confirm in MetaMask)
8. Complete transaction: Execute 'startCharging' and 'endCharging' function (confirm in MetaMask). Process is complete




Sources used to write the contracts:

General:
Inspiration for two-contract structure: Niya, S. R., Schüpfer, F., Bocek, T., & Stiller, B. (2018). 
A Peer-to-peer Purchase and Rental Smart Contract-based Application (PuRSCA). it-Information Technology, 60(5-6), 307-320.

freeCodeCamp.org: Solidity, Blockchain, and Smart Contract Course – Beginner to Expert Python Tutorial
https://www.youtube.com/watch?v=M576WGiDBdQ
https://github.com/smartcontractkit/full-blockchain-solidity-course-py

Solidityslang.org: Solidity
https://docs.soliditylang.org/en/develop/index.html

Specific:
[1] Tutorialspoint.com: Solidity - Constructor
https://www.tutorialspoint.com/solidity/solidity_constructors.htm

[2] Code copied from Patrick C. Alpha (Part of freCodeCamp tutorial)
https://github.com/PatrickAlphaC/fund_me/blob/main/FundMe.sol
https://docs.chain.link/docs/get-the-latest-price/

[3] Chainlink.org: Ethereum Data Feeds
https://docs.chain.link/docs/ethereum-addresses/

[4] Code adapted from Patrick C. Alpha (Part of freCodeCamp tutorial)
https://github.com/PatrickAlphaC/fund_me/blob/main/FundMe.sol

[5] Solidity by example: Interface
https://solidity-by-example.org/interface/

[6] Cryptomarketpool.com: Interface in Solidity smart contracts
https://cryptomarketpool.com/interface-in-solidity-smart-contracts/

[7] Solidity by example: Payable
https://solidity-by-example.org/payable/

[8] Solidity by example: Self Destruct
https://solidity-by-example.org/hacks/self-destruct/

*/