// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Step 02: Menambahkan tempat penyimpanan aset (mapping) dan penghitung jumlah aset
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

    // Tempat penyimpanan utama: ID Aset => Data Aset
    mapping(uint256 => Asset) private assets;

    // Penghitung berapa banyak aset yang sudah didaftarkan
    uint256 public totalAssets;
}
