// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Step 04: Menambahkan modifier (satpam/aturan pengecekan sebelum fungsi dijalankan)
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

    // Modifier 1: Pastikan aset dengan ID tersebut benar-benar ada
    modifier assetExists(uint256 _assetId) {
        require(assets[_assetId].exists, "Aset tidak ditemukan");
        _;
    }

    // Modifier 2: Pastikan yang memanggil fungsi adalah pemilik sah aset tersebut
    modifier onlyAssetOwner(uint256 _assetId) {
        require(assets[_assetId].owner == msg.sender, "Hanya pemilik aset yang diizinkan");
        _;
    }
}
