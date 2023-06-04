  
 #########################PROPERTY TO PERSON#######################
  ####  This script matches records based on first names      ####
  ####                                                        ####
  ####  The matching algorithm requires:                      ####
  ####    - "R", tested under version 4                       ####
  ####    - The "stringdist" library by Van der Loo           ####
  ####                                                        ####
  ####  After installing match_property requires:             ####
  ####    - Two data frames                                   ####
  ####    - containing a primary key titled "IDNR"            ####
  ####    - and a variable with first names titled "Name"     ####
  ####                                                        ####
  ####  The user can adjust:                                  ####
  ####    - The maximum Levenshtein distance                  ####
  ####    - Whether to use an adaptive Levenshtein distance   ####
  ####                                                        ####
  ####  The algorithm doesn't filter matches. For filtering   ####
  ####  we suggest a stepwise approach containing             ####
  ####    - Rule-based filters                                ####
  ####    - Probabilistic filter                              ####
  ####                                                        ####
  ####  For an implementation of PROPERTY TO PERSON see:      ####
  ####    https://github.com/HDSC-Nijmegen/Slavenregisters    ####
  ####                                                        ####
  ####  Cite as:                                              ####
  ####   Mourits, R.J. & Rosenbaum-Feldbrügge, M. (2022).     ####
  ####   Property to Person. https://github.com/RJMourits/P2P ####
 ##################################################################
  
  match_property <- function(df1, df2, lev_dist_name, adaptive="yes"){
    
   #### step 1: determine Levenshtein distance for all Name combinations ####

   #select unique names
    Slave_names_1 <- df1[!duplicated(df1$Name) & df1$Name!="",]
    Slave_names_2 <- df2[!duplicated(df2$Name) & df2$Name!="",]
   #produce matrix with Levenshtein distance
    LV_matrix <- stringdistmatrix(Slave_names_1$Name, Slave_names_2$Name, method = "lv")
   #match names with Levenshtein distance <= lev_dist_name
    x <- 0 #starting value, looped until lev_dist_name
    repeat{
     #filter LEV_DIST_Name == X from LV_matrix
      l <- as.data.frame(which(LV_matrix==x, arr.ind=TRUE))
     #filter corresponding names + add  
      l <- data.frame(Name1 = Slave_names_1$Name[l[,1]],
                      Name2 = Slave_names_2$Name[l[,2]])
     #add Levenshtein distance x as metadata
      l$LV <- x
     #store in dataframe named Slave_names_matched
      if("Slave_names_matched" %in% ls() ){
        Slave_names_matched <- rbind(Slave_names_matched, l)
      } else{
        Slave_names_matched <- l
      }
     #repeat loop until max LEV_DIST_Name is reached, then break
      if(x==lev_dist_Name) {
        break
      }
     #prepare repeat
      x <- x+1
    }
   #rename columns
    colnames(Slave_names_matched)[1:3] <- c("Name_1", "Name_2", "Name_lv")
   #adaptive Levenshtein distance
    if(adaptive=="yes"){
      Slave_names_matched <- Slave_names_matched[nchar(Slave_names_matched$Name_1)>=2 & nchar(Slave_names_matched$Name_1)<=3 & stringdist(Slave_names_matched$Name_1, Slave_names_matched$Name_2)<=1 |
                                                   nchar(Slave_names_matched$Name_1)>=4 & nchar(Slave_names_matched$Name_1)<=8 & stringdist(Slave_names_matched$Name_1, Slave_names_matched$Name_2)<=2 |
                                                   nchar(Slave_names_matched$Name_1)>=9 & stringdist(Slave_names_matched$Name_1, Slave_names_matched$Name_2)<=lev_dist_Name, ]
    }
   #clean environment
    rm(l, LV_matrix, Slave_names_1, Slave_names_2, x)
    
    
   #### step 2: select relevant columns in data frames ####
   #rename variables df1
    df1 <- df1[,c("IDNR", "Name")]
    colnames(df1) <- c("IDNR", "Name_1")
   #rename variables df2
    df2 <- df2[,c("IDNR", "Name")]
    colnames(df2) <- c("IDNR", "Name_2")
    
   #add df1 and df2 to SLAVE_NAMES_MATCHED
    df_matched <- merge(df1, Slave_names_matched, by="Name_1", all.x=T, allow.cartesian=T)
    df_matched <- merge(df_matched, df2, by="Name_2", all=F, allow.cartesian=T)
    df_matched
  }
  
  
  