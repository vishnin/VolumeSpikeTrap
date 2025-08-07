# VolumeSpikeTrap

VolumeSpikeTrap is a smart contract that tracks a decrease in balance by more than a certain amount of Eth (in our case 0.1 Eth) for a given address.

---

## Objectives

- Monitors the ETH balance decrease of a specific wallet.

- Triggers a response when the balance decrease exceeds a given threshold (in our case, 0.1 Eth).

- Uses the collect() / shouldRespond() interface.

- Integrates with the notification contract to handle responses.

---

## Contracts

### VolumeSpikeTrap.sol

- Compares the balance of the current block to the balance of the previous block.
- If the reduction exceeds the `thresholdDecrease', `true` is returned.

---

### LogAlertReceiver.sol

- LogAlertReceiver calls the logAnomaly function, passing a message string.
- When the function is called, it generates an Alert event that logs the transmitted message to the blockchain.

---

## Compile & Setup

1. ## Compile Contracts via Foundry 
```
forge create src/VolumeSpikeTrap.sol:VolumeSpikeTrap \
  --rpc-url https://ethereum-hoodi-rpc.publicnode.com \
  --private-key 0x...
  --broadcast 
```
```
forge create src/LogAlertReceiver.sol:LogAlertReceiver \
  --rpc-url https://ethereum-hoodi-rpc.publicnode.com \
  --private-key 0x...
  --broadcast
```
2. ## Update drosera.toml 
```
[traps.mytrap]
path = "out/VolumeSpikeTrap.sol/VolumeSpikeTrap.json"
response_contract = "<LogAlertReceiver address>"
response_function = "logAnomaly(string)"
```
3. ## Apply changes 
```
DROSERA_PRIVATE_KEY=0x... drosera apply
```

---

## Test the Trap

- Send more than the specified balance reduction threshold ETH from target address on Ethereum Hoodi testnet.
- Wait 1–3 blocks.
- In the Drosera dashboard, check that shouldRespond = true.

---

## Extensions

- Track ERC-20 balances in addition to native ETH,

- Chain multiple traps using a unified collector.

---

## Author

Author: Cryptotransparent

Created: 28 July 2025


