A secure and gas-efficient **Merkle Airdrop** smart contract for distributing tokens to eligible users on the Stacks blockchain. This contract verifies user claims using **Merkle proofs**, ensures each address claims only once, and allows the contract owner to manage airdrop parameters.

---

## 📜 Features

- ✅ Merkle proof-based claim verification  
- 🔐 Admin-only controls (update Merkle root, deadline, ownership transfer)  
- 📆 Airdrop deadline enforcement  
- 📊 Tracks total tokens claimed and user participation  
- ❌ Prevents duplicate claims  
- 🧪 View-only functions for transparency  

---

## 🛠️ Contract Details

### Constants & Error Codes

| Constant               | Description                             |
|------------------------|-----------------------------------------|
| `ERR_ALREADY_CLAIMED`  | User has already claimed                |
| `ERR_INVALID_PROOF`    | Submitted Merkle proof is invalid       |
| `ERR_TRANSFER_FAILED`  | Token transfer failed                   |
| `ERR_NOT_OWNER`        | Caller is not the contract owner        |
| `ERR_AIRDROP_EXPIRED`  | Claim attempted after airdrop deadline  |

### Data Variables

| Variable       | Type           | Description                             |
|----------------|----------------|-----------------------------------------|
| `owner`        | `principal`    | Contract owner                          |
| `merkle-root`  | `buff(32)`     | Merkle root of eligible claims          |
| `deadline`     | `uint`         | Airdrop expiration block height         |
| `start-height` | `uint`         | Deployment block height                 |
| `total-claimed`| `uint`         | Total tokens claimed                    |

---

## 🚀 Usage

### 1. 📥 Claim Airdrop

```
(claim account amount proof)
account: Principal of the claimer

amount: Token amount user is eligible to claim

proof: Merkle proof (list of sibling hashes from leaf to root)

 Note: The claim function is incomplete in the current version and requires full implementation to:

Validate the Merkle proof

Prevent double claims

Transfer tokens
```

2. Admin Functions
```
(set-merkle-root new-root)
(set-deadline new-deadline)
(transfer-ownership new-owner)
Only callable by the owner:

set-merkle-root: Updates the root hash of the Merkle tree

set-deadline: Updates the block height at which the airdrop expires

transfer-ownership: Transfers admin control to another principal
```

3. Read-Only Functions
```
(get-merkle-root)
(get-deadline)
(get-total-claimed)
(get-owner)
(has-claimed user)
```
📦 Deployment Notes
Set initial merkle-root and deadline upon deployment.

start-height is initialized using deadline, which may be updated later.

Requires token transfer logic to be integrated (e.g., using SIP-010 ft-transfer?).

🧩 To Do
 Complete the claim function:

Validate proof

Prevent duplicates

Handle token transfers

 Integrate with SIP-010 token contracts

 Add unit tests

 Write deployment and claim scripts

