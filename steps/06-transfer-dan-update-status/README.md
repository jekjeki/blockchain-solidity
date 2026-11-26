# Step 06 — Serah Terima & Update Status Aset (`transferAsset` & `updateAssetStatus`)

Ini adalah tahap final yang melengkapi siklus hidup aset: **mendaftar → dipakai/dirawat → pindah tangan → pensiun**.

## Analogi Mudah
- **`transferAsset`** = **Berita acara serah terima aset**. Hanya pemilik sekarang (`onlyAssetOwner`) yang boleh memindahkan hak milik ke alamat wallet orang lain (`_newOwner`), dan tidak boleh dikirim ke alamat kosong (`address(0)`) atau ke diri sendiri.
- **`updateAssetStatus`** = **Memperbarui label kondisi barang** (misalnya dari `Available` ke `InUse`, lalu `Maintenance`, hingga `Retired`).

## Yang Baru Ditambahkan
Lihat file lengkapnya di [AssetRegistry.sol](./AssetRegistry.sol) (identik dengan kontrak final di [`contracts/AssetRegistry.sol`](../../contracts/AssetRegistry.sol)).

```solidity
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
```

## Penjelasan Per Bagian
| Bagian | Penjelasan Sederhana |
| :--- | :--- |
| `assetExists(_assetId)` & `onlyAssetOwner(_assetId)` | Dua satpam berurutan: cek dulu asetnya ada, lalu pastikan pemanggil transaksi adalah pemilik sah aset itu. |
| `_newOwner != address(0)` | Mencegah aset "terbuang" ke alamat kosong `0x0000...0000` (burn address) secara tidak sengaja. |
| `_newOwner != assets[_assetId].owner` | Mencegah transaksi sia-sia memindahkan aset ke pemilik yang sama. |
| `oldStatus != _newStatus` | Mencegah pemborosan gas jika status baru ternyata sama dengan status yang sekarang. |
| `AssetStatus _newStatus` | Saat mengisi di Remix IDE, masukkan angkanya: `0` = Available, `1` = InUse, `2` = Maintenance, `3` = Retired. |

---
⬅️ Sebelumnya: [Step 05: Register & Get Asset](../05-register-dan-get/README.md) | 🏠 [Kembali ke Panduan Utama & Demo Remix](../../README.md)
