// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Step 01: Menentukan kerangka kontrak, daftar status (enum), dan bentuk data aset (struct)
contract AssetRegistry {
    enum AssetStatus {
        Available,   // 0 - Aset tersedia
        InUse,       // 1 - Aset sedang dipakai
        Maintenance, // 2 - Aset sedang diperbaiki
        Retired      // 3 - Aset sudah tidak digunakan / dipensiunkan
    }

    struct Asset {
        uint256 id;
        string name;
        string category;
        address owner;
        AssetStatus status;
        bool exists;
    }
}
