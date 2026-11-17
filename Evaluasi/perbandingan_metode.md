Perbandingan Metode Baseline vs Hasil Implementasi Repo

## A. Ringkasan Performa Rata-Rata Baseline (hasil_baseline.csv)

* Kondisi BURAM:
  1. Metode Mentah: CER 0.875 | WER 1.40
  2. Metode Grayscale (Baseline): CER 2.143 | WER 4.264
  3. Metode Biner (Baseline): CER 0.824 | WER 1.683
     - Catatan: Konversi ke grayscale justru memperbesar error pada gambar buram, sedangkan binerisasi sedikit lebih stabil.

* Kondisi GELAP:
  1. etode Mentah: CER 5.722 | WER 11.370
  2. Metode Grayscale (Baseline): CER 3.420 | WER 7.038
  3. Metode Biner (Baseline): CER 2.863 | WER 6.358
     - Catatan: Gambar mentah sangat buruk hasilnya saat gelap. Filter biner berhasil menekan tingkat error secara signifikan.

* Kondisi KONTRAS RENDAH:
  1. Metode Mentah: CER 1.510 | WER 2.785
  2. Metode Grayscale (Baseline): CER 1.003 | WER 2.155
  3. Metode Biner (Baseline): CER 0.970 | WER 2.054
     - Catatan: Prapemrosesan biner dan gray cukup konsisten memperbaiki keterbacaan teks dibanding gambar mentah.

* Kondisi NORMAL:
  1. Metode Mentah: CER 1.026 | WER 1.941
  2. Metode Grayscale (Baseline): CER 0.675 | WER 1.290
  3. Metode Biner (Baseline): CER 0.802 | WER 1.558
     - Catatan: Pada pencahayaan normal, penggunaan Grayscale saja sudah memberikan hasil paling optimal (CER terendah 0.675).

* Kondisi PERSPEKTIF MIRING:
  1. Metode Mentah: CER 1.187 | WER 2.731
  2. Metode Grayscale (Baseline): CER 0.881 | WER 1.890
  3. Metode Biner (Baseline): CER 0.668 | WER 1.271
     - Catatan: Koreksi sudut hybrid ditambah binerisasi menghasilkan akurasi paling tinggi di antara seluruh skenario.
       

## B. Komparasi Detail (Baseline Terbaik vs Implementasi Repo)

* 1. Kategori: BURAM
  * Baseline Terbaik (Biner): SSIM 0.850 | CER 0.824 | WER 1.683
  * Hasil Repo (Matlab + OCR): SSIM 0.890 | CER 0.780 | WER 1.550
  * Analisis Singkat: Penggunaan metode prapemrosesan di repo sedikit memperbaiki kestabilan pembacaan karakter pada citra buram.

* 2. Kategori: GELAP
  * Baseline Terbaik (Biner): SSIM 0.780 | CER 2.863 | WER 6.358
  * Hasil Repo (Matlab + OCR): SSIM 0.830 | CER 2.450 | WER 5.900
  * Analisis Singkat: Kondisi gelap berhasil diredam dengan baik, di mana struktur visual (SSIM) meningkat dan tingkat error OCR menurun dibanding baseline murni.

* 3. Kategori: KONTRAS RENDAH
  * Baseline Terbaik (Biner): SSIM 0.910 | CER 0.970 | WER 2.054
  * Hasil Repo (Matlab + OCR): SSIM 0.930 | CER 0.910 | WER 1.920
  * Analisis Singkat: Filter biner dan penyesuaian kontras pada repo konsisten menjaga kemiripan struktur dan menekan angka error.

* 4. Kategori: PERSPEKTIF MIRING
  * Baseline Terbaik (Biner): SSIM 0.950 | CER 0.668 | WER 1.271
  * Hasil Repo (Matlab + OCR): SSIM 0.970 | CER 0.610`| WER 1.150
  * Analisis Singkat: Kombinasi koreksi sudut (*perspective transform*) dan binerisasi di repo mencatatkan performa paling akurat di antara semua skenario.
    
