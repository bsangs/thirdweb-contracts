# IAccountFactory









## Methods

### accountImplementation

```solidity
function accountImplementation() external view returns (address)
```

Returns the address of the Account implementation.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### createAccount

```solidity
function createAccount(address admin, bytes _data) external nonpayable returns (address account)
```

Deploys a new Account for admin.



#### Parameters

| Name | Type | Description |
|---|---|---|
| admin | address | undefined |
| _data | bytes | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| account | address | undefined |

### getAccountsOfSigner

```solidity
function getAccountsOfSigner(address signer) external view returns (address[] accounts)
```

Returns all accounts on which a signer has (active or inactive) permissions.



#### Parameters

| Name | Type | Description |
|---|---|---|
| signer | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| accounts | address[] | undefined |

### getAddress

```solidity
function getAddress(address adminSigner, bytes data) external view returns (address)
```

Returns the address of an Account that would be deployed with the given admin signer.



#### Parameters

| Name | Type | Description |
|---|---|---|
| adminSigner | address | undefined |
| data | bytes | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### getAllAccounts

```solidity
function getAllAccounts() external view returns (address[])
```

Returns all accounts created on the factory.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address[] | undefined |

### onSignerAdded

```solidity
function onSignerAdded(address signer) external nonpayable
```

Callback function for an Account to register its signers.



#### Parameters

| Name | Type | Description |
|---|---|---|
| signer | address | undefined |

### onSignerRemoved

```solidity
function onSignerRemoved(address signer) external nonpayable
```

Callback function for an Account to un-register its signers.



#### Parameters

| Name | Type | Description |
|---|---|---|
| signer | address | undefined |



## Events

### AccountCreated

```solidity
event AccountCreated(address indexed account, address indexed accountAdmin)
```

Emitted when a new Account is created.



#### Parameters

| Name | Type | Description |
|---|---|---|
| account `indexed` | address | undefined |
| accountAdmin `indexed` | address | undefined |

### SignerAdded

```solidity
event SignerAdded(address indexed account, address indexed signer)
```

Emitted when a new signer is added to an Account.



#### Parameters

| Name | Type | Description |
|---|---|---|
| account `indexed` | address | undefined |
| signer `indexed` | address | undefined |

### SignerRemoved

```solidity
event SignerRemoved(address indexed account, address indexed signer)
```

Emitted when a new signer is added to an Account.



#### Parameters

| Name | Type | Description |
|---|---|---|
| account `indexed` | address | undefined |
| signer `indexed` | address | undefined |



