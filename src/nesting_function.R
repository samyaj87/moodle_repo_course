ftoc <- function (f){
  temp.c = ((f-32)*5)/9
  return (temp.c)
}
# ss=ftoc(32)
# ss

ctok <- function (c){
  temp.k = c + 273.15
  return (temp.k)
}

# ctok(ftoc(160))
