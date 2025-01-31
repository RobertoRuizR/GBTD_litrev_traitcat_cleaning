library(tidyverse) # Easily Install and Load the 'Tidyverse'
library(annotater) # Annotate Package Load Calls

# Get citation information and bind tibbles
scholar <- read_csv("data/raw/literature_review/scholar.csv")
scholar$CitesPerYear <- as.character(scholar$CitesPerYear)

scopus <- read_csv("data/raw/literature_review/scopus.csv")
scopus$CitesPerYear <- as.character(scopus$CitesPerYear)

wos <- read_csv("data/raw/literature_review/wos.csv")
wos$CitesPerYear <- as.character(wos$CitesPerYear)

citations <- bind_rows(scholar, scopus, wos)

# Clean citation data
tidy_ct <- citations |>
  distinct(Title, .keep_all = T) |> #Remove duplicates
  filter(!is.na(Year) & !is.na(Source) & !is.na(Publisher)) |> #Remove empty fields
  filter(!str_detect(Source, "Conference|Forum|Universe|Astrophysical|Astronomy|X-ray|X-Ray|bioRxiv|BioRxiv|arXiv|Medical|Authorea|Electronics|Industrial|Addiction|Law|Children|Patent|Fuel|Epiphany|Legal|Available|Congress|magnetic|EURASIP|Technology|IEEE|Neurocomputing|EPA|Engineering|Theological|Poet|Future|Drug|Energies|policy|Experientia|Nutrients|Intelligence|Physician|Network|Reform|Expert|Administration|Briefings|Pentagon|Computational|Entropy")) |> # Remove irrelevant results Source
  filter(!str_detect(Publisher, "onepetro|ebooks")) |> # Remove irrelevant publisher results
  filter(!str_detect(Title, "adipose|fat|poetry|GABA|Basophil|galaxies|gamma-ray|Combustion|UAV|Dances|cigarette|Cigarette|industrial|Brownian|President|magnetic|director|Children|carbon|CO2|Smoking|Court|package|cloning|Twitter|X-ray|Judges|archaeal|engagement|amnesic|adiposity|economic|benzene|policy|Internet|Education|stance|WAN|Diffusion|Passwords|Virtual|TECHNOLOGIES|eyetracking|Eye-Tracking|CCS|cluster")) |> # Remove irrelevant results Title
  filter(!str_detect(textcat::textcat(Title), "slovenian-iso8859_2|french")) # Remove slovenian and french

# Import citation data from manual search imported to Zotero collections
b_r <- read_csv("data/raw/literature_review/Bats_Reviews.csv")
b_d <- read_csv("data/raw/literature_review/Bats_Databases.csv")
b_t <- read_csv("data/raw/literature_review/Bats_Traits.csv")
d_t <- read_csv("data/raw/literature_review/Databases_Traits.csv")

# standardize columns to character columns
b_r$`Date Added` <- as.character(b_r$`Date Added`)
b_d$`Date Added` <- as.character(b_d$`Date Added`)
b_t$`Date Added` <- as.character(b_t$`Date Added`)
d_t$`Date Added` <- as.character(d_t$`Date Added`)

b_r$`Date Modified` <- as.character(b_r$`Date Modified`)
b_d$`Date Modified` <- as.character(b_d$`Date Modified`)
b_t$`Date Modified` <- as.character(b_t$`Date Modified`)
d_t$`Date Modified` <- as.character(d_t$`Date Modified`)

b_r$`Access Date` <- as.character(b_r$`Access Date`)
b_d$`Access Date` <- as.character(b_d$`Access Date`)
b_t$`Access Date` <- as.character(b_t$`Access Date`)
d_t$`Access Date` <- as.character(d_t$`Access Date`)

b_r$`Issue` <- as.character(b_r$`Issue`)
b_d$`Issue` <- as.character(b_d$`Issue`)
b_t$`Issue` <- as.character(b_t$`Issue`)
d_t$`Issue` <- as.character(d_t$`Issue`)

b_r$`Volume` <- as.character(b_r$`Volume`)
b_d$`Volume` <- as.character(b_d$`Volume`)
b_t$`Volume` <- as.character(b_t$`Volume`)
d_t$`Volume` <- as.character(d_t$`Volume`)

# Bind Zotero citation information
zote <- bind_rows(b_d, b_r, b_t, d_t)

# Join both datasets by matching columns
tidy_zote <- zote |>
  distinct(Title, .keep_all = T) |>
  rename(Year = `Publication Year`) |>
  rename(Source = `Publication Title`)

# Add column to track origin of citation and select matching columns
pruned_ct <- tidy_ct |> select("Title",     "Year",      "Source",    "Publisher", "Type",      "DOI",       "ISSN",      "Volume",    "Issue")
pruned_zote <- tidy_zote |> select("Title",     "Year",      "Source",    "Publisher", "Type",      "DOI",       "ISSN",      "Volume",    "Issue")

pruned_ct <- mutate(pruned_ct, phase = "first_phase") # Publish or Perish output
pruned_zote <- mutate(pruned_zote, phase = "second_phase") # Zotero collections

pruned_ct$Volume <- as.character(pruned_ct$Volume)
pruned_ct$Issue <- as.character(pruned_ct$Issue)

# Bind both phases of literature search
both_citations <- bind_rows(pruned_ct, pruned_zote)

# Remove duplicates
tidy_both <- both_citations |>
  distinct(Title, .keep_all = T)

# Duplicates not removed automatically (remove second option):

tidy_both[1,1]
tidy_both[164,1]

tidy_both[40,1]
tidy_both[64,1]

tidy_both[89,1]
tidy_both[253,1]

tidy_both[6,1]
tidy_both[317,1]

tidy_both <- tidy_both[-c(164, 64, 253, 317),]

# For screening purposes, create columns to evaluate if the word "bat" AND/OR "trait" (or any variant) is present in the title of the publication
tidy_both <- mutate(tidy_both, includes_bats_in_title = NA)
tidy_both <- mutate(tidy_both, includes_traits_in_title = NA)

tidy_both$includes_bats_in_title <- ifelse(str_detect(tidy_both$Title, "Bats|bats|bat|Bat"), "yes", "no")
tidy_both$includes_traits_in_title <- ifelse(str_detect(tidy_both$Title, "Traits|traits|Trai|trait"), "yes", "no")

tidy_both <- tidy_both |>
  relocate(includes_bats_in_title, .after = Title) |>
  relocate(includes_traits_in_title, .before = Year)

# Export clean citations file.
# This is the file which will be used for manual screening. Reasoning for manual exclusion is detailed in the "citation_metadata" file
write_csv(tidy_both, "data/processed/literature_review/export_clean_citations.csv")

# Import processed data sheet (clean_citations_v1)
citations <- read_csv("data/processed/literature_review/export_clean_citations_v1.csv")

# Keep only publications with bat functional trait data
citations_v1 <- citations |>
  filter(to_keep == "yes")  |>
  filter(includes_trait_info == "yes") |>
  filter(fully_included_in_another_source == "no") |>
  select(Title, Year, Source, DOI, directly_available) |>
  filter(!is.na(DOI)) # Filter out Geiselman & Sherman batbase.org as it doesn't have a DOI


#### Export citation data as BibTex file
dois <- citations_v1$DOI

# Use cr_cn() to get BibTeX files for my DOIs
my_citations_bibtex <- rcrossref::cr_cn(dois, format = "bibtex") %>%
  purrr::map_chr(., purrr::pluck, 1)


# write to bibtex file
writeLines(my_citations_bibtex, "bib/literature_review/literature_review_references_v1.bib") # Add Geiselman & Sherman BatBase bib manually

