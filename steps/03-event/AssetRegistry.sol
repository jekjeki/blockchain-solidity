// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Step 03: Menambahkan event untuk mencatat riwayat transaksi secara transparan di blockchain
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

    // Event: log permanen setiap ada pendaftaran, pemindahan, atau perubahan status aset
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
}
