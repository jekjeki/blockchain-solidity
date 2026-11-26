# Step 05 — Mendaftarkan & Membaca Aset (`registerAsset` & `getAsset`)

Di tahap ini smart contract kita sudah mulai **"hidup"** — peserta sudah bisa mendaftarkan aset pertama ke blockchain dan mengecek datanya kembali di Remix IDE.

## Analogi Mudah
- **`registerAsset`** = **Mengisi formulir aset baru dan memasukkannya ke lemari loker**, lalu menambah hitungan `totalAssets` dan menulis catatan di buku mutasi (`emit AssetRegistered`).
- **`getAsset`** = **Mengintip isi loker** berdasarkan nomor ID untuk melihat siapa pemiliknya dan apa statusnya saat ini.

## Yang Baru Ditambahkan
Lihat file lengkapnya di [AssetRegistry.sol](./AssetRegistry.sol).

```solidity
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
```

## Penjelasan Per Bagian
| Bagian | Penjelasan Sederhana |
| :--- | :--- |
| `calldata` | Lokasi memori khusus untuk parameter input `external` yang sifatnya read-only — lebih hemat gas daripada `memory`. |
| `external` | Fungsi dirancang untuk dipanggil dari luar kontrak (misalnya dari Remix IDE, wallet, atau frontend web). |
| 3 baris `require(...)` | Validasi input: ID tidak boleh duplikat, nama tidak boleh kosong, dan ID harus > `0`. |
| `owner: msg.sender` | Orang yang mendaftarkan aset otomatis tercatat sebagai pemilik pertama. |
| `status: AssetStatus.Available` | Setiap aset baru otomatis berstatus awal `Available` (`0`). |
| `emit AssetRegistered(...)` | Memicu event agar pendaftaran tercatat permanen di log transaksi blockchain. |
| `view` pada `getAsset` | Menandakan fungsi ini **hanya membaca data** (tidak mengubah isi blockchain), sehingga gratis saat dipanggil dari luar. |
| `assetExists(_assetId)` | Modifier "satpam" dari Step 04 — kalau ID aset belum ada, langsung muncul pesan `"Aset tidak ditemukan"`. |

---
⬅️ Sebelumnya: [Step 04: Modifier](../04-modifier/README.md) | ➡️ Lanjut ke [Step 06: Transfer & Update Status (Final)](../06-transfer-dan-update-status/README.md)
