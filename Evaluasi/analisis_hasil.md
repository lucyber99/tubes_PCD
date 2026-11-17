# Analisis Hasil Pengujian & Alasan Berhasil/Gagal

1. Kenapa Metode Bisa Berhasil?
* Pemisahan Teks dan Latar Belakang Lebih Bersih:
  Khusus untuk kondisi GELAP dan KONTRAS RENDAH, metode binerisasi berhasil memperjelas batas antara goresan tinta dan kertas. Makanya struktur visualnya jadi lebih mirip aslinya (SSIM mendekati 1) dan OCR bisa baca hurufnya dengan jauh lebih gampang.
* Perbaikan Posisi Lewat Koreksi Perspektif: 
  Pada kasus PERSPEKTIF MIRING, proses transformasi sudut berhasil meluruskan baris tulisan. Ini ngefek banget karena Tesseract OCR butuh teks yang posisinya horizontal lurus (--psm 6) supaya tidak salah baca.

2. Kenapa Metode Bisa Gagal atau Kurang Optimal?
* Filter Klasik Kurang Ampuh untuk Gambar Buram (Blur): 
  Pas diuji ke gambar BURAM, konversi grayscale atau binerisasi biasa ternyata tidak cukup buat balikin ketajaman pinggiran huruf yang sudah pecah. Akibatnya, filter ini malah bikin goresan tipis terputus atau nambahin *noise* latar, bikin nilai WER melonjak.
* Kelemahan Thresholding Global di Cahaya Tidak Merata:
  Kalau ada bayangan gelap di bagian tertentu foto, metode binerisasi global kadang nangkep bayangan itu sebagai blok hitam (dianggap teks), sehingga OCR jadi salah baca (hallucination).
* Karakteristik Tulis Tangan yang Berbeda-beda:
  Tesseract dari dasarnya memang dibikin buat teks cetak komputer (*machine-printed*). Jadi waktu dipakai buat baca tulisan tangan manusia yang bentuk hurufnya sambung-sambung dan ketebalannya beda-beda, wajar kalau nilai error-nya (WER) masih agak tinggi meskipun gambarnya udah dibersihin.
