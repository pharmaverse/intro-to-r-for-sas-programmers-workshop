# first, we load the data.

adsl <- haven::read_sas("data/adsl.sas7bdat") %>% 
  mutate_if(is_character, na_if, "")


# we can have a look at the data using many different commands  / functions.
# e.g. the summary function and the head function

head(adsl)


summary(adsl)



#### dplyr functions



# First input is always the data frame.
# After that, there can be various inputs
# The select function takes column names as inputs.
# Compared to the base r syntax we do not have to write column names in quotation marks.


#base
adsl[c("STUDYID", "USUBJID", "AGE", "SEX", "RACE", "ARM")]


# dplyr syntax lets us specify the dataframe first, and afterwards we can refer
# to columns within a dataframe without the need to always reference the dataframe 
# of origin:
#select
adsl_select <- select(.data = adsl, STUDYID, USUBJID, AGE, SEX, RACE, ARM)


# lets have a look at only men older than 70: 
# logic statements
adsl_filter <- filter(.data = adsl_select, 
                      AGE >= 70,
                      SEX == "F")
adsl_select[adsl_select$AGE>=70 & adsl_select$SEX=="F", ]

# Now we have a reduced data frame with female patients over 70.  
summary(adsl_filter)


# We can sort the dataframe with the arrange() function. It allows the sorting 
# based on multiple variables. 


adsl_arrange <- arrange(.data = adsl_filter, AGE, ARM)

# Now, we were able to to lots of things to this dataset. But we did it in a 
# way where we saved a total of 4 separate datasets, and this is not very convenient
# nor readable. 

# Instead, we can use the pipe syntax to write the exact same thing more compactly 
# (and easier to read)

# The pipe operator (ctrl shift m) uses the previously computed object and forwards it to the next function
# as the first argument. 
# It can also be specified to be some other argument of the next function.
# However, most often, the pipe takes a dataset (or a modified dataset) and forwards it 
# into the next function as the data argument of the next function.
# let's show a simple example: 
# using the pipe workflow we can select variables of interest 
# and save them in a separate dataset.

adsl %>% select(STUDYID, USUBJID, AGE, SEX, RACE, ARM)


# The pipe operator lets us chain many such commands in a row, so we can always forward
# the previously filtered / selected / arranged dataframe and keep working with it: 
# traditionally, we start a new line after every pipe operator. 

adsl_pipe <- adsl %>% 
  select(STUDYID, USUBJID, AGE, SEX, RACE, ARM) %>% 
  filter(AGE >= 70,
         SEX == "F") %>% 
  arrange(AGE, ARM)

all.equal(adsl_arrange, adsl_pipe)

# the result is the same.







# we can use the rename function to change the name of columns: 

adsl_pipe %>%
  rename(
    NEW_AGE = AGE,
    NEW_SEX = SEX
)











