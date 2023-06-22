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
| Feedback  | [0xA774...4d2D](https://mumbai.polygonscan.com/address/0xA774d68D14ec82911173A62E45a416a061654d2D)        |
| SBT        | [0x6d7D...5403](https://mumbai.polygonscan.com/address/0x6d7DEFc10BA387497fc5e8B2C03Ae13ef8bd5403)        |                                                                                                    |
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



