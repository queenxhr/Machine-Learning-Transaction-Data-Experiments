#download library arules untuk menggunakan fp growth
install.packages("arules")
install.packages("arulesViz")
install.packages("tidyr")
install.packages("plyr")

library(arules)
library(arulesViz)
library(readxl)
library(tidyr)
library(plyr)

read_excel("C:/Kuliah/3rd semester/Machine Learning/Data_Transaksi_Gabungan_Y.xlsx",col_names = FALSE) -> df

# Mengumpulkan nilai unik dari semua kolom dan menggabungkannya menjadi satu vektor
unique_values <- unique(unlist(df))

# Menampilkan hasil
View(unique_values)

# menghilangkan data yg NA
unik <- na.omit(unique_values)
unik <- sort(unik)
View(unik)

#Ubah menjadi data frame agar mudah dilihat
unik <- data.frame(unik)
View(unik)
df2 <- df

# Values to be replaced with NA
replace_values <-c("ANGKOT", "ATM", "CALCIUM ION", "FILM", "FOSFOR ANORGANIK", "HEMATOLOGI LENGKAP","GLAD AOE PEONY", "KOIN", "KURSI", "KOP", "MIN-BEE", "WARDAH", "TIKET", "CALUNG", "CILUNG","SUSU KENTANG DETERJEN PERQLATAN MANDI AIR")

for (col in names(df2)) {
  df2[[col]][df2[[col]] %in% replace_values] <- NA
}

View(df)
View(df2)

mapping <- c(
  "ACNES SEALING JELL" = "KRIM WAJAH",
  "ADEM SARI" = "MINUMAN KESEHATAN",
  "AGAR-AGAR STRAWBERRY" = "AGAR-AGAR",
  "AGAR - AGAR SWALLOW" = "AGAR-AGAR",
  "BUBUK AGAR - AGAR" = "AGAR-AGAR",
  "BUBUK PUDING" = "AGAR-AGAR",
  "AICE" = "ES KRIM",
  "BOBA SUNDAE" = "ES KRIM",
  "CHAMPINA" = "ES KRIM",
  "CHOCOLATE LUCKY SUNDAE" = "ES KRIM",
  "CORNETO MINI" = "ES KRIM",
  "CORNETTO" = "ES KRIM",
  "ES KRIM WALLS" = "ES KRIM",
  "ESKRIM" = "ES KRIM",
  "ICE CREAM" = "ES KRIM",
  "AIR BER-ION" = "MINUMAN ISOTONIK",
  "ISOPLUS COCO" = "MINUMAN ISOTONIK",
  "AIR CUP AQUA" = "AIR MINERAL GELAS",
  "AIR GELAS DUS" = "AIR MINERAL GELAS",
  "AQUA GELAS BOX" = "AIR MINERAL GELAS",
  "AQUA GELAS DUS" = "AIR MINERAL GELAS",
  "AIR KEMASAN BOTOL PRISTINE" = "AIR MINERAL BOTOL",
  "AIR MINERAL" = "AIR MINERAL BOTOL",
  "AIR MINERAL 1500" = "AIR MINERAL BOTOL",
  "AIR MINERAL 750" = "AIR MINERAL BOTOL",
  "AIR MINERAL CLEO" = "AIR MINERAL BOTOL",
  "AIR MINERALM JUS" = "AIR MINERAL BOTOL",
  "AQUA BOTOL" = "AIR MINERAL BOTOL",
  "AQUA GALON" = "AIR MINERAL GALON",
  "AIR GALON AQUA" = "AIR MINERAL GALON",
  "ALAT MASAK (PANCI" = "PANCI",
  "ALAT PEMBERSIH KLOSET" = "SIKAT KAMAR MANDI",
  "ALAT SIKAT GIGI" = "SIKAT GIGI",
  "ALPHALIBE" = "PERMEN",
  "ALPHELIEBE" = "PERMEN",
  "CHUPA CHUPS" = "PERMEN",
  "AMARYL M 30 TABLET" = "OBAT DIABETES",
  "APEL FUJI" = "APEL",
  "AYAM KRISPY" = "AYAM GORENG",
  "BAKSO KEJU" = "BAKSO",
  "BAKSO ORI" = "BAKSO",
  "BASO KEJU" = "BAKSO",
  "BASO ORI" = "BAKSO",
  "BASO URAT" = "BAKSO",
  "CEDEA BASO CUMI" = "BAKSO",
  "CEDEA BASO UDANG" = "BAKSO",
  "BATAGOR KUAH" = "BATAGOR",
  "BATERAI ABC" = "BATERAI",
  "BAYAM)" = "BAYAM",
  "BAYGON" = "OBAT NYAMUK",
  "BEAR BRAND" = "SUSU",
  "BEAR ORI 189ML" = "SUSU",
  "DAIRY MILK" = "SUSU",
  "DANCOW" = "SUSU",
  "DIAMOND STR" = "SUSU",
  "FF COCONUT TPK" = "SUSU",
  "FRISIAN FLAG" = "SUSU",
  "GREENFIELDS" = "SUSU",
  "HILO" = "SUSU",
  "INDOMILK" = "SUSU",
  "BAWANG" = "BAWANG MERAH",
  "BAWANG DAUN" = "DAUN BAWANG",
  "BENG BENG SHARE IT" = "KUE",
  "BENGBENG" = "KUE",
  "BENGBENG" = "KUE",
  "ASTOR" = "KUE",
  "CHOCOLATOS" = "KUE",
  "BERAS RAMOS" = "BERAS",
  "BEST WOK MIE" = "MIE INSTAN",
  "INDOMIE" = "MIE INSTAN",
  "BERNARD EASY BITE" = "MAKANAN ANJING",
  "BIHUN JAGUNG" = "BIHUN",
  "BINTANG" = "MINUMAN BERKARBONASI",
  "COCA-COLA" = "MINUMAN BERKARBONASI",
  "COCA COLA" = "MINUMAN BERKARBONASI",
  "FANTA" = "MINUMAN BERKARBONASI",
  "GREEN SANDS" = "MINUMAN BERKARBONASI",
  "BIORE" = "SABUN CUCI MUKA",
  "BETTER" = "BISKUIT",
  "BISKIES" = "BISKUIT",
  "BISKUIT REGAL" = "BISKUIT",
  "BISKUIT ROMA" = "BISKUIT",
  "BRIO POTATO" = "BISKUIT",
  "BRIO POTATO BISCUTIT" = "BISKUIT",
  "CHOCO PIE" = "BISKUIT",
  "GLICO POCKY" = "BISKUIT",
  "GO POTATO" = "BISKUIT",
  "HATARI" = "BISKUIT",
  "HELLO PANDA" = "BISKUIT",
  "GERY SALUT" = "BISKUIT",
  "BLASTER" = "PERMEN",
  "BLUE BAND" = "MARGARIN",
  "BODY LOTION" = "LOTION",
  "BON NORI" = "RUMPUT LAUT",
  "BONCABE" = "CABAI BUBUK",
  "BON CABE" = "CABAI BUBUK",
  "BUAH" = "APEL",
  "BUAH-BUAHAN (APEL" = "APEL",
  "BUAHVITA" = "JUS",
  "BUAVITA" = "JUS",
  "BUBUK PUDING" = "PUDING",
  "BUBUR AYAM INSTAN" = "BUBUR",
  "BUBUR AYAN" = "BUBUR",
  "BUBUR RASA AYAM" = "BUBUR",
  "BUBUR SOTO" = "BUBUR",
  "BUMBU DAPUR" = "BUMBU INSTAN",
  "BUMBU MAGIC" = "BUMBU INSTAN",
  "BUMBU NASI GORENG" = "BUMBU INSTAN",
  "BUMBU RACIK" = "BUMBU INSTAN",
  "BUMBU RACIK SAJIKU" = "BUMBU INSTAN",
  "BUMBU RACIK SERBAGUNA" = "BUMBU INSTAN",
  "BUMBU SASA" = "BUMBU INSTAN",
  "BUMBU TOMYUM" = "BUMBU INSTAN",
  "CADBURY" = "COKLAT",
  "CADBURY DAIRY MILK" = "COKLAT",
  "CHACHA" = "COKLAT",
  "CHIC CHOC" = "COKLAT",
  "COKELAT" = "COKLAT",
  "COKI-COKI" = "COKLAT",
  "COKLAT CADBURY" = "COKLAT",
  "COKLAT DAN MINUMAN DINGIN" = "COKLAT",
  "COKLAT DAN SUSU" = "COKLAT",
  "DARK CHOCOLATTE" = "COKLAT",
  "DELFI CHICCHOC" = "COKLAT",
  "DELFI TAKE IT" = "COKLAT",
  "CEDEA CHIKUWA" = "CHIKUWA",
  "CEDEA SALMON BALL" = "SALMON BALL",
  "CEDEA STICK KEPITING" = "STICK KEPITING",
  "CELANA PENDEK" = "CELANA",
  "CEMCEM" = "POPCORN",
  "CHEETOS" = "SNACK",
  "CHIKI" = "SNACK",
  "CHIKI(2)" = "SNACK",
  "CHITATO" = "SNACK",
  "CITATO" = "SNACK",
  "CRACKERS" = "SNACK",
  "DORITOS" = "SNACK",
  "FISH SNACK WRAP" = "SNACK",
  "FITBAR" = "SNACK",
  "FUZO" = "SNACK",
  "GARUDA PILUS" = "SNACK",
  "HAPPY TOS" = "SNACK",
  "J&J PIATTOS" = "SNACK",
  "JAPOTA" = "SNACK",
  "CEREAL" = "SEREAL",
  "DETERJEN" = "SABUN CUCI PAKAIAN",
  "CEREAL KELLOGG'S" = "SEREAL",
  "CHAMP SOSIS" = "SOSIS",
  "CHAMP SOSIS AYAM" = "SOSIS",
  "KENTANG GORENG" = "MAKANAN BERAT",
  "CERES" = "MESES",
  "CHCIKEN STEAK" = "MAKANAN BERAT",
  "CHICKEN STEAK" = "MAKANAN BERAT",
  "FRENCH FRIES" = "MAKANAN BERAT",
  "CHEESE CROISSANT" = "ROTI",
  "CIMORY" = "YOGHURT",
  "CIMORY HONEY" = "YOGHURT",
  "CIMORY YOGHURT" = "YOGHURT",
  "GREEK YOGURT" = "YOGHURT",
  "CLOSEUP" = "PASTA GIGI",
  "COCO BIT SP GUAVA" = "MINUMAN BUAH",
  "COTONBUD" = "COTTON BUDS",
  "COTTON BUD" = "COTTON BUDS",
  "CUTTONBUD" = "COTTON BUDS",
  "CREAMER" = "WHIP CREAM",
  "AYAM" = "DAGING AYAM",
  "DAGING" = "DAGING SAPI",
  "DAIA" = "SABUN CUCI PAKAIAN",
  "DETERGEN" = "SABUN CUCI PAKAIAN",
  "DETERGEN ATTACK" = "SABUN CUCI PAKAIAN",
  "DETERGEN RINSO" = "SABUN CUCI PAKAIAN",
  "DETERJEM" = "SABUN CUCI PAKAIAN",
  "DETERJEN" = "SABUN CUCI PAKAIAN",
  "DAN KARI" = "PENYEDAP RASA",
  "DAZEL SLS" = "SELIMUT",
  "DAZEL SELIMUT" = "SELIMUT",
  "DELMONTE" = "SAOS SAMBAL",
  "DELMONTE EXTRA HOT PET" = "SAOS SAMBAL",
  "DEODARAN" = "DEODORANT",
  "DEODORAN" = "DEODORANT",
  "DORA RACUN TIKUS" = "RACUN TIKUS",
  "DOWNY" = "PEWANGI PAKAIAN",
  "DUMPLING CEDEA" = "DUMPLING",
  "ENERGEN" = "MINUMAN ENERGI",
  "EXTRA JOSS" = "MINUMAN ENERGI",
  "ES KOPI" = "KOPI",
  "GOOD TIME" = "BISKUIT",
  "GOODTIME" = "BISKUIT",
  "INDOCAFE" = "KOPI",
  "ES COKLAT" = "MINUMAN",
  "ES TEH" = "TEH",
  "FRESHTEA JASMINE" = "TEH",
  "FRESSTEA" = "TEH",
  "FRESTEA" = "TEH",
  "FRUIT TEA" = "TEH",
  "FRUIT TEA APPLE" = "TEH",
  "ICHI OCHA" = "TEH",
  "ICHITAN" = "TEH",
  "ICHITAN THAI MILK TEA" = "TEH",
  "ICHITAN THAI TEA" = "TEH",
  "JAVANA" = "TEH",
  "FIESTA CHICKEN NUGGET" = "NUGGET",
  "FIESTA NUGGET" = "NUGGET",
  "FOX" = "LEM",
  "GAJAH TIKUS TRAP" = "LEM TIKUS",
  "GARNIER" = "SABUN CUCI MUKA",
  "GARNIER MEN" = "SABUN CUCI MUKA",
  "GARNIER PINK" = "SABUN CUCI MUKA",
  "GARNIER MICELLAR WATER" = "PEMBERSIH WAJAH",
  "GARUDA KACANG" = "KACANG",
  "GIV" = "SABUN MANDI",
  "GOCHUJANG" = "MAKANAN KOREA",
  "JAJJANGMYEON" = "MAKANAN KOREA",
  "GOOD MOOD" = "MINUMAN BUAH",
  "HYDRA COCO" = "MINUMAN BUAH",
  "GUKA MERAH" = "GULA MERAH",
  "GULA PASIR" = "GULA PUTIH",
  "HANDBODY" = "LOTION",
  "HANDSAINITEZER" = "HAND SANITIZER",
  "HANSAPLAST" = "PLASTER",
  "HARPIC" = "PEMBERSIH TOILET",
  "HARPIC PEMBERSIH KLOSET" = "PEMBERSIH TOILET",
  "HIT (PEMBUNUH NYAMUK)" = "OBAT NYAMUK",
  "IKAN SALMON" = "IKAN",
  "JAMUR INOKITATE" = "JAMUR",
  "JAMUR ENOKI" = "JAMUR",
  "JAVANA" = "TEH",
  "JAVANA MELATI" = "TEH",
  "JERUK MEDAN" = "JERUK",
  "JERUK)" = "JERUK",
  "JETZ" = "SNACK",
  "JUS JERUK" = "JUS",
  "KACANG ATOM" = "KACANG",
  "KACANG DUA KELINCI" = "KACANG",
  "KACANG GARUDA" = "KACANG",
  "KACANG TANAH" = "KACANG",
  "KALDU BUBUK" = "PENYEDAP RASA",
  "KALDU JAMUR" = "PENYEDAP RASA",
  "KAPAL API" = "KOPI",
  "KAPAS BAYGON" = "KAPAS",
  "KAPAS WAJAH" = "KAPAS",
  "KAPUR BARUS" = "KAMPER",
  "KARA" = "SANTAN",
  "KASA STERIL" = "KASA",
  "KATSU EGG" = "MAKANAN BERAT",
  "KBPS YOGHURT PLAIN" = "YOGHURT",
  "KEJU CAKE" = "KUE",
  "KEJU CRAFT" = "KEJU",
  "KEJU KRAFT" = "KEJU",
  "KEJU PRO CHIZ" = "KEJU",
  "KENKO CUTTER" = "CUTTER",
  "KHONG GUAN" = "KUE",
  "KINDERJOY" = "COKLAT",
  "KIRANA BASO SKL HIJAU" = "BAKSO",
  "KISPRAY" = "PELICIN PAKAIAN",
  "KIT KAT" = "COKLAT",
  "KITKAT" = "COKLAT",
  "KLINPAK CLING WRAP JUMBO REFFIL" = "PEMBERSIH KACA",
  "KOKO KRUNCH" = "SEREAL",
  "KOPI ABC" = "KOPI",
  "KOPI GAJAH" = "KOPI",
  "KOP GOODDAY" = "KOPI",
  "KOPI SASET" = "KOPI",
  "KOPIKO" = "PERMEN",
  "KOPIKO CANDY" = "PERMEN",
  "KOREK GAS" = "KOREK",
  "KORNET 200G" = "KORNET",
  "KRAFT CHEEDAR" = "KEJU",
  "KRATINGDAENG" = "MINUMAN KESEHATAN",
  "KRIPIK" = "KERIPIK",
  "KRUPUK" = "KERUPUK",
  "KUACI FUZO" = "KUACI",
  "KUACI REBO" = "KUACI",
  "KUE COKLAT" = "KUE",
  "KUE OREO" = "BISKUIT",
  "KUSUKA KEJU BAKAR" = "SNACK",
  "LADA BUBUK" = "LADA",
  "LADAKU MERICA BUBUK" = "LADA",
  "LAMPU BOHLAM" = "LAMPU",
  "LARUTAN CAP KAKI 3" = "MINUMAN KESEHATAN",
  "LASEGAR" = "MINUMAN KESEHATAN",
  "LAYS" = "SNACK",
  "LE MINERALE" = "AIR MINERAL BOTOL",
  "LEMONILO" = "MIE INSTAN",
  "LEXUS" = "SNACK",
  "LIP CREAM" = "LIP PRODUCT",
  "LIPBALM" = "LIP PRODUCT",
  "LIPTIN" = "LIP PRODUCT",
  "LISTERINE" = "OBAT KUMUR",
  "LOTION ANTI NYAMUK" = "REPELLANT NYAMUK",
  "LOTION TUBUH" = "LOTION",
  "LUWAK WHITE KOFEE" = "KOPI",
  "MADU TJ" = "MADU",
  "MAICIK" = "KERIPIK",
  "MAITOS" = "SNACK",
  "MAIZENA" = "TEPUNG MAIZENA",
  "MAKANAN RINGAN" = "SNACK",
  "MALANG SARI ASEM" = "PERMEN",
  "MALKIST" = "BISKUIT",
  "MALKIST KEJU" = "BISKUIT",
  "MAMA LEMON" = "SABUN CUCI PIRING",
  "MAMASUKA RUMPUT LAUT" = "RUMPUT LAUT",
  "MANISAN(YUPI)" = "PERMEN",
  "MARGARIN BLUEBAND" = "MARGARIN",
  "MARJAN" = "SIRUP",
  "MARJAN COCOPANDAN" = "SIRUP",
  "MASAKO" = "PENYEDAP RASA",
  "MASAKO AYAM" = "PENYEDAP RASA",
  "MASAKO SAPI" = "PENYEDAP RASA",
  "MASJER WAJAH GARNIER" = "MASKER WAJAH",
  "MATCHA INSTAN" = "MINUMAN",
  "MAXI CORN" = "SNACK",
  "MAYASI" = "KACANG",
  "MAYONAISE" = "MAYONNAISE",
  "MAYUMI" = "MAYONNAISE",
  "MENTOS" = "PERMEN",
  "MENTOS CANDY" = "PERMEN",
  "MERICA" = "LADA",
  "MI INSTAN" = "MIE INSTAN",
  "MICELLAR WATER" = "PEMBERSIH WAJAH",
  "MIE" = "MIE INSTAN",
  "MIE BURUNG DARA" = "MIE INSTAN",
  "MIE GELAS" = "MIE INSTAN",
  "MIE GORENG" = "MIE INSTAN",
  "MIE JUMBO" = "MIE INSTAN",
  "MIE SAMYANG" = "MIE INSTAN",
  "MIE SEDAAP GORENG" = "MIE INSTAN",
  "MIE WADAH BASO (2)" = "MIE INSTAN",
  "MIE WADAH KR(2)" = "MIE INSTAN",
  "MIEGHETTI" = "MIE INSTAN",
  "MILK TEA" = "MINUMAN",
  "MILO" = "SUSU",
  "MINERAL WATER KEMASAN BOTOL" = "AIR MINERAL BOTOL",
  "MINUMAN CINCAU" = "MINUMAN",
  "MINUMAN DINGIN" = "MINUMAN",
  "MINUMAN ION" = "MINUMAN ISOTONIK",
  "MINUMAN ISOTONIC" = "MINUMAN ISOTONIK",
  "MINUMAN JAHE" = "MINUMAN KESEHATAN",
  "MINUMAN JERUK" = "MINUMAN BUAH",
  "MINUMAN JUS" = "JUS",
  "MINUMAN PROTEIN" = "MINUMAN KESEHATAN",
  "MINUMAN SERBUK VITAMIN C1000 SACHET" = "MINUMAN VITAMIN",
  "MINUMAN SODA" = "MINUMAN BERKARBONASI",
  "MINUMAN SPRITE" = "MINUMAN BERKARBONASI",
  "MINUMAN TEH" = "TEH",
  "MINUMAN TEH BOTOL SOSRO" = "TEH",
  "MINUMAN VITAMIN C1000" = "MINUMAN VITAMIN",
  "MINUMAN THAILAND" = "MINUMAN",
  "MINYAK" = "MINYAK GORENG",
  "MINYAK GORENG FILMA" = "MINYAK GORENG",
  "MINYAK GORENG SANIA" = "MINYAK GORENG",
  "MISCELLAR WATER" = "PEMBERSIH WAJAH",
  "MITU WIPE BLUE" = "TISU BASAH",
  "MIZONE" = "MINUMAN ISOTONIK",
  "MOGU-MOGU" = "MINUMAN",
  "MOISTURIZER" = "PELEMBAB WAJAH",
  "MOJITO" = "MINUMAN BERKARBONASI",
  "MOLTO" = "PEWANGI PAKAIAN",
  "MONDE SNACK" = "SNACK",
  "MUJIGAE" = "MINUMAN",
  "MY TEA" = "TEH",
  "NABATI" = "WAFER",
  "NASI AYAM BETUTU" = "MAKANAN BERAT",
  "NASI GORENG" = "MAKANAN BERAT",
  "NASI PADANG" = "MAKANAN BERAT",
  "NASI SEGITA 100G" = "ONIGIRI",
  "NASI SEGITA MAYO (2)" = "ONIGIRI",
  "NATA DE COCO" = "MINUMAN BUAH",
  "NESCAFE" = "KOPI",
  "NESCAFE GOLD" = "KOPI",
  "NESTAR" = "KOPI",
  "NESTLE" = "AIR MINERAL BOTOL",
  "NESTLE CEREAL" = "SEREAL",
  "NESTLE PURE LIFE" = "AIR MINERAL BOTOL",
  "NII GREENTEA" = "TEH",
  "NORI" = "RUMPUT LAUT",
  "NU CHOCO HAZELNUTEA" = "TEH",
  "NUGET" = "NUGGET",
  "NUGET AYAM" = "NUGGET",
  "NUTELLA" = "COKLAT",
  "NUTRI SARI" = "MINUMAN",
  "NUTS" = "KACANG",
  "NUVO" = "SABUN MANDI",
  "NYAM-NYAM" = "SNACK",
  "OAT BISKUIT" = "BISKUIT",
  "OATSIDE" = "SUSU",
  "OBAT SAKIT KEPALA" = "OBAT PUSING",
  "ODENG" = "MAKANAN KOREA",
  "OISHI PILLOWS" = "SNACK",
  "OISHI POPPY" = "SNACK",
  "OLATTE" = "MINUMAN",
  "ONE PUSH VAPE" = "OBAT NYAMUK",
  "ONIGIRI(2)" = "ONIGIRI",
  "ORAL-B" = "SIKAT GIGI",
  "ORANGE" = "JERUK",
  "ORANGE WATER" = "MINUMAN BUAH",
  "OREO" = "BISKUIT",
  "OVOMALTINE" = "COKLAT",
  "PANTENE" = "SHAMPO",
  "PARFUM AXE" = "PARFUM",
  "PARFUM BAJU" = "PEWANGI PAKAIAN",
  "PARFUME" = "PARFUM",
  "PASTA COKLAT" = "COKLAT",
  "PASTA GIGI CLOSEUP" = "PASTA GIGI",
  "PASTA GIGI SENSODYNE" = "PASTA GIGI",
  "PASTA SPAGHETTI" = "SPAGHETTI",
  "PEAR" = "PIR",
  "PELEMBUT PAKAIAN DOWNY" = "PELEMBUT PAKAIAN",
  "PELICIN PAKAIAN KISPRAY" = "PELICIN PAKAIAN",
  "PEMBASMI NYAMUK" = "OBAT NYAMUK",
  "PEMBERSIH LANTAI PORSTEX" = "PEMBERSIH LANTAI",
  "PEMBERSIH MULUT" = "OBAT KUMUR",
  "PEMBERSIH PAKAIAN" = "SABUN CUCI PAKAIAN",
  "PEMBERSIH PIRING" = "SABUN CUCI PIRING",
  "PEMUTIH BAYCLIN" = "PEMUTIH",
  "PENCUCI MUKA" = "SABUN CUCI MUKA",
  "PENCUCI PIRING" = "SABUN CUCI PIRING",
  "PENGHARUM PAKAIAN" = "PEWANGI PAKAIAN",
  "PENGHARUM RUANGAN STELLA" = "PENGHARUM RUANGAN",
  "PENSIL FABER CASTELL" = "PENSIL",
  "PENYEDAP" = "PENYEDAP RASA",
  "PENYEDAP RASA (SASA)" = "PENYEDAP RASA",
  "PENYEGAR RUANGAN" = "PENGHARUM RUANGAN",
  "PEPSODENT" = "PASTA GIGI",
  "PERASA MAKANAN" = "PENYEDAP RASA",
  "PERFUME" = "PARFUM",
  "PERMEN KARET" = "PERMEN",
  "PEWANGI BAJU" = "PEWANGI PAKAIAN",
  "PEWANGI RAUANGAN" = "PEWANGI RUANGAN",
  "PILUS" = "SNACK",
  "PKT BREAD.CO" = "ROTI",
  "PLASTIK BESAR" = "PLASTIK",
  "PLASTIK WRAP" = "PLASTIK",
  "POCARI" = "MINUMAN ISOTONIK",
  "POCKY" = "SNACK",
  "POP MIE" = "MIE INSTAN",
  "PORVITA MARGARIN" = "MARGARIN",
  "POSH MEN" = "PARFUM",
  "POTABEE" = "SNACK",
  "PREMEN" = "PERMEN",
  "PRIME BREAD" = "ROTI",
  "PRINGLES" = "SNACK",
  "PRINTER INK" = "TINTA",
  "PRISTINE" = "AIR MINERAL BOTOL",
  "PRISTINE AIR MINERAL" = "AIR MINERAL BOTOL",
  "PRISTINE BOTOL" = "AIR MINERAL BOTOL",
  "PROMINA" = "SNACK BAYI",
  "PUDDING MANGGA" = "PUDING",
  "PULPEN FABEL CASTELL" = "PULPEN",
  "PULPY ORANGE" = "MINUMAN BUAH",
  "QTELA" = "SNACK",
  "QUAKER" = "OLAHAN GANDUM",
  "RAINBOW POWER WALLS" = "ES KRIM",
  "RAJAWALI TS PANJANG LABEL KUNING XL" = "TUSUK SATE",
  "RAMEN" = "MIE INSTAN",
  "REAL GOOD" = "SUSU",
  "REDOXON" = "VITAMIN",
  "REFIL PARFUM" = "PARFUM",
  "REGULER NASI" = "NASI",
  "RICH CREME WHIP CREAM POWDER" = "WHIP CREAM",
  "RICOLA" = "PERMEN",
  "RINSO" = "DETERJEN",
  "RISOL MAYO" = "RISOL",
  "ROMA" = "BISKUIT",
  "ROMA KELAPA" = "BISKUIT",
  "ROTI ISI" = "ROTI",
  "ROTI SARI ROTI" = "ROTI",
  "ROTI SARIROTI" = "ROTI",
  "ROTI TAWAR" = "ROTI",
  "ROTI TAWAR JUMBO" = "ROTI",
  "ROYALE" = "PEWANGI PAKAIAN",
  "ROYCO" = "PENYEDAP RASA",
  "S-TEE" = "TEH",
  "SABN CUCI PIRING" = "SABUN CUCI PIRING",
  "SABUN BAJU" = "SABUN CUCI PAKAIAN",
  "SABUN CUCI BAJU" = "SABUN CUCI PAKAIAN",
  "SABUN CUCI MUKA GARNIER" = "SABUN CUCI MUKA",
  "SABUN CUCI MUKA WARDAH" = "SABUN CUCI MUKA",
  "SABUN DETOL" = "SABUN MANDI",
  "SABUN GIV" = "SABUN MANDI",
  "SABUN LIFEBUOY" = "SABUN MANDI",
  "SABUN MANDI LIFEBUOY" = "SABUN MANDI",
  "SABUN MUKA" = "SABUN CUCI MUKA",
  "SABUN NUVO" = "SABUN MANDI",
  "SABUN PEL" = "PEMBERSIH LANTAI",
  "SABUN PEL LANTAI" = "PEMBERSIH LANTAI",
  "SABUN PEMBERSIH MUKA" = "SABUN CUCI MUKA",
  "SABUN PENCUCI MUKA" = "SABUN CUCI MUKA",
  "SABUN SCOTCHBRITE" = "SPONS",
  "SALAK PONDOH" = "SALAK",
  "SAMBAL" = "SAOS SAMBAL",
  "SAMPO" = "SHAMPO",
  "SAMPO CLEAR" = "SHAMPO",
  "SAMYANG" = "MIE INSTAN",
  "SAOS" = "SAOS SAMBAL",
  "SAOS ABC" = "SAOS SAMBAL",
  "SAOS CABE" = "SAOS SAMBAL",
  "SARDEN ABC SAUS TOMAT" = "SARDEN",
  "SARI GANDUM" = "BISKUIT",
  "SARI KACANG IJO" = "MINUMAN",
  "SARI ROTI" = "ROTI",
  "SARI ROTI COKLAT KEJU" = "ROTI",
  "SARIMI" = "MIE INSTAN",
  "SARIRAOS SIMPING" = "KUE",
  "SAUS" = "SAOS SAMBAL",
  "SNICKERS" = "SNACK",
  "PLASTER" = "PLESTER",
  "SAUS BOLOGNESE" = "SAOS BOLOGNASE",
  "SAUS BULGOGI" = "SAOS BULGOGI",
  "SAUS GOCHUJANG" = "SAOS GOCHUJANG",
  "SAUS MAKANAN RINGAN" = "SAOS SAMBAL",
  "SAUS SAMBAL" = "SAOS SAMBAL",
  "SAUS SAMBAL EXTRA PEDAS ABC" = "SAOS SAMBAL",
  "SAYUR" = "WORTEL",
  "SAYURAN SEGAR (WORTEL" = "WORTEL",
  "SEBLAK CAMPUR" = "SEBLAK",
  "SEGITIGA BIRU" = "TEPUNG TERIGU",
  "SELAI OLAI" = "BISKUIT",
  "SENDOK)" = "SENDOK",
  "SGM" = "SUSU",
  "SHAMPOO" = "SHAMPO",
  "SHAMPOO CLEAR" = "SHAMPO",
  "SHAMPOO HEAD & SHOULDER" = "SHAMPO",
  "SHAMPOO REJOYCE" = "SHAMPO",
  "SHINZUI FACIAL WASH" = "SABUN CUCI MUKA",
  "SIKAT" = "SIKAT GIGI",
  "SIKAT GIGI FORMULA" = "SIKAT GIGI",
  "SIKAT GIGI PEPSODENT" = "SIKAT GIGI",
  "SILVER QUEEN" = "COKLAT",
  "SILVERQUEEN" = "COKLAT",
  "SINDE" = "MINUMAN KESEHATAN",
  "SKINCARE" = "SABUN CUCI MUKA",
  "SLAI O LAI" = "BISKUIT",
  "SLAI OLAI"= "BISKUIT",
  "SNACK BALADO 140" = "SNACK",
  "SNACK BROWNIES" = "SNACK",
  "SNACK SAPI" = "SNACK",
  "SNICKERKS" = "SNACK",
  "SO KLIN" = "PEMBERSIH LANTAI",
  "SO KLIN LANTAI" = "PEMBERSIH LANTAI",
  "SODA" = "MINUMAN BERKARBONASI",
  "SODA LEMON" = "MINUMAN BERKARBONASI",
  "MINUMAN BERSODA" =  "MINUMAN BERKARBONASI",
  "SOFTDRINK" = "MINUMAN",
  "SOFTEX" = "PEMBALUT",
  "SOFTLENS" = "LENSA KONTAK",
  "SOPTEX" = "PEMBALUT",
  "SOSIS HANZEL" = "SOSIS",
  "SOSIS INDOMARET" = "SOSIS",
  "SOSIS KANZLER" = "SOSIS",
  "SOSIS KANZLER GOCHUJANG DAN KEJU" = "SOSIS",
  "SOSIS NUGGET" = "SOSIS",
  "SOZZIZ" = "SOSIS",
  "SPAGETI" = "SPAGHETTI",
  "SPAGHETI" = "SPAGHETTI",
  "SPON" = "SPONS",
  "SPONGE" = "SPONS",
  "SPONS CUCI PIRING STOTCH-BRITE" = "SPONS",
  "SPRIT" = "MINUMAN BERKARBONASI",
  "SPRITE" = "MINUMAN BERKARBONASI",
  "STELA" = "PENGHARUM RUANGAN",
  "STIK KEJU" = "SNACK",
  "STRAWBERRY LUCKY SUNDAE" = "ES KRIM",
  "SUKRO" = "KACANG",
  "SUNCO POUCH" = "MINYAK GORENG",
  "SUNLIGHT" = "SABUN CUCI PIRING",
  "SUNSILK" = "SHAMPO",
  "SUPER BUBUR" = "BUBUR",
  "SUSU 200ML" = "SUSU",
  "SUSU 250ML" = "SUSU",
  "SUSU BENDERA" = "SUSU",
  "SUSU BERUANG" = "SUSU",
  "SUSU BUBUK" = "SUSU",
  "SUSU CIMORY" = "SUSU",
  "SUSU DANCOW" = "SUSU",
  "SUSU INDOMILK" = "SUSU",
  "SUSU KEDELAI" = "SUSU",
  "SUSU KENTAL MANIS" = "SUSU",
  "SUSU KENTAL MANIS CARNATION" = "SUSU",
  "SUSU UHT" = "SUSU",
  "SUSU UHT DIAMOND" = "SUSU",
  "SUSU ULTRA" = "SUSU",
  "SWALLOW SJD" = "SENDAL",
  "TANGO" = "KUE",
  "TARO" = "SNACK",
  "TARO BALL" = "SNACK",
  "TEBS" = "MINUMAN BERKARBONASI",
  "TEH BOTOL" = "TEH",
  "TEH BOTOL KOTAK" = "TEH",
  "TEH GELAS" = "TEH",
  "TEH JAVANA" = "TEH",
  "TEH KEMASAN" = "TEH",
  "TEH KOTAK" = "TEH",
  "TEH POCI" = "TEH",
  "TEH PUCUK" = "TEH",
  "TEH PUCUK HARUM" = "TEH",
  "TEH SOSRO" = "TEH",
  "TEH TONG JI" = "TEH",
  "TELOR" = "TELUR",
  "TELUR AYAM" = "TELUR",
  "TELUR AYAM NEGERI" = "TELUR",
  "TELUR GABUS" = "SNACK",
  "TEPUNG" = "TEPUNG TERIGU",
  "TERIGU" = "TEPUNG TERIGU",
  "TESSSA TISSUE" = "TISU KERING",
  "USB" = "KABEL CHARGER",
  "THAI TEA" = "TEH",
  "THE PUCUK" = "TEH",
  "TIC TAC" = "SNACK",
  "TISSU" = "TISU KERING",
  "TISSUE" = "TISU KERING",
  "TISSUE PASEO" = "TISU KERING",
  "TISU" = "TISU KERING",
  "TOBLERONE" = "COKLAT",
  "TOFU" = "TAHU",
  "TOLAK ANGIN" = "MINUMAN KESEHATAN",
  "TOP COFFE" = "KOPI",
  "TOPPOKI INSTAN" = "MAKANAN KOREA",
  "TRASH BAG" = "PLASTIK",
  "TTEOK" = "MAKANAN KOREA",
  "TTEOKBOKI" = "MAKANAN KOREA",
  "TWISTKO" = "SNACK",
  "UHT" = "SUSU",
  "ULTRA MILK" = "SUSU",
  "ULTRA STRAWBERRY" = "SUSU",
  "ULTRAMILK" = "SUSU",
  "VIDORAN" = "VITAMIN",
  "VITAMIN D" = "VITAMIN",
  "VITAMIN RAMBUT" = "VITAMIN",
  "WALLS ICE CREAM" = "ES KRIM",
  "WDANK" = "MINUMAN KESEHATAN",
  "WHISKAS MAKANAN KUCING" = "MAKANAN KUCING",
  "YAKULT" = "MINUMAN KESEHATAN",
  "YAKULT CITRUN" = "MINUMAN KESEHATAN",
  "YC1000" = "MINUMAN KESEHATAN",
  "YOGHURT CIMORY" = "YOGHURT",
  "YOGURT BLUBERRY" = "YOGHURT",
  "YOGURT BLUEBERRY" = "YOGHURT",
  "YOGURT STROBERRY" = "YOGHURT",
  "YOHURT" = "YOGHURT",
  "YOU-C 1000" = "MINUMAN KESEHATAN",
  "YUPI" = "PERMEN",
  "YUPI LITTLE STARS" = "PERMEN",
  "ZEE" = "SUSU",
  "MINUMANA THAILAND" = "MINUMAN THAILAND",
  "MIS INSTAN" = "MIE INSTAN",
  "NASI SEGITIGA MAYO (2)" = "ONIGIRI",
  "Nestlé Pure Life" = "AIR MINERAL BOTOL",
  "NUGGET AYAM" = "NUGGET",
  "NUTRIBOOST" = "MINUMAN",
  "NUTRIJEL" = "AGAR-AGAR",
  "NUTRISARI" = "MINUMAN",
  "ODOL" = "PASTA GIGI",
  "PILUS GARUDA" = "KACANG",
  "POCARI SWEAT" = "MINUMAN ISOTONIK",
  "POPOK BAYI" = "POPOK",
  "PRINGLES ORGINAL" = "SNACK",
  "PULPEN FABER CASTELL" = "PULPEN",
  "ROMA MALKIST" = "BISKUIT",
  "SABUN" = "SABUN MANDI",
  "SABUN CUCI" = "SABUN CUCI PIRING",
  "SABUN MANDI LIFEBUOY" = "SABUN MANDI",
  "SALMON BALL" = "MAKANAN JEPANG",
  "SELAI STRAWBERRY" = "SELAI",
  "SPONS CUCI PIRING SCOTCH-BRITE" = "SPONS",
  "STTRAWBERRY LUCKY SUNDAE" = "ES KRIM",
  "STICK KEPITING," = "MAKANAN JEPANG",
  "SUP INSTAN" = "SUP",
  "TEH TONG TJI" = "TEH",
  "TESSA TISSUE" = "TISU KERING",
  "WAGON CONTAINER BOX" = "BOX",
  "WALLS" = "ES KRIM",
  "YOGURT" = "YOGHURT",
  "ZUPPA SOUP" = "SUP",
  "ADEMSARI" = "MINUMAN KESEHATAN",
  "AQUA" = "AIR MINERAL BOTOL",
  "BASO" = "BAKSO",
  "BOLEN LILIT COKLAT" = "KUE",
  "BUSKUIT" = "BISKUIT",
  "CHIKUWA" = "MAKANAN JEPANG",
  "COOKIE" = "BISKUIT",
  "CUP" = "GELAS",
  "DEODIRAN TELUR KECAP BUAH ROTI KAPAS" = "DEODORANT",
  "DETERJEN" = "SABUN CUCI PAKAIAN",
  "DUMPLING" = "MAKANAN TIONGKOK",
  "HAIR TONIC" = "PERAWATAN RAMBUT",
  "HIT" = "OBAT NYAMUK",
  "HYDRO COCO" = "MINUMAN BUAH",
  "KOPI GOODDAY" = "KOPI",
  "KOPI KAPAL API" = "KOPI",
  "LUWAK WHITE KOFFE" = "KOPI",
  "LYCHEE" = "LECI",
  "MAICIH" = "KERIPIK",
  "MENTOS MINT" = "PERMEN",
  "MIE INSTANT" = "MIE INSTAN",
  "BRONDONG JAGUNG" = "POPCORN",
  "GULA" = "GULA PUTIH",
  "KABEL CHARGER TYPE C" = "KABEL CHARGER",
  "KABEL USB" = "KABEL CHARGER",
  "KECAP" = "KECAP MANIS",
  "KERIPIK PISANG" = "KERIPIK",
  "MASKER WAJAH GARNIER" = "MASKER WAJAH",
  "SABUN MANDI LIFEBOUY" = "SABUN MANDI",
  "PRINGLES ORIGINAL" = "SNACK",
  "BUMBU" = "BUMBU INSTAN"
)

# menggunakan mapping value untuk mengubah
df2 <- data.frame(lapply(df2, function(x) mapvalues(x, from = names(mapping), to = mapping)))

View(df2)

# Mengumpulkan nilai unik dari semua kolom dan menggabungkannya menjadi satu vektor
unique_values <- unique(unlist(df2))

# menghilangkan data yg NA
unik <- na.omit(unique_values)
unik <- sort(unik)

#Ubah menjadi data frame agar mudah dilihat
unik <- data.frame(unik)
View(unik)

# Fungsi untuk menyatukan nilai-nilai dari setiap baris dengan koma di antaranya
df2$Items <- apply(df2, 1, function(row) {
  non_null_values <- row[!is.na(row)]
  if (length(non_null_values) > 0) {
    paste(non_null_values, collapse = ", ")
  } else {
    NA
  }
})

# Print hasil
df2 <- df2[, "Items", drop = FALSE]

df2 <- na.omit(df2) # menghilangkan baris yang ada nullnya
View(df2)

df2 <- na.omit(df2) #menghilangkan baris yang ada nullnya

# Split the Items into a list of transactions
transactions <- strsplit(as.character(df2$Items), ", ")

# Convert to a binary matrix (transaction vs. item)
transaction_matrix <- as(transactions, "transactions")

# Inspect the resulting binary matrix
inspect(transaction_matrix)

model1 <- apriori(transaction_matrix, minlen=3, parameter = list(support = 0.005, confidence = 0.005))
print(length(model1))
inspect(sort(model1, by = 'lift'))

df_label <- data.frame( Items = labels(sort(model1, by = 'lift')))

 # Membersihkan whitespace pada kedua kolom
output_data$Items <- trimws(output_data$Items)
output_data$Output <- trimws(output_data$Output)

output_data[] <- lapply(output_data, function(x) gsub("[{}]", "", x))
# Menampilkan hasil
df_label <- output_data
# Definisi fungsi untuk memprediksi kemungkinan rekomendasi item transaksi
predict_output_all <- function(new_items, df_label) {
  # Mengonversi setiap elemen input menjadi pola regex dan membuat regex yang memuat semua elemen
  regex_pattern <- paste0(".*", paste(new_items, collapse = ".*"), ".*")
 
  # Mencocokkan pola regex di dalam kolom df_label$Items
  match_rows <- grepl(regex_pattern, df_label$Items)
 
  # Jika setidaknya satu baris cocok, mengembalikan output dalam format vektor
  if (any(match_rows)) {
    output <- unique(df_label$Output[match_rows])
    formatted_output <- paste("[", seq_along(output), "] ", output, collapse = "\n")
    return(formatted_output)
  } else {
    return("Pola input tidak cocok dengan data")
  }
}

# Contoh penggunaan fungsi dengan input
# input <- c("SUSU”)
# cat(predict_output_all(input, df_label))

model12 <- apriori(transaction_matrix, parameter = list(minlen=2,support = 0.002, confidence = 0.6)) #Percobaan = Rules 999
rules <- model12
result_dataframe <- generate_recommendations(inputs, rules)


# Menampilkan hasil
result_dataframe$Realtime <- df_test$`REAL ITEM`
result_dataframe <- result_dataframe[,c("Input","Realtime","Prediksi")]
View(result_dataframe)
