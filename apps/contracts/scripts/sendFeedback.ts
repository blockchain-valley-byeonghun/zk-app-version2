import { Group } from "@semaphore-protocol/group";
import { Identity } from "@semaphore-protocol/identity";
import { generateProof } from "@semaphore-protocol/proof";
import { formatBytes32String } from "ethers/lib/utils"
import { BigNumber } from "ethers"
import { FEEDBACK_CONTRACT , WALLET } from './config'

async function sendFeedback() {
    const groupId = "19"
    const group = new Group(groupId)
    const user1 = new Identity('nickname35')
    console.log('user1',user1, user1.commitment)
    const wasmFilePath = '../build/snark-artifacts/semaphore.wasm'
    const zkeyFilePath = '../build/snark-artifacts/semaphore.zkey'
    console.log(wasmFilePath, zkeyFilePath)
    const feedback = BigNumber.from(formatBytes32String('nickname35')).toString()
    group.addMember(user1.commitment)

    // const { proof, merkleTreeRoot, nullifierHash } = await generateProof(
    //     user1,
    //     group,
    //     groupId,
    //     feedback,
    //     {
    //         wasmFilePath,
    //         zkeyFilePath
    //     }
    // );

    const proof = ['20317619879313146189548342196090052429198546174921292524608668736281097613766', '9167664011772941526004540828369765500766290395873435828899133942980881774075', '15382658862489460201918223564725301058510757583872646504421243860722528219558', '17245371317662587503777978227742337023477179541722642036121697130031594667220', '7619238279848651609478591477935970538231169377362123778941073167832346516467', '647806287586757586251002302197985533087822449773465202217020956851999779478', '18501077130301130199759890541757800340338026239092590141885211206203381690513', '13774237207519685136712243233416645963783698213829416370629278872492682724635']
    const merkleTreeRoot = '8924868678917552526374663740009590351522393338978972544322368463196008793536'
    const nullifierHash = '16577151813406463883804209347319236031316293117735187041545499231385468619752'

    console.log(proof, typeof proof)
    console.log(merkleTreeRoot, typeof merkleTreeRoot)
    console.log(nullifierHash, typeof nullifierHash)

    try{
        const transaction1 = await FEEDBACK_CONTRACT.connect(WALLET).sendFeedback(feedback, merkleTreeRoot, nullifierHash, proof);
        const receipt1 = await transaction1.wait();
        console.log('receipt',receipt1)
    }catch (e){
        console.error('e >>>>', e)
    }
}

sendFeedback()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
