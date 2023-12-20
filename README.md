# InkWanderers

## Tautan Aplikasi InkWanderers
https://install.appcenter.ms/orgs/pbp-kelompok-f05/apps/inkwanderers/distribution_groups/everyone

### Anggota Kelompok:
- Kevin Gilbert Sinaga (2206826053)
- Muhamad Rifqi (2206081433)
- Nabiel Ahmad Ardhityo (2206083331)
- Narendra Dzulqarnain (2206081881)
- Rafael Bismo Dewandaru (2206824666)

### Cerita aplikasi yang diajukan serta manfaatnya
Melalui website ini, user dapat dengan mudah menyusun daftar buku yang ingin mereka baca, yang memungkinkan mereka mengatur dan merencanakan bacaan mereka dengan lebih baik. User dapat menggunakan bookmark untuk mencatat buku-buku yang menarik minat mereka. Kemampuan untuk menambahkan buku ke dalam collection dengan cepat juga memberikan kemudahan bagi user. User dapat menjelajahi berbagai buku dalam katalog dengan mudah, menemukan buku yang menarik, dan langsung menambahkannya ke dalam collection mereka. Modul review juga memberikan user kesempatan untuk berbagi pendapat mereka tentang buku yang telah mereka baca, membantu user lain dalam memilih buku yang sesuai dengan minat mereka. Ini juga memperkaya pengalaman membaca dengan memungkinkan user berinteraksi dengan komunitas pembaca yang lebih besar. <br />
<br />
Batasan collection maksimal 10 buku adalah pengingat penting untuk tetap fokus pada buku-buku yang benar-benar menjadi prioritas. Ini membantu user untuk mengelola waktunya dengan lebih baik dan menjaga collection mereka agar tetap relevan dengan preferensi mereka. Modul bookmark memberikan kemudahan bagi user untuk menandai buku-buku yang ingin mereka pinjam atau baca di masa depan, tanpa harus menyimpan semuanya di collection. Ini mempermudah perencanaan bacaan mereka dan membantu mereka mengingat judul-judul yang menarik hati. Secara keseluruhan, website ini memberikan alat yang bermanfaat bagi user untuk mengatur dan memaksimalkan pengalaman membaca mereka, berbagi ulasan dan rekomendasi dengan sesama user, serta menjadikan proses pemilihan dan membaca buku lebih efisien dan memuaskan.<br />


### Daftar modul yang diimplementasikan beserta pembagian kerja anggota
1. Modul untuk membuat role, baik role user dan admin (Rifqi)
    - Dapat register sebagai user atau admin
    - Setiap pengguna memiliki profile mereka sendiri yang menampilkan details
    - Setiap pengguna dapat mengganti password mereka
2. Modul katalog buku yang bisa ditambahkan oleh admin dan diakses oleh user (Rafael)
    - Admin dapat menambahkan sebanyak-banyaknya buku ke dalam katalog
    - Admin dapat menghapus buku dari katalog
    - Admin dapat melihat katalog buku
    - User dapat melihat buku yang berada di katalog dan menambahkannya ke collection
    - Setiap buku dalam katalog dapat dilihat reviewnya

3. Modul collection list buku yang dibaca oleh role user (Gilbert)
    - User dapat menambahkan buku dari katalog kedalam collection
    - Buku yang ada di dalam collection user akan hilang dari katalog
    - User dapat melihat buku yang sudah mereka tambahkan ke collection dan memberikan reviews
    - Maksimal buku yang ada di dalam collection user adalah 10
    
4. Modul review buku yang telah dibaca (Rendra)
    - Setelah user memasukkan buku ke dalam collection buku, user dapat mengembalikan buku dari collection user kembali ke katalog dan menambahkan review untuk buku tersebut
    - Menampilkan semua review dari sebuah buku

5. Modul bookmark buku oleh user (Nabiel)
    - Bookmark digunakan untuk menandakan buku yang ingin dipinjam oleh user apabila isi buku di dalam collection sudah mencapai 10
    - Buku yang sudah di bookmark oleh user lain tetap dapat terlihat di katalog

### Role atau peran pengguna beserta deskripsinya
Terdapat dua jenis role dalam website ini, yaitu:<br />
User<br />
Masing-masing user dapat memiliki satu collection dan bookmark. User dapat menambahkan buku ke dalam collection atau bookmark. Bookmark dapat berisi buku sebanyak-banyaknya, sedangkan collection hanya dapat berisi maksimal sepuluh buku.<br />
<br />
Admin<br />
Seorang admin dapat menambahkan buku baru ke dalam katalog yang sudah tersedia.<br />

### Alur pengintegrasian dengan web service Proyek Tengah Semester
1. Pembuatan Fungsi di Django:
- Membuat fungsi baru di website Django yang mampu menerima request dan mengirimkan respon ke aplikasi mobile. 
- Fungsi ini harus dapat menangani method GET dan POST, kemudian web service Django dapat memberikan response dalam format JSON, yang akan mudah diolah oleh aplikasi Flutter.

2. Integrasi dengan Flutter:
- Pada aplikasi Flutter, tambahkan request ke URL fungsi yang telah dibuat di Django. 
- Menggunakan library seperti http untuk memudahkan proses fetching JSON dari endpoint Django. 
- Proses request ini dilakukan secara asynchronous untuk memastikan aplikasi mobile tetap responsif selama menunggu data dari server.

3. Memanfaatkan Library dan Endpoint:
- Menggunakan library untuk proses login dan logout pada aplikasi Flutter.
- Beberapa endpoint dari projek uts dapat digunakan kembali dalam pengintegrasian, selain itu juga dapat menambahkan beberapa endpoint baru untuk mendukung beberapa fitur tambahan apabila diperlukan.

4. Pengolahan Data di Flutter:
- Buat berkas baru pada Flutter yang berfungsi dan bertanggung jawab untuk mengambil data secara asinkron dari backend Django.
- Fungsi yang ada pada berkas tersebut bisa dipanggil dari luar berkas dan mengembalikan data, menjadikannya jembatan antara aplikasi dan backend.

5. Implementasi di Widget Flutter:
- Panggil fungsi fetch dari berkas baru yang sudah dibuat tersebut ke dalam widget yang relevan. Hal ini digunakan agar data JSON yang diambil dapat diolah dan ditampilkan sesuai kebutuhan aplikasi.

6. Debugging:
- Setelah mengintegrasikan semua bagian, lakukan debugging untuk memastikan bahwa semua fitur bekerja dengan baik.
- Melakukan penyesuaian dan perbaikan apabila ditemukan error atau masalah lainnya.


### Tautan berita acara
https://univindonesia-my.sharepoint.com/:x:/g/personal/kevin_gilbert_office_ui_ac_id/EXv78SYTZdVFivlZgB7CC4wBFJuM_ScYlUxaB7S972hjJw?e=8kGXCy
