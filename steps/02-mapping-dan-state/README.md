# Step 02 — Penyimpanan Data (`mapping` & State Variable)

Di Step 01 kita sudah bikin bentuk "kartu aset"-nya (`struct Asset`). Sekarang kita butuh **tempat menyimpannya** di dalam blockchain.

## Analogi Mudah
- **`mapping(uint256 => Asset)`** = **Lemari loker bernomor**. Kalau kita tahu nomor lokernya (`assetId`, misalnya `101`), kita bisa langsung membuka loker itu dan mengambil data `Asset`-nya tanpa perlu mencari satu per satu.
- **`uint256 public totalAssets`** = **Papan penghitung** yang mencatat berapa total aset yang sudah pernah didaftarkan.

## Yang Baru Ditambahkan
Lihat file lengkapnya di [AssetRegistry.sol](./AssetRegistry.sol).

```solidity
mapping(uint256 => Asset) private assets;
uint256 public totalAssets;
```

## Penjelasan Per Bagian
| Bagian | Penjelasan Sederhana |
| :--- | :--- |
| `mapping(uint256 => Asset)` | Struktur key-value: kunci berupa angka `uint256` (ID aset), isinya berupa `struct Asset`. Pencarian datanya sangat cepat dan hemat gas. |
| `private` pada `assets` | Data tidak langsung dibaca sembarangan lewat getter otomatis, melainkan nanti kita sediakan fungsi khusus `getAsset()` yang mengecek dulu apakah asetnya ada. *(Catatan: data di blockchain tetap transparan, `private` hanya mengatur akses di level kode kontrak).* |
| `uint256 public totalAssets` | Karena `public`, Solidity otomatis membuatkan tombol/fungsi baca `totalAssets()` saat di-deploy di Remix IDE. Nilai awalnya otomatis `0`. |

---
⬅️ Sebelumnya: [Step 01: Struct & Enum](../01-struct-dan-enum/README.md) | ➡️ Lanjut ke [Step 03: Event](../03-event/README.md)
