library(dplyr)
library(stringr)

setwd("../")
load("data/add_data.RData")

# fnames = list.files(full.names=TRUE, recursive=TRUE, pattern=".*inhome_dvn.tab")
# df1 = read.delim(fnames[1])
# df2 = read.delim(fnames[2])
# df3 = read.delim(fnames[3])
# df4 = read.delim(fnames[4])

df1 = df1 %>%
  setNames(toupper(names(.))
) %>%
 rename(
    disliked     = H1FS17,
    sad          = H1FS16,
    enjoy_life   = H1FS15,
    tired        = H1FS7,
    bothered     = H1FS1,
    blues        = H1FS3,
    not_good     = H1FS4,
    depressed    = H1FS6,
    cigarettes   = H1TO5,
    marijuana    = H1TO32,
    drunk        = H1TO18,
    drink        = H1TO15,
    month        = IMONTH,
    year         = IYEAR,
    day          = IDAY
) %>%
  mutate(wave = 1)

df2 = df2 %>%
  setNames(toupper(names(.))
  ) %>%
  rename(
    disliked     = H2FS17,
    sad          = H2FS16,
    enjoy_life   = H2FS15,
    tired        = H2FS7,
    bothered     = H2FS1,
    blues        = H2FS3,
    not_good     = H2FS4,
    depressed    = H2FS6,
    cigarettes   = H2TO5,
    marijuana    = H2TO46,
    drunk        = H2TO22,
    drink        = H2TO19,
    month        = IMONTH2,
    year         = IYEAR2,
    day          = IDAY2
) %>%
  mutate(wave = 2)

df3 = df3 %>%
  setNames(toupper(names(.))
  ) %>%
  rename(
    disliked     = H3SP13,
    sad          = H3SP12,
    enjoy_life   = H3SP11,
    tired        = H3SP10,
    bothered     = H3SP5,
    blues        = H3SP6,
    not_good     = H3SP7,
    depressed    = H3SP9,
    cigarettes   = H3TO7,
    marijuana    = H3TO110,
    drunk        = H3TO43,
    drink        = H3TO38,
    month        = IMONTH3,
    year         = IYEAR3,
    day          = IDAY3
) %>%
  mutate(wave = 3)

df4 = df4 %>%
  setNames(toupper(names(.))
  ) %>%
  rename(
    disliked     = H4MH27,
    sad          = H4MH26,
    enjoy_life   = H4MH25,
    tired        = H4MH23,
    bothered     = H4MH18,
    blues        = H4MH19,
    not_good     = H4MH20,
    depressed    = H4MH22,
    cigarettes   = H4TO5,
    marijuana    = H4TO71,
    drunk        = H4TO38,
    drink        = H4TO35,
    month        = IMONTH4,
    year         = IYEAR4,
    day          = IDAY4
) %>%
  mutate(wave = 4)

race_cols = c("H1GI4", "H1GI6A", "H1GI6B", "H1GI6C", "H1GI6D", "H1GI6E")
parent_ed_cols = c("PA12", "PB8")
base_cols_1 = c("AID", "BIO_SEX", "H1GI1M", "H1GI1Y", race_cols, parent_ed_cols)
long_cols = c("disliked", "sad", "enjoy_life", "tired", "bothered", "blues",
              "not_good", "depressed", "cigarettes", "marijuana", "drunk", "drink",
              "month", "year", "day", "wave")

# Find subjects recorded in all 4 waves of study
aid = Reduce(intersect, list(df1$AID, df2$AID, df3$AID, df4$AID))
add = rbind(df1[df1$AID %in% aid, c("AID", long_cols)],
            df2[df2$AID %in% aid, c("AID", long_cols)],
            df3[df3$AID %in% aid, c("AID", long_cols)],
            df4[df4$AID %in% aid, c("AID", long_cols)])

# Add baseline data
add = add %>%
  inner_join(df1[,c(base_cols_1)], by=c("AID" = "AID"))

# Rename baseline variables
colnames(add)[colnames(add) == "BIO_SEX"] = 'sex'
colnames(add)[colnames(add) == "H1GI1M"] = 'bday_m'
colnames(add)[colnames(add) == "H1GI1Y"] = 'bday_y'

# Write to csv
write.csv(add, './data/add_merge.csv', row.names = FALSE)
