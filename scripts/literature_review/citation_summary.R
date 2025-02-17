library(tidyverse)
library(ggh4x)
library(kableExtra)

# Import clean citation csv
citation_list <- read_csv("data/processed/literature_review/export_clean_citations_v1.csv")

# Generate kable of final list
citation_list |>
  filter(to_keep == "yes")  |>
  filter(includes_trait_info == "yes") |>
  filter(fully_included_in_another_source == "no") |>
  select(title, year, source, doi, directly_available) |>
  kbl(caption = "Preliminary list of studies obtained from the literature review.", col.names = c("Title", "Year", "Study", "DOI", "Trait data directly available")) |>
  kable_styling(full_width = F, html_font = "Calibri", fixed_thead = T, font_size = 16) |>
  save_kable(file = "output/literature_review/table_literature_search.html", self_contained = T)
