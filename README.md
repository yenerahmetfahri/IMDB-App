# IMDB-App
TMDB API ile geliştirilmiştir.

# MainPage
- Tek bir tableView ve Header olarak da collection view şeklinde tasarladım. 
- Hem tableView hem de collectionView ViewModel mantığı ile iki farklı class tarafından besleniyor. (UpcomingTableView ve NowPlayingCollectionView)
- Sayfada refresh page ve pagination özellikleri bulunmakta. (dikkat çekmesi açısından biraz fazla çekmek gerekir pagination için.
- Tasarımda kullanılan fontlar eklendi. (SF Pro Text ve SF Pro Display)
- Tasarımda bulanan tarih formatları ile servisten gelen eşleşmediği için extension eklendi.
- Enum ve String Extension kullanıldı.
- Detay sayfasına yönlendirme yapıldı.

# Detail Page
- ScrollView içerisinde stackView şeklinde tasarladım.
- Açıklama metni uzunluğunca scroll edilebilir bir sayfa.

# Eksikler
- Detaylı bir Network Layer, gerek duymadım elimde hazır olanları da kullanmak istemedim, zaten her şirketin kendine has bir Network Layer'ı oluyor, ona ayak uydurmak zorunda kalıyoruz.
- Servisten gelen posterler ile tasarımda bulunan imageView alanları çok örtüşmediği için imagelerin görüntüleri bir tık kötü gelebilir.
- Toolbar yapmadım, navigation item kullandım.
- PageControl kullanmadım.
- ImageSlider ı kütüphaneyle yaptım önce, sonra belki kendim yapmam daha doğrudur diye geri çevirdim, o arada pageControl gitmiş :)

# Kullanılan Kütüphaneler
- Alamofire
- KingFisher
- Kütüphaneler pod kullanılarak değil, Swift Package Manager kullanılarak eklenmiştir.

# İletişim

Proje hakkında ya da herhangi bir konuda benimle iletişime geçmek için: 

yenerahmetfahri@gmail.com

adresini kullanabilirsiniz.
