library(dplyr)
library(stringr)

fnames = list.files(full.names=TRUE, recursive=TRUE, pattern=".*inhome_dvn.tab")

df1 = read.delim(fnames[1])
df2 = read.delim(fnames[2])
df3 = read.delim(fnames[3])
df4 = read.delim(fnames[4])

colnames(df1) = toupper(colnames(df1))
colnames(df2) = toupper(colnames(df2))
colnames(df3) = toupper(colnames(df3))
colnames(df4) = toupper(colnames(df4))

df1$wave = "1"
df2$wave = "2"
df3$wave = "3"
df4$wave = "4"

colnames(df1)[colnames(df1) == "H1CO1"] = "intercourse"
colnames(df2)[colnames(df2) == "H2CO2"] = "intercourse"
colnames(df3)[colnames(df3) == "H3SE1"] = "intercourse"
colnames(df4)[colnames(df4) == "H4SE6"] = "intercourse"

colnames(df1)[colnames(df1) == "H1GH60"] = "weight"
colnames(df2)[colnames(df2) == "H2GH53"] = "weight"
colnames(df3)[colnames(df3) == "H3DA44"] = "weight"
colnames(df4)[colnames(df4) == "H4GH6" ] = "weight"

colnames(df1)[colnames(df1) == "H1GH28"] = "think_weight"
colnames(df2)[colnames(df2) == "H2GH30"] = "think_weight"
colnames(df3)[colnames(df3) == "H3GH2" ] = "think_weight"
colnames(df4)[colnames(df4) == "H4GH7" ] = "think_weight"

colnames(df1)[colnames(df1) == "H1FS6" ] = "depressed"
colnames(df2)[colnames(df2) == "H2FS6" ] = "depressed"
colnames(df3)[colnames(df3) == "H3SP9" ] = "depressed"
colnames(df4)[colnames(df4) == "H4MH22"] = "depressed"

colnames(df1)[colnames(df1) == "H1TO5"] = "cigarettes"
colnames(df2)[colnames(df2) == "H2TO5"] = "cigarettes"
colnames(df3)[colnames(df3) == "H3TO7"] = "cigarettes"
colnames(df4)[colnames(df4) == "H4TO5"] = "cigarettes"

colnames(df1)[colnames(df1) == "H1TO32" ] = "marijuana"
colnames(df2)[colnames(df2) == "H2TO46" ] = "marijuana"
colnames(df3)[colnames(df3) == "H3TO110"] = "marijuana"
colnames(df4)[colnames(df4) == "H4TO71" ] = "marijuana"

colnames(df1)[colnames(df1) == "H1TO18"] = "drunk"
colnames(df2)[colnames(df2) == "H2TO22"] = "drunk"
colnames(df3)[colnames(df3) == "H3TO43"] = "drunk"
colnames(df4)[colnames(df4) == "H4TO38"] = "drunk"

colnames(df1)[colnames(df1) == "IMONTH" ] = "month"
colnames(df2)[colnames(df2) == "IMONTH2"] = "month"
colnames(df3)[colnames(df3) == "IMONTH3"] = "month"
colnames(df4)[colnames(df4) == "IMONTH4"] = "month"

colnames(df1)[colnames(df1) == "IYEAR"]  = "year"
colnames(df2)[colnames(df2) == "IYEAR2"] = "year"
colnames(df3)[colnames(df3) == "IYEAR3"] = "year"
colnames(df4)[colnames(df4) == "IYEAR4"] = "year"

colnames(df1)[colnames(df1) == "IDAY"]  = "day"
colnames(df2)[colnames(df2) == "IDAY2"] = "day"
colnames(df3)[colnames(df3) == "IDAY3"] = "day"
colnames(df4)[colnames(df4) == "IDAY4"] = "day"

base_cols = c("AID", "BIO_SEX", "H1GI1M", "H1GI1Y", "H1GI8")
long_cols = c("wave", "month", "day", "year", "intercourse", "weight",
              "depressed", "cigarettes", "marijuana", "drunk")

aid = Reduce(intersect, list(df1$AID, df2$AID, df3$AID, df$AID))
add = rbind(df1[df$AID %in% aid, c("AID", long_cols)],
            df2[df$AID %in% aid, c("AID", long_cols)],
            df3[df$AID %in% aid, c("AID", long_cols)],
            df4[df$AID %in% aid, c("AID", long_cols)])

add = add %>% inner_join(df1[,c(base_cols)], by=c("AID" = "AID"))

add$weight = with(add, ifelse(weight %in% c(996, 998, 999), NA, weight))
add$drunk = as.factor(add$drunk)
add$intercourse = as.factor(add$intercourse)
add$depressed = as.factor(add$depressed)
add$H1GI8 = as.factor(add$H1GI8)

add$year = ifelse(add$wave %in% c(1,2), paste0(19, add$year), add$year)
add$date = with(add, as.Date(paste0(month, "-", day, "-", year), format="%m-%d-%Y"))
add$bday = as.Date(paste0(add$H1GI1M, "-15-19", add$H1GI1Y), format="%m-%d-%Y")
add$age = with(add, round(as.numeric(difftime(date, bday)/365.25), 1))

model = glm(weight ~ depressed + age + drunk + intercourse, data = add, family="gaussian")