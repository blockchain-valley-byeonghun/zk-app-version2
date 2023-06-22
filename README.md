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
| Feedback  | [0xA774...4d2D](https://mumbai.polygonscan.com/address/0x451E092b3F13ADA09e9c72fE57328e97aFe23184)        |
| SBT        | [0x6d7D...5403](https://mumbai.polygonscan.com/address/0x5DcbBd68C0d5e5aB118735786B187A132b7775b8)        |                                                                                                    |
| GroupId   | 18                                                                                                        |
---
## How to deploy Feedback contract on Polygon Mumbai Test Network  
```shell
cp .env.example .env 
yarn
cd apps/contract
yarn
yarn deploy --semaphore 0x40A6ad127e3b4C8077af42a2437cCbd3cdC7609f --group 14 --network mumbai
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

## How to connect on RemixIDE
```shell
remixd -s ./ --remix-ide https://remix.ethereum.org
```



