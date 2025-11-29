# TaskHub - Full-Stack Task Management System

**Nama Lengkap:** Rizki Pandiwa

## Deskripsi Proyek
TaskHub adalah aplikasi manajemen tugas modern yang memungkinkan pengguna mengatur tugas pribadi lewat mobile dan web dalam satu ekosistem yang sama.

Repo ini adalah monorepo yang berisi tiga aplikasi utama:
- `taskhub-mobile` → Mobile 
- `taskhub-service` → Backend API
- `taskhub-web` →  Website 

## Programming Languages / Frameworks

| Bagian          | Teknologi                  | Versi      |
|-----------------|----------------------------|------------|
| **Mobile**      | Flutter                    | 3.39.0     |
| **Backend**     | Golang                     | 1.24.0     |
| **Web**         | Next.js                    | 16.0.5     |

## Libraries / Packages
 
### Flutter
1. **http ^1.1.0**  
   Dipilih karena ringan, stabil, dan gampang dipakai. Ideal untuk komunikasi REST API standar, mudah menangani response JSON, dan tidak menambah kompleksitas pada aplikasi.

2. **flutter_riverpod ^2.5.1**  
   Dipilih karena type safe, mudah ditest, dan scalable. Mendukung manajemen state lokal maupun global dengan arsitektur yang lebih rapi dibanding Provider biasa, sehingga pengembangan, debugging, dan testing state menjadi lebih mudah dan terstruktur.

### Golang
1. **gin-gonic/gin v1.11.0**  
   Dipilih karena ringan, cepat, dan mudah digunakan. Mempermudah routing, middleware, dan handling HTTP request/response, sehingga ideal untuk membangun REST API dengan performa tinggi.

2. **gorm.io/gorm v1.25.10**  
   ORM untuk Go. Mempermudah manipulasi database, query builder, dan migrasi schema tanpa harus menulis SQL mentah secara manual, tapi tetap fleksibel.

### Next.js (App Router)
1. **State bawaan React (useState, useEffect)**  
  Dipilih karena mempermudah manipulasi database tanpa menulis SQL mentah. Mendukung query builder, migrasi schema, dan tetap fleksibel untuk kebutuhan kompleks.


## Cara Menjalankan Aplikasi
**Penting**: Backend (taskhub-service) harus dijalankan terlebih dahulu sebelum mobile (taskhub_mobile) atau web (taskhub-web) agar API bisa diakses.

## taskhub-service (REST API)
Masuk ke folder project
```bash
  cd taskhub-service
```
Install dependencies
```bash
  go mod tidy
```
Copy file contoh env
```bash
  cp .env.example .env
```
Update data file .env
```bash
 Buka .env dan sesuaikan konfigurasi environment dengan setup lokal kamu (misal database, port, dll).
```

Start the server
```bash
 go run cmd/api/main.go
```

## taskhub-web (WEB)
Masuk ke folder project
```bash
  cd taskhub-web
```
Install dependencies
```bash
 npm install
```
Copy file contoh env.local
```bash
  cp .env.local.example .env.local
```
Update data file .env.local
```bash
 Buka .env.local dan sesuaikan Sesuaikan URL backend service (taskhub-service)
```
Start the server
```bash
 npm run dev
```


## taskhub_mobile (mobile)
Masuk ke folder project
```bash
  cd taskhub_mobile
```
Install dependencies
```bash
 flutter pub get
```
Copy file contoh env
```bash
  cp .env.example .env
```
Update data file .env
```bash
Buka .env dan sesuaikan Sesuaikan URL backend service (taskhub-service)
```
Start the server
```bash
 flutter run
```




