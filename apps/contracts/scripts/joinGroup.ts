import { Identity } from "@semaphore-protocol/identity";
import { formatBytes32String } from "ethers/lib/utils"
import { FEEDBACK_CONTRACT , WALLET } from './config'

async function joinGroup() {
    const user1 = new Identity('nickname35')
    console.log('user1',user1, user1.commitment)
    const transaction = await FEEDBACK_CONTRACT.connect(WALLET).joinGroup(user1.commitment, formatBytes32String("nickname35"));
    const receipt = await transaction.wait();
    console.log('receipt',receipt)
}

joinGroup()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
