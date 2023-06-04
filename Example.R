  
  ##### creat example data ####
  df1 <- data.frame(IDNR=1:5, Name=c("Adriane", "Bas", "Henk", "Simone", "Simon"), Sex=c("v", "m", "m", "v", "m"))
  df2 <- data.frame(IDNR=1:7, Name=c("Adriaan", "Adriane", "Ari", "Ariana", "Simon", "Teun", "Thunnis"), Sex=c("m", "v", "m", "v", "m", "m", "m"))
  
  #print example data
  df1
  df2
  
  #match with adaptive Levenshtein distance
  match_property(df1, df2, 3)
  
  #match with fixed Levenshtein distance
  match_property(df1, df2, 3, adaptive="no")
