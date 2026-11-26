# Step 04 — Aturan Validasi & Keamanan (`modifier`)

Sebelum membuat fungsi untuk mengubah atau memindahkan aset, kita harus pasang aturan keamanan terlebih dulu. Di Solidity, aturan yang dipakai berulang kali dibungkus dalam **`modifier`**.

## Analogi Mudah
- **`modifier`** = **Satpam di depan pintu ruangan**. Sebelum seseorang boleh masuk menjalankan fungsi (misalnya memindahkan aset atau mengubah status), satpam akan memeriksa dua hal:
  1. `assetExists`: *"Apakah barang dengan ID ini benar-benar terdaftar?"*
  2. `onlyAssetOwner`: *"Apakah kamu pemilik sah barang ini?"*
- Kalau tidak lolos syarat, transaksi otomatis ditolak (`revert`) dan pesan error-nya ditampilkan.

## Yang Baru Ditambahkan
Lihat file lengkapnya di [AssetRegistry.sol](./AssetRegistry.sol).

```solidity
modifier assetExists(uint256 _assetId) {
    require(assets[_assetId].exists, "Aset tidak ditemukan");
    _;
}

modifier onlyAssetOwner(uint256 _assetId) {
    require(assets[_assetId].owner == msg.sender, "Hanya pemilik aset yang diizinkan");
    _;
}
```

## Penjelasan Per Bagian
| Bagian | Penjelasan Sederhana |
| :--- | :--- |
| `require(kondisi, "pesan")` | Pengecekan wajib. Jika `kondisi` bernilai `false`, eksekusi langsung berhenti dan memunculkan `"pesan"`. |
| `msg.sender` | Alamat wallet orang yang sedang memanggil / mengirim transaksi ke smart contract saat itu. |
| `_;` | Tanda placeholder: *"jika syarat di atas lolos, lanjutkan menjalankan isi fungsi utamanya di sini."* |

> **Kenapa pakai `modifier`, bukan tulis `require` berulang-ulang di tiap fungsi?**  
> Supaya kode lebih rapi, tidak duplikat, dan gampang dibaca. Nanti kita cukup tempelkan `assetExists(_assetId)` dan `onlyAssetOwner(_assetId)` di bagian header fungsi.

---
⬅️ Sebelumnya: [Step 03: Event](../03-event/README.md) | ➡️ Lanjut ke [Step 05: Register & Get Asset](../05-register-dan-get/README.md)
