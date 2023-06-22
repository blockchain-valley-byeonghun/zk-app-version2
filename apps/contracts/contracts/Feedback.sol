//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ISemaphore.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface ERC721 {
    function balanceOf(address owner) external view returns (uint balance);
}

contract Feedback is Ownable{
    error Feedback__UserAlreadyExists();

    event NewFeedback(uint feedback);
    event NewUser(bytes32 username, uint identifyCommitment);
    event CreateGroup(uint groupId, address indexed creator);

    ISemaphore public semaphore;
    address public nftAddress;
    uint public groupId;

    mapping(address => bool) public adminAddresses; // 관리자 계정을 저장하는 매핑
    mapping(address => mapping(bytes32 => uint)) private users;

    constructor(address _semaphoreAddress, uint _groupId, address _nftAddress) {
        semaphore = ISemaphore(_semaphoreAddress);
        groupId = _groupId;
        nftAddress = _nftAddress;
        semaphore.createGroup(groupId, 20, address(this));
    }

    /// @dev Access modifier for Admin-only functionality
    modifier onlyAdmin() {
        require(adminAddresses[msg.sender]);
        _;
    }

    function createGroup(uint _groupId) external onlyAdmin {
        semaphore.createGroup(_groupId, 20, address(this)); // 20 : 머클트리 depth
        emit CreateGroup(_groupId, address(this));
    }

    function joinGroup(uint _identityCommitment, bytes32 _username) external {
        ERC721 nftContract = ERC721(nftAddress);
        require(nftContract.balanceOf(msg.sender) > 0, "you dont have NFT"); // NFT를 보유하고 있지 않을 시 join 불가
        if (users[msg.sender][_username] != 0) { // 하나의 계정으로 한번만 join 가능
            revert Feedback__UserAlreadyExists();
        }

        semaphore.addMember(groupId, _identityCommitment);

        users[msg.sender][_username] = _identityCommitment;

        emit NewUser(_username, _identityCommitment);
    }

    function sendFeedback(
        uint _feedback,
        uint _merkleTreeRoot,
        uint _nullifierHash,
        uint[8] calldata _proof
    ) external {
        semaphore.verifyProof(groupId, _merkleTreeRoot, _feedback, _nullifierHash, groupId, _proof);
        emit NewFeedback(_feedback);
    }

    function getUserInfo(bytes32 _username) external view returns(uint){
        require(users[msg.sender][_username] != 0, "there is no user");
        return users[msg.sender][_username];
    }

    function setNftAddress(address _newNftAddress) external onlyOwner {
        require(_newNftAddress != address(0), "new address is the zero address");
        nftAddress = _newNftAddress;
    }

    /// @dev Adds a admin address
    function addAdminAddress(address _address) external onlyOwner {
        adminAddresses[_address] = true;
    }

    /// @dev Removes a admin address
    function removeAdminAddress(address _address) external onlyOwner {
        adminAddresses[_address] = false;
    }
}
