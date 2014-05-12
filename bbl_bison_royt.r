# 5/10/2013 received 
# BBL10species.zip
# files in zip
# (done) BBL_0510_HERG_176824_ITIS.txt
# (done) BBL_0530_CAGU_176829_ITIS.txt
# (done) BBL_0580_LAGU_824079_ITIS.txt
# (done) BBL_0540_RBGU_176830_ITIS.txt
# (done) BBL_0650_RO_824142_ITIS.txt
# (done) BBL_0700_CO_176888_ITIS.txt
# (done) BBL_0750_SOTE_824105_ITIS.txt
# (done) BBL_1200_DCCO_174717_ITIS.txt
# (done) BBL_1250_AWPE_174684_ITIS.txt
# (done) BBL_1260_BRPE_174685_ITIS.txt

# read table into R

# set wd to BBL10species

setwd("C:/Users/derek/Documents/Data/BBL10species")

# bison fields

id
scientific_name
common_name
latitude
longitude
iso_country_code
taxon_id
year
basis_of_record
provider
resource
occurrence_date
collector
fips
state_name
county_name

# add spacer

bbl_royt$spacer1<-NA

# generate id number column using row.names


bbl_royt$b.id <- row.names(bbl_royt)

# 650  ROYT	Royal Tern	824142	Thalasseus maximus

bbl_royt$scientific_name<-"Thalasseus maximus"

# common name

bbl_royt$common_name<-"royal tern"

# latitude

bbl_royt$latitude<-bbl_royt$Lat

# longitude

bbl_royt$longitude<-bbl_royt$Lon

# iso_country_code

bbl_royt$iso_country_code<-"US"

# taxon_id

bbl_royt$taxon_id<-"824142"

# year

bbl_royt$year<-bbl_royt$Year

# convert date to iso format

bbl_royt$date<-as.Date(strptime(bbl_royt$Date,'%m-%d-%Y'))

# basis_of_record

bbl_royt$basis_of_record<-"observation"

# provider

bbl_royt$provider<-"BISON"

# resource

bbl_royt$resource<-"USGS Patuxent Wildlife Research Center - Bird Banding Lab"


# collector

bbl_royt$collector<-"USGS PWRC BBL"

# create fips column

bbl_royt$fips<-NA


# state fips

bbl_royt$StateFIPS<-bbl_royt$State

bbl_royt$StateFIPS<-sprintf("%02d",bbl_royt$StateFIPS)


# county fips

bbl_royt$county_name<-bbl_royt$County

bbl_royt$county_name<-sprintf("%03d",bbl_royt$county_name)


#concatenate

bbl_royt$fips <- paste(bbl_royt$StateFIPS, bbl_royt$county_name, sep='')

# fips optional

 # bbl_royt$fips<-bbl_royt$FIPS

bbl_royt$fips<-sprintf("%05s",bbl_royt$fips)

# rename fips to CountyFIPS

colnames(bbl_royt_final)[29]<-"CountyFIPS"


# use plyr library join function

install.packages("plyr")

bbl_royt_final<-join(bbl_royt, statefips, by = "StateFIPS", type = "left", match = "all")

bbl_royt_final<-join(bbl_royt_final, countyfips, by = "CountyFIPS", type = "left", match = "all")

# drop rename columns

colnames(bbl_royt_final)
colnames(bbl_royt_final)[29]<-"fips"
colnames(bbl_royt_final)[31]<-"cnyname"
colnames(bbl_royt_final)[32]<-"state_name"
colnames(bbl_royt_final)[33]<-"county_name"
bbl_royt_final$StateFIPS<-NULL
bbl_royt_final$cnyname<-NULL
colnames(bbl_royt_final)



# export csv file

write.csv(bbl_royt_final,"bbl_royt.csv",row.names=FALSE)

#------------useful functions---------------#

# delete row

usfips = usfips[-1,]

# delete column

usfips$colname = NULL

# rename column

colnames(usfips)[1] <- "State"
colnames(usfips)[2] <- "County Name"
colnames(usfips)[3] <- "State FIPS"
colnames(usfips)[4] <- "County FIPS"

# rename multiple columns

colnames(x) <- c("col1","col2")

# reorder rows

row.names(usfips) <- seq(nrow(usfips))


