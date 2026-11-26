# Step 01 — Struktur Data Aset (`enum` & `struct`)

Sebelum menyimpan atau memindahkan aset, kita perlu sepakat dulu: **"Bentuk data satu aset itu seperti apa?"**

## Analogi Mudah
- **`enum AssetStatus`** = **Pilihan dropdown status** yang sudah dikunci (supaya tidak ada typo seperti `"tersedia"`, `"Ready"`, atau `"Rusak"` yang beda-beda).
- **`struct Asset`** = **Kartu inventaris / formulir aset** yang berisi kolom-kolom informasi penting dari sebuah barang (misalnya Laptop Kantor, Proyektor, Mobil Operasional).

## Kode di Tahap Ini
Lihat file lengkapnya di [AssetRegistry.sol](./AssetRegistry.sol).

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AssetRegistry {
    enum AssetStatus {
        Available,   // 0
        InUse,       // 1
        Maintenance, // 2
        Retired      // 3
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
```

## Penjelasan Per Bagian
| Bagian | Penjelasan Sederhana |
| :--- | :--- |
| `// SPDX-License-Identifier: MIT` | Menyatakan lisensi kode (standar wajib di Solidity agar tidak muncul warning). |
| `pragma solidity ^0.8.20;` | Menentukan versi compiler Solidity (`0.8.20` ke atas, masih dalam seri `0.8.x`). |
| `enum AssetStatus` | Daftar pilihan status tetap. Di balik layar, Solidity menyimpannya sebagai angka: `0 = Available`, `1 = InUse`, `2 = Maintenance`, `3 = Retired`. |
| `uint256 id` | Nomor unik aset (angka bulat non-negatif, misalnya `101`). |
| `string name` | Nama aset, misalnya `"MacBook Pro M3"`. |
| `string category` | Kategori aset, misalnya `"Laptop"` atau `"Kendaraan"`. |
| `address owner` | Alamat wallet pemilik / penanggung jawab aset saat ini. |
| `AssetStatus status` | Kondisi aset saat ini (mengambil salah satu nilai dari `enum AssetStatus`). |
| `bool exists` | Penanda `true/false` apakah aset dengan ID tersebut benar-benar sudah terdaftar. |

> **Kenapa perlu `bool exists`?**  
> Di Solidity, kalau kita cek data yang belum pernah disimpan, nilainya bukan `null`, melainkan nilai kosong bawaan (`0`, `""`, `false`). Kolom `exists` memudahkan kita membedakan mana aset yang memang belum terdaftar (`false`) dan mana yang sudah terdaftar (`true`).

---
⬅️ [Kembali ke Panduan Utama](../../README.md) | ➡️ Lanjut ke [Step 02: Mapping & State](../02-mapping-dan-state/README.md)
