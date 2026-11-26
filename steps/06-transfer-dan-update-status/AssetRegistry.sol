// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Step 06 (Final): Menambahkan transferAsset dan updateAssetStatus
contract AssetRegistry {
    enum AssetStatus {
        Available,
        InUse,
        Maintenance,
        Retired
    }

    struct Asset {
        uint256 id;
        string name;
        string category;
        address owner;
        AssetStatus status;
        bool exists;
    }

    mapping(uint256 => Asset) private assets;
    uint256 public totalAssets;

    event AssetRegistered(
        uint256 indexed assetId,
        string name,
        string category,
        address indexed owner
    );

    event AssetTransferred(
        uint256 indexed assetId,
        address indexed previousOwner,
        address indexed newOwner
    );

    event AssetStatusUpdated(
        uint256 indexed assetId,
        AssetStatus oldStatus,
        AssetStatus newStatus
    );

    modifier assetExists(uint256 _assetId) {
        require(assets[_assetId].exists, "Aset tidak ditemukan");
        _;
    }

    modifier onlyAssetOwner(uint256 _assetId) {
        require(assets[_assetId].owner == msg.sender, "Hanya pemilik aset yang diizinkan");
        _;
    }

    function registerAsset(
        uint256 _assetId,
        string calldata _name,
        string calldata _category
    ) external {
        require(!assets[_assetId].exists, "ID aset sudah terdaftar");
        require(bytes(_name).length > 0, "Nama aset wajib diisi");
        require(_assetId > 0, "ID aset harus lebih dari 0");

        assets[_assetId] = Asset({
            id: _assetId,
            name: _name,
            category: _category,
            owner: msg.sender,
            status: AssetStatus.Available,
            exists: true
        });

        totalAssets += 1;

        emit AssetRegistered(_assetId, _name, _category, msg.sender);
    }

    function transferAsset(uint256 _assetId, address _newOwner)
        external
        assetExists(_assetId)
        onlyAssetOwner(_assetId)
    {
        require(_newOwner != address(0), "Alamat pemilik baru tidak valid");
        require(_newOwner != assets[_assetId].owner, "Pemilik baru sama dengan pemilik saat ini");

        address previousOwner = assets[_assetId].owner;
        assets[_assetId].owner = _newOwner;

        emit AssetTransferred(_assetId, previousOwner, _newOwner);
    }

    function updateAssetStatus(uint256 _assetId, AssetStatus _newStatus)
        external
        assetExists(_assetId)
        onlyAssetOwner(_assetId)
    {
        AssetStatus oldStatus = assets[_assetId].status;
        require(oldStatus != _newStatus, "Status aset sudah sama");

        assets[_assetId].status = _newStatus;

        emit AssetStatusUpdated(_assetId, oldStatus, _newStatus);
    }

    function getAsset(uint256 _assetId)
        external
        view
        assetExists(_assetId)
        returns (
            uint256 id,
            string memory name,
            string memory category,
            address owner,
            AssetStatus status
        )
    {
        Asset memory a = assets[_assetId];
        return (a.id, a.name, a.category, a.owner, a.status);
    }
}
