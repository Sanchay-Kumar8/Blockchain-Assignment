## Foundry

## HOW TO RUN TEST CASES ->

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Implementation basic explaination ->
```
I have created 3 smart contracts which are MyToken.sol, ProductNft.sol, ProductStore.sol. 
MyToken.sol is an implementation of ERC20 token standard.
ProductNft.sol is an implementation of a nft in a form of basic structure of a bill for a product i.e. 
{
    "name": "My Product",
    "description": "This image shows the test product",
    "price": 100,
    "image": "https://ipfs.io/ipfs/QmZzBdKF7sQX1Q49CQGmreuZHxt9sVB3hTc3TTXYcVZ7jC"
}

the image here is just a dummy image kept to keep the product look lively.

ProductStore.sol is the main implementation where owner of the contract can create listing of products which is a structure containing 3 field i.e. Name of the product, Price of the product and ifSold to know if the product has been sold or not and the ownerOfProduct which initially will be the msg.sender who is listing the product.
When a customer will use the function buyProduct it will check if the customer has enough ERC20 tokens associated with its acc if not the transaction will revert. If the customer has enough tokens then the function will check if the tokenId(Product Id) is valid or not, if the tokenId is not valid the function will revert, if the tokenId is correct it will check if the product is already sold or not. If the product is still for sale then the transaction will take place. Where we will use the transferFrom function of ERC20 token standard to transfer erc20 tokens from the customer's address to the contract's address. After successful transaction the NFT will be minted to the customer's address.

```

### TEST CASES WRITTEN IN test folder