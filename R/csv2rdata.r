# Save all csv files as rdata files

# for i in *.csv; do
# echo "${i%.*} <- utils::read.csv2(file = 'csv/$i', sep = ';')" >> ../R/csv2rdata.r
# echo "usethis::use_data(${i%.*}, overwrite = TRUE)" >> ../R/csv2rdata.r
# echo "" >> ../R/csv2rdata.r
# done

csv2rdata <- function() {

  barn <- utils::read.csv2(file = "csv/barn.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(barn, overwrite = TRUE)

  barn_en <- utils::read.csv2(file = "csv/barn_en.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(barn_en, overwrite = TRUE)

  dagkir <- utils::read.csv2(file = "csv/dagkir.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(dagkir, overwrite = TRUE)

  dagkir2 <- utils::read.csv2(file = "csv/dagkir2.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(dagkir2, overwrite = TRUE)

  dagkir2_en <- utils::read.csv2(file = "csv/dagkir2_en.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(dagkir2_en, overwrite = TRUE)

  dagkir_en <- utils::read.csv2(file = "csv/dagkir_en.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(dagkir_en, overwrite = TRUE)

  eldre <- utils::read.csv2(file = "csv/eldre.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(eldre, overwrite = TRUE)

  eldre_en <- utils::read.csv2(file = "csv/eldre_en.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(eldre_en, overwrite = TRUE)

  fodsel <- utils::read.csv2(file = "csv/fodsel.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(fodsel, overwrite = TRUE)

  fodsel_en <- utils::read.csv2(file = "csv/fodsel_en.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(fodsel_en, overwrite = TRUE)
  
  gyn <- utils::read.csv2(file = "csv/gyn.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(gyn, overwrite = TRUE)

  gyn_en <- utils::read.csv2(file = "csv/gyn_en.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(gyn_en, overwrite = TRUE)

  kols <- utils::read.csv2(file = "csv/kols.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(kols, overwrite = TRUE)

  kols_en <- utils::read.csv2(file = "csv/kols_en.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(kols_en, overwrite = TRUE)

  nyfodt <- utils::read.csv2(file = "csv/nyfodt.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(nyfodt, overwrite = TRUE)

  nyfodt_en <- utils::read.csv2(file = "csv/nyfodt_en.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(nyfodt_en, overwrite = TRUE)

  ortopedi <- utils::read.csv2(file = "csv/ortopedi.csv", encoding = "UTF-8", dec = ".", sep = ";")
  usethis::use_data(ortopedi, overwrite = TRUE)
}
