# Safe Remote Purchase Smart Contract

This is a safe remote purchase smart contract, designed for secure and safe trading between a buyer and a seller. The contract allows for the secure transfer of funds and ensures that both parties fulfill their obligations during the trading process.

## Deployment
The seller is responsible for deploying the smart contract with a payment of 2x the price of the product being sold. This payment is stored in the contract and acts as a security deposit.

## Confirm Purchase
Once the smart contract has been deployed, the buyer can call the ``confirmPurchase`` function with 2x the price of the product. This confirms the purchase and releases the funds to the seller.

## Confirm Receive
After the buyer receives the product, they can call the ``confirmReceive`` function. This function returns half of the buyer's paid amount back to them.

## Pay Seller
Once the buyer has confirmed receipt of the product, the seller can call the ``paySeller`` function to receive their 3x the price of the product.

## Abort Trading
The seller can also choose to abort the trading process by calling the ``abortTrading`` function. This can only be done when the contract is in the created state and will return the seller's payment back to them.

## Security
This smart contract has been secured against reentrancy attacks to ensure the safety of funds and the integrity of the trading process.
