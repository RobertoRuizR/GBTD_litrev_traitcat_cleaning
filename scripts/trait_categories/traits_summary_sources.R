library(tidyverse)
library(ggh4x)
library(kableExtra)

# Import clean trait overlap summary csv
trait_summary <- read_csv("data/processed/trait_categories/trait_overlap_summary.csv")

# Order types and dimensions
trait_summary$trait_type <- fct_relevel(trait_summary$trait_type, c("Morphological", "Life history",  "Genetic",       "Interactions"))
trait_summary$complex_or_functional_dimension <- fct_relevel(trait_summary$complex_or_functional_dimension, c("Size", "Wings", "Pollex", "Hindlimbs", "Head", "Tail", "Reproductive", "Physiological", "Behavioral", "Trophic niche", "Spatial niche", "Echolocation", "Genetic composition", "Ecological interactions", "Conservation", "Threats", "Pathogens"))

#### HISTOGRAMS ####
# Represented full
trait_summary |>
  ggplot(aes(interaction(complex_or_functional_dimension, trait_type), times_represented)) +
  geom_col() +
  guides(x = "axis_nested") +
  theme(axis.text.x =  element_text(angle = 90, size = 10)) +
  labs(x = "Trait type and dimension", y = "Number of times represented", title = "Total number of times a functional trait is represented in the studies")

ggsave("output/trait_categories/type_dimensions_hist_full.png", width = 2500, height = 2000, units = "px")

# Represented twice or more
trait_summary[trait_summary$times_represented > 2, c(1:4,7,12,5)] |>
  ggplot(aes(interaction(complex_or_functional_dimension, trait_type), times_represented)) +
  geom_col() +
  guides(x = "axis_nested") +
  theme(axis.text.x =  element_text(angle = 90, size = 10)) +
  labs(x = "Trait type and dimension", y = "Number of times represented", title = "Number of times a functional trait is represented in 2 or more studies")

ggsave("output/trait_categories/type_dimensions_hist_2plus.png", width = 2500, height = 2000, units = "px")

# Represented once
trait_summary[trait_summary$times_represented == 1, c(1:4,7,12,5)] |>
  ggplot(aes(interaction(complex_or_functional_dimension, trait_type), times_represented)) +
  geom_col() +
  guides(x = "axis_nested") +
  theme(axis.text.x =  element_text(angle = 90, size = 10)) +
  labs(x = "Trait type and dimension", y = "Number of times represented", , title = "Number of times a functional trait is represented in 1 study")

ggsave("output/trait_categories/type_dimensions_hist_1db.png", width = 2500, height = 2000, units = "px")

# Represented once in Castillo-Figueroa & Pérez-Torres (2021)
trait_summary |>
  filter(times_represented == 1) |>
  filter(!represented_in == "castillo_figueroa_2021") |>
  select(c(1:4,7,12,5)) |>
  ggplot(aes(interaction(complex_or_functional_dimension, trait_type), times_represented)) +
  geom_col() +
  guides(x = "axis_nested") +
  theme(axis.text.x =  element_text(angle = 90, size = 10)) +
  labs(x = "Trait type and dimension", y = "Number of times represented", title = "Number of times a functional trait is represented only in Castillo-Figueroa & Pérez-Torres (2021)")

ggsave("output/trait_categories/type_dimensions_hist_cf2021.png", width = 2500, height = 2000, units = "px")


#### HTML TABLES ####
# Get html tables for the list of traits and where they are represented

# Get html table for the full list of traits represented
trait_summary[c(1:4,7,12,5)] |>
  kbl(caption = "Table 1. Full list of traits represented in the studies consulted. Times represented: Number of times a trait is found in the studies; Variable type: Type of variable as reported in the study (numerical or categorical); Description: Trait description as found in database; Represented in (FirstAuthor_Year): Studies where a trait is included.", col.names = c("Trait type",	"Complex or functional dimension",	"Label",	"Times represented",	"Variable type",	"Description",	"Represented in (FirstAuthor_Year)")) |>
  kable_styling(full_width = F, html_font = "Calibri", fixed_thead = T, font_size = 16, position = "center") |>
  column_spec(1:2, bold = T) |>
  footnote(general = "The trait name, type, and description were extracted from the first citation of the respective represented_in list. Trait names are reported as written in the study consulted.", footnote_as_chunk = T)|>
  save_kable(file = "output/trait_categories/table_trait_sources_full.html", self_contained = T)

# Get html table for the list of traits represented twice or more
trait_summary[trait_summary$times_represented > 1, c(1:4,7,12,5)] |>
  kbl(caption = "Traits represented in 2 or more studies. Times represented: Number of times a trait is found the studies; Variable type: Type of variable as reported in the study (numerical or categorical); Description: Trait description as found in database; Represented in (FirstAuthor_Year): Studies where a trait is included.", col.names = c("Trait type",	"Complex or functional dimension",	"Label",	"Times represented",	"Variable type",	"Description",	"Represented in (FirstAuthor_Year)")) |>
  kable_styling(full_width = F, html_font = "Calibri", fixed_thead = T, font_size = 16, position = "center") |>
  column_spec(1:2, bold = T) |>
  footnote(general = "The trait name, type, and description were extracted from the first citation of the respective represented_in list. Trait names are reported as written in the study consulted.", footnote_as_chunk = T)|>
  save_kable(file = "output/trait_categories/table_trait_sources_2plus.html", self_contained = T)

# Get html table for the list of traits represented once
trait_summary[trait_summary$times_represented == 1, c(1:4,7,12,5)] |>
  kbl(caption = "Traits represented only in one study. Times represented: Number of times a trait is found the studies; Variable type: Type of variable as reported in the study (numerical or categorical); Description: Trait description as found in database; Represented in (FirstAuthor_Year): Studies where a trait is included.", col.names = c("Trait type",	"Complex or functional dimension",	"Label",	"Times represented",	"Variable type",	"Description",	"Represented in (FirstAuthor_Year)")) |>
  kable_styling(full_width = F, html_font = "Calibri", fixed_thead = T, font_size = 16, position = "center") |>
  column_spec(1:2, bold = T) |>
  footnote(general = "The trait name, type, and description were extracted from the first citation of the respective represented_in list. Trait names are reported as written in the study consulted.", footnote_as_chunk = T)|>
  save_kable(file = "output/trait_categories/table_trait_sources_1db.html", self_contained = T)

# Get html table for the list of traits represented once in Castillo-Figueroa & Pérez-Torres (2021)
trait_summary[trait_summary$times_represented == 1, c(1:4,7,12,5)] |>
  kbl(caption = "Traits represented only in Castillo-Figueroa & Pérez-Torres (2021). Times represented: Number of times a trait is found the studies; Variable type: Type of variable as reported in the study (numerical or categorical); Description: Trait description as found in database; Represented in (FirstAuthor_Year): Studies where a trait is included.", col.names = c("Trait type",	"Complex or functional dimension",	"Label",	"Times represented",	"Variable type",	"Description",	"Represented in (FirstAuthor_Year)")) |>
  kable_styling(full_width = F, html_font = "Calibri", fixed_thead = T, font_size = 16, position = "center") |>
  column_spec(1:2, bold = T) |>
  footnote(general = "The trait name, type, and description were extracted from the first citation of the respective represented_in list. Trait names are reported as written in the study consulted.", footnote_as_chunk = T)|>
  save_kable(file = "output/trait_categories/table_trait_sources_cf2021.html", self_contained = T)


# Get statistics for trait types and dimensions from summary table
dimension_summary <-trait_summary[,1:2] |>
  add_count(complex_or_functional_dimension) |>
  distinct(complex_or_functional_dimension, .keep_all = T) |>
  arrange(trait_type)

type_summary <- trait_summary[,1:2] |>
  count(trait_type)

# Write dimension_summary csv file to disk
write_csv(dimension_summary, "data/processed/trait_categories/trait_dimension_count.csv")

# Write type_summary csv file to disk
write_csv(type_summary, "data/processed/trait_categories/trait_type_count.csv")


#### Trait types and dimensions total count
types_dims <- readxl::read_excel("metadata/trait_categories/trait_categories_glossary.xlsx", sheet = "traits_types_dimensions", range = "A2:E23")

types_dims[5:21, c(2:3,5)] |>
  kbl(caption = "Trait types and complex or functional dimensions.", col.names = c("Trait type", "Complex or functional dimension", "Study")) |>
  kable_styling(full_width = F, html_font = "Calibri", fixed_thead = T, font_size = 16) |>
  column_spec(1:2, bold = T) |>
  collapse_rows(columns = 1:2, valign = "middle") |>
  save_kable(file = "output/trait_categories/table_types_dimensions_sources.html", self_contained = T)

# Import clean trait overlap summary csv
trait_sources <- read_csv("bib/trait_categories/trait_categories_references.csv")

trait_sources |>
  filter(trait_sources[7] == "no") |>
  select(c(5:6, 8)) |>
  kbl(caption = "Studies used for the selection of bat functional traits", col.names = c("Citation", "Title", "Published in")) |>
  kable_styling(full_width = F, html_font = "Calibri", fixed_thead = T, font_size = 16)
