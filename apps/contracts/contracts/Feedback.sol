//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ISemaphore.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface ERC721 {
    function balanceOf(address owner) external view returns (uint balance);
}

contract Feedback is Ownable{

    struct Agenda {
        address owner; // 생성자
        string title; // 제목
        string description; // 부제목
        uint256 deadline; // 데드라인
        uint256 agreeCollected; // 좋아요
    }

    error Feedback__UserAlreadyExists();

    event NewFeedback(uint feedback);
    event NewUser(bytes32 username, uint identifyCommitment);
    event CreateGroup(uint groupId, address indexed creator);

    ISemaphore public semaphore;
    address public nftAddress;
    address[] public adminAddressesArray;
    uint256 public numberOfAgendas = 0;

    mapping(uint256 => Agenda) public agendas;
    mapping(address => bool) public adminAddresses; // 관리자 계정을 저장하는 매핑
    mapping(address => mapping(bytes32 => uint)) private users;

    constructor(address _semaphoreAddress, address _nftAddress) {
        semaphore = ISemaphore(_semaphoreAddress);
        nftAddress = _nftAddress;
        adminAddresses[msg.sender] = true;
        adminAddressesArray.push(msg.sender);
    }

    function getAdminAddressList() external view returns(address[] memory) {
        return adminAddressesArray;
    }

    /// @dev Access modifier for Admin-only functionality
    modifier onlyAdmin() {
        require(adminAddresses[msg.sender]);
        _;
    }

    function createGroup(address _owner, string memory _title, string memory _description, uint256 _deadline, uint _groupId) external onlyAdmin {
        Agenda storage agenda = agendas[numberOfAgendas];
        require(agenda.deadline < block.timestamp, "The deadline should be a date in the future.");
        agenda.owner = _owner;
        agenda.title = _title;
        agenda.description = _description;
        agenda.deadline = _deadline;
        agenda.agreeCollected = 0;

        numberOfAgendas++;

        semaphore.createGroup(_groupId, 20, address(this)); // 20 : 머클트리 depth
        emit CreateGroup(_groupId, address(this));
    }

    function joinGroup(uint _groupId, uint _identityCommitment, bytes32 _username) external {
        ERC721 nftContract = ERC721(nftAddress);
        require(nftContract.balanceOf(msg.sender) > 0, "you dont have NFT"); // NFT를 보유하고 있지 않을 시 join 불가
        if (users[msg.sender][_username] != 0) { // 하나의 계정으로 한번만 join 가능
            revert Feedback__UserAlreadyExists();
        }

        semaphore.addMember(_groupId, _identityCommitment);

        users[msg.sender][_username] = _identityCommitment;

        emit NewUser(_username, _identityCommitment);
    }

    function sendFeedback(
        uint _groupId,
        uint _feedback,
        uint _merkleTreeRoot,
        uint _nullifierHash,
        uint[8] calldata _proof
    ) external {
        semaphore.verifyProof(_groupId, _merkleTreeRoot, _feedback, _nullifierHash, _groupId, _proof);
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
        require(!adminAddresses[_address], "Address is already an admin");
        adminAddresses[_address] = true;
        adminAddressesArray.push(_address);
    }

    /// @dev Removes a admin address
    function removeAdminAddress(address _address) external onlyOwner {
        require(adminAddresses[_address], "Address is not an admin");
        adminAddresses[_address] = false;

        // Remove from the array
        for (uint i = 0; i < adminAddressesArray.length; i++) {
            if (adminAddressesArray[i] == _address) {
                adminAddressesArray[i] = adminAddressesArray[adminAddressesArray.length - 1];
                adminAddressesArray.pop();
                break;
            }
        }
    }
}
