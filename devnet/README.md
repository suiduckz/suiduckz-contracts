# Devnet Baby Suiduckz NFT

A Devnet NFT contract for the Suiduckz ecosystem.

⚠️ This NFT has **no monetary value** and is for testing purposes only (Devnet).

---

## Features

- Governance (voting)
- Future rewards
- Exclusive access to future programs (e.g. Suiduckz AI Agents)


---

## Contract Overview

### Main Structs
- `DevnetBabySuiduckzNFT`
- `Whitelist`
- `Supply`
- `AdminCap`

---

## Functions

### Mint
Mint NFT (whitelist only, 1 per wallet)

```move
mint(whitelist, supply, ctx)
