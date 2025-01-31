library(tidyverse) # Easily Install and Load the 'Tidyverse'
library(janitor) # Simple Tools for Examining and Cleaning Dirty Data
library(annotater) # Annotate Package Load Calls

# Get bat trait alignment info
# trait.overlap = Overlap from several trait names and categories from databases revised
trait.overlap <- read.csv("data/raw/trait_categories/trait_overlap_zoosum.csv")

trait.overlap <- trait.overlap %>%
  clean_names() |>
  mutate_all(na_if,"")


# trait.info = trait information from each source organized using the Ecological Trait Standard column names
trait.info <- read.csv("data/raw/trait_categories/trait_info_zoosum.csv")

trait.info$fa_y <- str_replace_all(str_to_lower(trait.info$fa_y), "ç", "c")
trait.info$fa_y <- str_replace_all(str_to_lower(trait.info$fa_y), "-", "_")

##### First integrate info from Zootraits
trait.summary <-   trait.overlap %>%
  rowwise() %>%
  mutate(label = list(detect(across(3:14), ~ !is.na(.x)))) %>%
  mutate(times_represented = sum(!is.na(across(3:14)))) %>%
  mutate(represented_in =   str_c(colnames(list(keep(across(3:14), ~!is.na(.x)))[[1]]), collapse = ", ") ) %>%
  mutate(first_represented_in =  list(colnames(.)[sum(as.integer(list(detect_index(across(3:14), ~!is.na(.x)))), 2)])) %>%
  filter(times_represented >= 1) %>%
  select("trait_type", "complex_or_functional_dimension", "label", "times_represented", "represented_in", "first_represented_in")

dimension_summary <-trait.summary[,1:2] |>
  add_count(complex_or_functional_dimension) |>
  distinct(complex_or_functional_dimension, .keep_all = T) |>
  arrange(trait_type)

dimension_summary1 <-trait.overlap[,1:2] |>
  add_count(complex_or_functional_dimension) |>
  distinct(complex_or_functional_dimension, .keep_all = T) |>
  arrange(trait_type)


# Calculate times any given trait is represented in the databases, and which ones, from the trait.overlap file
trait.summary <-   trait.overlap %>%
  rowwise() %>%
  mutate(label = list(detect(across(3:41), ~ !is.na(.x)))) %>%
  mutate(times_represented = sum(!is.na(across(3:41)))) %>%
  mutate(represented_in =   str_c(colnames(list(keep(across(3:41), ~!is.na(.x)))[[1]]), collapse = ", ") ) %>%
  mutate(first_represented_in =  list(colnames(.)[sum(as.integer(list(detect_index(across(3:41), ~!is.na(.x)))), 2)])) %>%
  filter(times_represented >= 1) %>%
  select("Trait type", "Complex or functional dimension", "label", "times_represented", "represented_in", "first_represented_in")

# Use the traits.build package column names for the new df
trait.summary %<>%
  mutate(type = NA) %>%
  mutate(allowed_values_levels = NA) %>% 
  mutate(units = NA) %>%
  mutate(allowed_values_min = NA) %>%
  mutate(allowed_values_max = NA) %>%
  mutate(description =   NA)


# Summarize each column from trait category overlap file
trait.summary$allowed_values_levels <- unlist(modify2(trait.summary$first_represented_in, trait.summary$label, \ (.x, .y) select(filter(trait.info, (fa_y == as_vector(.x)) ,  (trait == as_vector(.y))), factorLevels)), recursive = F)
trait.summary$description <- unlist(modify2(trait.summary$first_represented_in, trait.summary$label, \ (.x, .y) select(filter(trait.info, (fa_y == as_vector(.x)) ,  (trait == as_vector(.y))), traitDescription)), recursive = F)
trait.summary$type <- unlist(modify2(trait.summary$first_represented_in, trait.summary$label, \ (.x, .y) select(filter(trait.info, (fa_y == as_vector(.x)) ,  (trait == as_vector(.y))), valueType)), recursive = F)
trait.summary$units <- unlist(modify2(trait.summary$first_represented_in, trait.summary$label, \ (.x, .y) select(filter(trait.info, (fa_y == as_vector(.x)) ,  (trait == as_vector(.y))), expectedUnit)), recursive = F)
trait.summary$allowed_values_min <- unlist(modify2(trait.summary$first_represented_in, trait.summary$label, \ (.x, .y) select(filter(trait.info, (fa_y == as_vector(.x)) ,  (trait == as_vector(.y))), minAllowedValue)), recursive = F)
trait.summary$allowed_values_max <- unlist(modify2(trait.summary$first_represented_in, trait.summary$label, \ (.x, .y) select(filter(trait.info, (fa_y == as_vector(.x)) ,  (trait == as_vector(.y))), maxAllowedValue)), recursive = F)

# Fill blank row spaces in description and allowed_values_levels columns
trait.summary$description <- map(trait.summary$description, \ (.x) if_else(is.na(pluck(.x, 1)), "Definition not specified in database; Check in article for more details", pluck(.x, 1)))
trait.summary$allowed_values_levels <- map(trait.summary$allowed_values_levels, \ (.x) if_else(is.na(pluck(.x, 1)), "Numeric or not specified in database; Check in article for more details", pluck(.x, 1)))

trait.summary$description <- replace(trait.summary$description, trait.summary$description == "", "Definition not specified in database; Check in article for more details")

trait.summary$allowed_values_levels <- replace(trait.summary$allowed_values_levels, trait.summary$allowed_values_levels == "", ".na")
trait.summary$allowed_values_levels <- replace(trait.summary$allowed_values_levels, trait.summary$allowed_values_levels == ".na", "Numeric or not specified in database; Check in article for more details")



# Standardize each column as a character column
trait.summary$label <- as.character(trait.summary$label)
trait.summary$first_represented_in <-  as.character(trait.summary$first_represented_in)
trait.summary$type <- as.character(trait.summary$type)
trait.summary$units <- as.character(trait.summary$units)
trait.summary$description <- as.character(trait.summary$description)
trait.summary$allowed_values_min <- as.character(trait.summary$allowed_values_min)
trait.summary$allowed_values_max <- as.character(trait.summary$allowed_values_min)
trait.summary$allowed_values_levels <- as.character(trait.summary$allowed_values_levels)


# Write trait.summary csv file to disk
write_csv(trait.summary, "data/processed/trait_categories/trait_overlap_summary.csv")

# Write trait.sources csv file to disk
trait.sources <- distinct(trait.info[12:13], fa_y, .keep_all = T)
write_csv(trait.sources, "data/processed/trait_categories/trait_sources.csv")

# Create a BibTex file of sources used
# Use c() to create a vector of DOIs
my_dois <- c( "https://doi.org/10.11606/1807-0205/2021.61.24", 
               "https://doi.org/10.1002/ecy.3344",
               "https://doi.org/10.1038/s41597-023-02472-w",
               "https://doi.org/10.1038/s41597-023-02157-4",
               "https://doi.org/10.1111/mam.12270",
               "https://doi.org/10.1890/15-0846R.1",
               "https://doi.org/10.1002/ecy.2106",
               "https://doi.org/10.1038/s41597-022-01234-4",
               "https://doi.org/10.1046/j.1474-9728.2002.00020.x",
               "https://doi.org/10.1038/s41597-022-01364-9",
               "10.1007/s00442-020-04662-4",
               "10.1098/rspb.2018.2193",
               "10.1111/ecog.03654",
               "10.3390/d10030100",
               "10.1016/j.foreco.2018.02.028",
               "10.1016/j.biocon.2017.12.036",
               "10.4404/hystrix-00016-2017",
               "10.4404/hystrix-00020-2017",
               "10.1111/btp.12501",
               "10.3161/15081109ACC2017.19.2.005",
               "10.1111/2041-210X.12696",
               "10.7717/peerj.3424",
               "10.1016/j.biocon.2017.03.026",
               "10.1371/journal.pone.0166765",
               "10.1007/s00442-016-3671-9",
               "10.1111/1365-2664.12490",
               "10.1111/ddi.12277",
               "10.1111/geb.12192",
               "10.1007/s10980-012-9842-0",
               "10.1371/journal.pone.0056853",
               "10.1111/j.1365-2664.2012.02159.x",
               "10.1644/BWG-128",
               "10.3354/esr00156",
               "10.17151/bccm.2017.21.1.8",
               "10.12933/therya-17-463",
               "10.3390/D12060238",
               "10.31687/saremMN.19.26.1.0.09",
               "10.3161/15081109ACC2018.20.1.009")


# Use cr_cn() to get BibTeX files for my DOIs
my_citations_bibtex <- rcrossref::cr_cn(my_dois, format = "bibtex") %>%
  purrr::map_chr(., purrr::pluck, 1)

# write to bibtex file
writeLines(my_citations_bibtex, "bib/trait_categories/trait_categories_references.bib") # Add Geiselman & Sherman BatBase bib manually

# Slides purposes
sl <- clean_summary |>
  select(trait_type, complex_or_functional_dimension, label, times_represented, type, allowed_values_levels)