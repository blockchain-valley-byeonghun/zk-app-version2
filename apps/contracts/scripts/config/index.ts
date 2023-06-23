import { ethers } from 'ethers';
import { ABI } from '../../build/contracts/contracts/Feedback.sol/Feedback.json'
import dotenv from 'dotenv';
import { resolve } from "path";

dotenv.config({ path: resolve(__dirname, "../../../../.env") })
export const FEEDBACK_CA = process.env.FEEDBACK_CONTRACT_ADDRESS;

export const MUMBAI_JSON_RPC_URL = "https://rpc-mumbai.maticvigil.com/";

export const JSON_RPC_PROVIDER = new ethers.providers.JsonRpcProvider(MUMBAI_JSON_RPC_URL)

// @ts-ignore
export const FEEDBACK_CONTRACT = new ethers.Contract(FEEDBACK_CA, ABI, JSON_RPC_PROVIDER);

export const SIGN_KEY = process.env.POLYGON_PRIVATE_KEY

// @ts-ignore
export const WALLET = new ethers.Wallet(SIGN_KEY, JSON_RPC_PROVIDER)
