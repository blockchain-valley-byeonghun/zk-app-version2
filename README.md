<p align="center">
    <h1 align="center">
        Anonymous Community v2 
    </h1>
    <p align="center">ZK application of Semaphore demo page</p>
</p>

---
## Deployed contracts
|           | Mumbai                                                                                                    |
|-----------|-----------------------------------------------------------------------------------------------------------|
| Semaphore | [0x40A6...609f](https://mumbai.polygonscan.com/address/0x40A6ad127e3b4C8077af42a2437cCbd3cdC7609f#events) |
| Feedback  | [0x08f9...a240](https://mumbai.polygonscan.com/address/0x08f92493Bc1D38BA68e0566D624Db4bea779a240)        |
| SBT        | [0x5Dcb...75b8](https://mumbai.polygonscan.com/address/0x5DcbBd68C0d5e5aB118735786B187A132b7775b8) |                                                                                                    |
| GroupId   | 12                                                                                                        |
---
## How to deploy Feedback contract on Polygon Mumbai Test Network  
```shell
cp .env.example .env 
yarn
cd apps/contract
yarn
yarn deploy --semaphore 0x40A6ad127e3b4C8077af42a2437cCbd3cdC7609f --group 11 --network mumbai
```
- `$ cp .env.example .env`
  - copy example env file for deploy Feedback contracts
- first yarn
  - install packages on root directory
- second yarn
  - install packages on contract directory
---
## Change abi after deploy Feedback contract ( do this on root directory )
```shell
yarn copy:contract-artifacts
yarn dev
```



