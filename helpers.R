# 
# loc <- "Tea Time"
# loc <- "Saudia Hypermarket Al Rayyan"

locList <- read.csv("data/TimingDB.csv", stringsAsFactors = F)
locList <- as.list(locList$Location)

izitopen <- function(loc){
  TDB <- read.csv("data/TimingDB.csv", stringsAsFactors = F)
  format.symbol <- c("%H", "%M")
  names(format.symbol) <- c("hour", "min")
  
  # Get current time & convert to named numaric
  cur.time <- Sys.time()
  cur.time <- lapply(format.symbol, strftime,x = cur.time)
  cur.time <- sapply(cur.time, as.numeric)
  
  loc.time <- unlist(TDB[TDB$Location==loc, -1 ])
  
  inHour <- loc.time["FromHr"] <= cur.time["hour"] & 
            loc.time["ToHr"]   >= cur.time["hour"]
  
  inMin  <- loc.time["FromMin"] <= cur.time["min"] & 
            loc.time["ToMin"]   >= cur.time["min"]
  
  if(inHour & inMin){
    return(TRUE)
  }
  
  return (FALSE)
}
