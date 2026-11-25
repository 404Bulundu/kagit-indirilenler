# kagit-indirilenler

İndirilenler klasörünü **tek komutla** düzenler: PDF, ZIP/RAR/7Z, resim ve videoyu kendi klasörlerine ayırır. İstersen ay klasörleri de açar.
**Hiçbir dosya silinmez, yalnız taşınır.** Aynı adlı dosya varsa üzerine yazmaz, adının sonuna `(1)` ekler.

> Ücretsiz. Abone olmak şart değil.

## Nasıl kullanılır (Windows, PowerShell)
1. İndirilenler klasörünü aç.
2. Adres çubuğuna `powershell` yaz ve Enter'a bas, ya da görev çubuğundan PowerShell'i aç ve `cd Downloads` yaz.
3. `temizle.ps1` dosyasını bu klasöre koy.
4. Betik çalışmazsa (güvenlik engeli), yalnız bu pencere için izin ver:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   ```
5. **Önce dene** (hiçbir şey taşınmaz, ne olacağını gösterir):
   ```powershell
   .\temizle.ps1 -Dene
   ```
6. İyi görünüyorsa **gerçek komut**:
   ```powershell
   .\temizle.ps1
   ```
7. Ay klasörleri istersen (örn. `PDF\2026-11`):
   ```powershell
   .\temizle.ps1 -Tarih
   ```

## Hangi uzantı nereye
| Klasör | Uzantılar |
|---|---|
| PDF | pdf |
| Arşiv | zip, rar, 7z |
| Resim | jpg, jpeg, png, gif, webp, heic |
| Video | mp4, mov, mkv, avi |

Listede olmayan dosyalara dokunulmaz. Başka bir klasörü düzenlemek için: `.\temizle.ps1 -Klasor "D:\Belgeler" -Dene`

## Güvenlik
- Önce her zaman `-Dene` ile bak.
- Betik alt klasörlere girmez, yalnız klasörün en üstündeki dosyalara bakar.
- Kullanmadan önce kodu oku: tek dosya, kısa.

Lisans: MIT
