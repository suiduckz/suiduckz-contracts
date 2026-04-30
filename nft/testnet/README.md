# Testnet Baby Suiduckz NFT

A Testnet NFT contract for the Suiduckz ecosystem on Sui Testnet.

⚠️ This NFT has **no monetary value** and is for testing purposes only (Testnet).

---

## Features

- Governance (voting)
- Future rewards
- Exclusive access to future programs (e.g. Suiduckz AI Agents)


---

## Contract Overview

### Main Structs
- `TestnetBabySuiduckzNFT`
- `Whitelist`
- `Supply`
- `AdminCap`

---

## Functions

### Mint
Mint NFT (whitelist only, 1 per wallet)

```move
mint(whitelist, supply, ctx)

