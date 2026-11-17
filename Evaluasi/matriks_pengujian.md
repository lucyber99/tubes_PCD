Matriks Pengujian Validasi OCR & Citra

## 1. Data Uji & Variabel Gangguan (Noise)
Dalam pengujian ini, saya menggunakan dataset yang terdiri dari 10 sampel dokumen tulisan tangan (`HW001` - `HW010`). Masing-masing dokumen diuji dalam 5 kondisi gangguan yang berbeda:
1. NORMAL: Kondisi standar/asli sebagai acuan dasar.
2. BURAM: Ada efek *blur* atau kekaburan pada goresan tulisan.
3. GELAP: Kondisi pencahayaan rendah (low illumination).
4. KONTRAS RENDAH: Perbedaan warna antara tinta dan kertas sangat tipis.
5. PERSPEKTIF MIRING: Posisi foto miring, yang sebelumnya sudah saya koreksi pakai pendekatan hybrid (Auto + Manual).

## 2. Kondisi Citra yang Dibandingkan
Untuk melihat efektivitasnya, setiap gambar dengan gangguan di atas akan melalui 3 tahapan kondisi:
* Mentah: Gambar asli mentah tanpa proses apa pun.
* Gray (Grayscale): Gambar yang sudah diubah ke keabuan dan dinormalisasi.
* Biner (Black & White): Gambar hasil binerisasi klasik untuk memisahkan teks dan latar belakang.

## 3. Metrik Evaluasi yang Digunakan
Agar pengujiannya objektif, saya memakai 3 metrik utama ini:
1. CER (Character Error Rate): Menghitung persentase kesalahan pada tingkat karakter (huruf satu per satu).
2. WER (Word Error Rate): Menghitung persentase kesalahan pada tingkat kata secara keseluruhan.
3. SSIM (Structural Similarity Index): Mengukur kemiripan struktur visual, pencahayaan, dan kontras antara gambar hasil proses dengan gambar referensi `NORMAL` (rentang 0 sampai 1).
