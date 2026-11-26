# Workshop Smart Contract Solidity — Asset Management (`AssetRegistry`)

Repository panduan praktik workshop **Smart Contract Solidity (`^0.8.20`)** dengan studi kasus **Manajemen Aset (`AssetRegistry`)**.  
Materi disusun **bertahap per section** dari nol sampai kontrak utuh, memakai bahasa sederhana dan analogi sehari-hari agar mudah diikuti langsung di **Remix IDE**.

---

## Struktur Folder (Tree)

```text
blockchain-solidity/
├── README.md                              # Panduan utama workshop & skenario demo Remix IDE
├── LICENSE                                # Lisensi MIT
├── contracts/
│   └── AssetRegistry.sol                  # Kontrak final utuh (siap deploy di Remix IDE)
└── steps/                                 # Materi bertahap (tiap tahap bisa langsung di-compile)
    ├── 01-struct-dan-enum/
    │   ├── README.md                      # Penjelasan enum AssetStatus & struct Asset
    │   └── AssetRegistry.sol
    ├── 02-mapping-dan-state/
    │   ├── README.md                      # Penjelasan mapping penyimpanan & totalAssets
    │   └── AssetRegistry.sol
    ├── 03-event/
    │   ├── README.md                      # Penjelasan event & indexed (log mutasi)
    │   └── AssetRegistry.sol
    ├── 04-modifier/
    │   ├── README.md                      # Penjelasan modifier (satpam validasi)
    │   └── AssetRegistry.sol
    ├── 05-register-dan-get/
    │   ├── README.md                      # Penjelasan fungsi registerAsset & getAsset
    │   └── AssetRegistry.sol
    └── 06-transfer-dan-update-status/
        ├── README.md                      # Penjelasan fungsi transferAsset & updateAssetStatus
        └── AssetRegistry.sol
```

---

## Alur Workshop per Section

Setiap langkah menambahkan **satu konsep baru** di atas langkah sebelumnya:

| Step | Materi | Analogi Sederhana | Panduan | File Solidity |
| :---: | :--- | :--- | :---: | :---: |
| **01** | `enum` & `struct` | Pilihan dropdown status & kartu data aset | [Baca](./steps/01-struct-dan-enum/README.md) | [Kode](./steps/01-struct-dan-enum/AssetRegistry.sol) |
| **02** | `mapping` & `totalAssets` | Lemari loker bernomor ID & papan penghitung | [Baca](./steps/02-mapping-dan-state/README.md) | [Kode](./steps/02-mapping-dan-state/AssetRegistry.sol) |
| **03** | `event` & `indexed` | Buku mutasi permanen & transparan di blockchain | [Baca](./steps/03-event/README.md) | [Kode](./steps/03-event/AssetRegistry.sol) |
| **04** | `modifier` & `require` | Satpam penjaga gerbang (cek aset ada & pemilik sah) | [Baca](./steps/04-modifier/README.md) | [Kode](./steps/04-modifier/AssetRegistry.sol) |
| **05** | `registerAsset` & `getAsset` | Mendaftarkan barang baru & mengecek detail barang | [Baca](./steps/05-register-dan-get/README.md) | [Kode](./steps/05-register-dan-get/AssetRegistry.sol) |
| **06** | `transferAsset` & `updateAssetStatus` | Serah terima kepemilikan & ubah kondisi barang | [Baca](./steps/06-transfer-dan-update-status/README.md) | [Kode](./steps/06-transfer-dan-update-status/AssetRegistry.sol) |

> **Mau langsung lihat kontrak jadinya?** Buka [`contracts/AssetRegistry.sol`](./contracts/AssetRegistry.sol).

---

## Daftar Kode Status Aset (`AssetStatus`)

Di Solidity, `enum` disimpan sebagai angka mulai dari `0`. Saat mengisi parameter `_newStatus` di Remix IDE, gunakan angka berikut:

| Angka | Nama Status | Arti |
| :---: | :--- | :--- |
| `0` | `Available` | Aset tersedia (status awal otomatis saat didaftarkan) |
| `1` | `InUse` | Aset sedang digunakan |
| `2` | `Maintenance` | Aset sedang dalam perbaikan |
| `3` | `Retired` | Aset sudah dipensiunkan / tidak dipakai lagi |

---

## Panduan Praktik Langsung di Remix IDE

Tidak perlu install apa pun di laptop — cukup pakai browser:

1. Buka **[https://remix.ethereum.org](https://remix.ethereum.org)**.
2. Di panel kiri (*File Explorer*), buat file baru bernama `AssetRegistry.sol`.
3. Copy-paste kode dari step yang sedang dibahas (atau langsung dari [`contracts/AssetRegistry.sol`](./contracts/AssetRegistry.sol)).
4. Buka menu **Solidity Compiler** (ikon S), pilih versi **`0.8.20`** (atau lebih baru `0.8.x`), lalu klik **Compile AssetRegistry.sol**.
5. Buka menu **Deploy & Run Transactions**:
   - **Environment**: pilih `Remix VM` (simulasi lokal gratis, dapat 10 akun dummy).
   - Klik tombol **Deploy**.

### Skenario Demo untuk Workshop

Coba jalankan urutan berikut di panel **Deployed Contracts**:

1. **Daftarkan aset pertama** (pakai **Account 1**):
   - Panggil `registerAsset`:
     - `_assetId`: `1`
     - `_name`: `"Laptop ThinkPad X1"`
     - `_category`: `"IT Equipment"`
   - Cek `totalAssets` → hasilnya `1`.
   - Cek `getAsset(1)` → muncul nama, kategori, `owner` = Account 1, dan `status` = `0` (`Available`).
   - Buka terminal bawah Remix (ikon panah pada transaksi) → lihat log event **`AssetRegistered`**.

2. **Ubah status aset** (masih pakai **Account 1**):
   - Panggil `updateAssetStatus(1, 1)` (ubah ke `InUse`).
   - Cek `getAsset(1)` → `status` sekarang berubah menjadi `1`.

3. **Tes keamanan `onlyAssetOwner`** (ganti ke **Account 2** di dropdown *Account*):
   - Coba panggil `updateAssetStatus(1, 2)` pakai Account 2.
   - **Hasil yang diharapkan**: Transaksi **gagal (revert)** dengan pesan `"Hanya pemilik aset yang diizinkan"`. Ini membuktikan `modifier` melindungi aset dari orang lain.

4. **Serah terima aset** (kembali ke **Account 1**):
   - Copy alamat **Account 2**, lalu panggil `transferAsset(1, <alamat_Account_2>)`.
   - Cek `getAsset(1)` → `owner` sekarang sudah berpindah ke **Account 2** dan event **`AssetTransferred`** tercatat di log.

5. **Buktikan kepemilikan baru** (ganti ke **Account 2**):
   - Panggil `updateAssetStatus(1, 2)` (`Maintenance`) pakai Account 2 → sekarang **berhasil** karena Account 2 sudah menjadi pemilik sah.
