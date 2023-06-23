import { formatBytes32String } from "ethers/lib/utils"
import { FEEDBACK_CONTRACT , WALLET } from './config'
async function joinGroup() {
    console.log(await FEEDBACK_CONTRACT.groupId())
    const groupId = "19"
    const transaction = await FEEDBACK_CONTRACT.connect(WALLET).createGroup(groupId);
    const receipt = await transaction.wait();
    console.log('receipt',receipt)
    console.log(await FEEDBACK_CONTRACT.groupId())
}

joinGroup()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
