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
   Digunakan untuk komunikasi dengan API via HTTP. Ringan, stabil, dan mudah diintegrasikan ke seluruh aplikasi. Cocok untuk request REST standar maupun menangani response JSON.

2. **flutter_riverpod ^2.5.1**  
   State management modern yang type-safe dan mudah ditest. Mendukung manajemen state lokal maupun global dengan arsitektur yang lebih scalable dibanding Provider biasa.

### Golang
1. **gin-gonic/gin v1.11.0**  
   Web framework ringan dan cepat. Memudahkan routing, middleware, dan handling HTTP request/response dengan performa tinggi. Cocok untuk membangun REST API.

2. **gorm.io/gorm v1.25.10**  
   ORM untuk Go. Mempermudah manipulasi database, query builder, dan migrasi schema tanpa harus menulis SQL mentah secara manual, tapi tetap fleksibel.

### Next.js (App Router)
1. **State bawaan React (useState, useEffect)**  
   Aplikasi hanya CRUD sederhana, jadi state lokal sudah cukup. Tidak perlu library tambahan seperti Redux atau Zustand yang kompleks.


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




