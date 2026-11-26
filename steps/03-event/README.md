# Step 03 — Pencatatan Riwayat (`event`)

Salah satu keunggulan utama blockchain untuk manajemen aset adalah **audit trail** (jejak riwayat yang transparan dan tidak bisa dihapus). Di Solidity, fitur itu dibuat memakai **`event`**.

## Analogi Mudah
- **`event`** = **Buku mutasi / nota transaksi resmi**. Setiap kali aset didaftarkan, dipindahtangankan, atau berubah status, kontrak akan "mencetak catatan" ke dalam log blockchain. Aplikasi frontend (web/dashboard) bisa membaca catatan ini untuk menampilkan histori aset.

## Yang Baru Ditambahkan
Lihat file lengkapnya di [AssetRegistry.sol](./AssetRegistry.sol).

```solidity
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
```

## Penjelasan Per Bagian
| Bagian | Penjelasan Sederhana |
| :--- | :--- |
| `AssetRegistered` | Dicatat saat aset baru berhasil didaftarkan (mencatat ID, nama, kategori, dan pemilik awal). |
| `AssetTransferred` | Dicatat saat aset dipindahkan dari pemilik lama (`previousOwner`) ke pemilik baru (`newOwner`). |
| `AssetStatusUpdated` | Dicatat saat status aset berubah dari `oldStatus` ke `newStatus`. |
| Kata kunci `indexed` | Menandai kolom penting agar mudah difilter/dicari di riwayat blockchain (misalnya: *"cari semua histori untuk aset ID 101"* atau *"cari semua aset milik alamat 0x123..."*). Maksimal 3 parameter `indexed` per event. |

---
⬅️ Sebelumnya: [Step 02: Mapping & State](../02-mapping-dan-state/README.md) | ➡️ Lanjut ke [Step 04: Modifier](../04-modifier/README.md)
