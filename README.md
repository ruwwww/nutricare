# NutriCare

Aplikasi mobile (Flutter + Supabase) untuk tracking gizi mahasiswa ITS. TEKBER FP 2026.

## Setup
```bash
flutter pub get
cp .env.example .env   # isi SUPABASE_URL & SUPABASE_PUBLISHABLE_KEY (jangan di-commit)
flutter run
```

## Struktur
- `lib/core/` — config Supabase, theme
- `lib/features/{auth,tracking,consultation,profile}/` — per fitur
- `supabase/migrations/` — skema SQL (database & ERD)
