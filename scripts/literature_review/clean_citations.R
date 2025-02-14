library(tidyverse) # Easily Install and Load the 'Tidyverse'
library(annotater) # Annotate Package Load Calls
library(janitor)

# Get citation information and bind tibbles

scholar <- read_csv("data/raw/literature_review/Scholar_search_2025-02-11.csv")
wos <- read_csv("data/raw/literature_review/WoS_search_2025-02-11.csv")
manual <- read_csv("data/raw/literature_review/manual_search_2025-02-11.csv")

scholar1 <- scholar |>
  rename("pub_type" = `Item Type`) |>
  rename("authors" = "Author") |>
  rename("year" = "Publication Year") |>
  rename("title" = "Title") |>
  rename("source" = "Publication Title") |>
  rename("publisher" = "Library Catalog") |>
  rename("doi" = "DOI") |>
  mutate("s" = "s2") |>
  select(pub_type, authors, year, title, source, publisher, doi, s)

wos1 <- wos |>
  rename("pub_type" = `Document Type`) |>
  rename("authors" = "Authors") |>
  rename("year" = "Publication Year") |>
  rename("title" = "Article Title") |>
  rename("source" = "Source Title") |>
  rename("publisher" = "Publisher") |>
  mutate("doi" = NA) |>
  mutate("s" = "auto") |>
  select(pub_type, authors, year, title, source, publisher, doi, s)

manual1 <- manual |>
  rename("pub_type" = `Item Type`) |>
  rename("authors" = "Author") |>
  rename("year" = "Publication Year") |>
  rename("title" = "Title") |>
  rename("source" = "Publication Title") |>
  rename("publisher" = "Library Catalog") |>
  rename("doi" = "DOI") |>
  mutate("s" = "manual") |>
  select(pub_type, authors, year, title, source, publisher, doi, s)  

citations <- bind_rows(scholar1, wos1, manual1)

rm(scholar, wos, manual)

# Add descriptive column names for manual screening
citations <- citations |>
  mutate(includes_bats_in_title = NA,
         includes_traits_in_title= NA, 
         to_keep= NA, 
         includes_trait_info= NA, 
         directly_available= NA, 
         fully_included_in_another_source= NA,  .after = title) |>
  mutate(lowercase = str_squish(str_replace_all(str_to_lower(title), "-|‐|–|:|;|'|’|—", " ")), .after = title)

# Clean citation data
tidy_ct <- citations |>
  distinct(lowercase, .keep_all = T) |> #Remove duplicates
  filter(!is.na(year)) #Remove empty fields

# For screening purposes, create columns to evaluate if the word "bat" AND/OR "trait" (or any variant) is present in the title of the publication
tidy_ct$includes_bats_in_title <- ifelse(str_detect(tidy_ct$title, "Bats|bats|bat|Bat"), "yes", "no")
tidy_ct$includes_traits_in_title <- ifelse(str_detect(tidy_ct$title, "Traits|traits|Trai|trait"), "yes", "no")

# Dupes gives me the studies found in both searches
dupes <- tidy_ct |>
  get_dupes(lowercase) |>
  distinct(lowercase, .keep_all = T) |>
  select(-dupe_count) |>
  relocate(lowercase, .after = title)

dupes$s <- "dupes"

# Export clean citations file.
# This is the file which will be used for manual screening. Reasoning for manual exclusion is detailed in the "citation_metadata" file

write_csv(tidy_ct, "data/processed/literature_review/export_clean_citations.csv")

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

