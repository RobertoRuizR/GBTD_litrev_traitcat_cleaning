A total of 12 studies were screened for the selection of the functional traits to be evaluated (Table 1). The proposal for a trait-based approach for the study of bats (Castillo-Figueroa & Pérez-Torres 2021) was used as a baseline to define the trait types, complex or functional dimensions, and traits to be evaluated. Full citation data is contained in the bib/trait_categories folder as .bib, .csv and .docx files. Studies were included if they were:

-   A multi-taxa global compilation of functional trait data which includes bats.
-   A bat-specific global compilation of functional trait data.
-   A dimension-specific global compilation of bat functional trait data.

In addition to wing morphology traits, echolocation traits are also highly relevant for the study of bat ecology and conservation (Zamora et al., 2016; Zamora et al., 2020). However, the databases specialized for bat echolocation calls (e.g. ChiroVox) usually contain the .wav files instead of the extracted parameters reported in other databases (e.g. frequency of the call, interpulse duration, pulse duration, among others). For this reason, such databases are not included in the studies screened for the trait selection process.

The trait description information (e.g. trait name, type of variable, description) was obtained from each study when available. Names and definitions for the trait descriptors were obtained from the Ecological Trait-data Standard (Schneider et al., 2019). For a detailed glossary of terms view metadata/trait_categories/trait_categories_glossary.xlsx.

<br>

```{r Trait sources selection list, echo=FALSE, message=FALSE, warning=FALSE, tidy=FALSE}

library(tidyverse)

library(kableExtra)

# Import clean trait overlap summary csv
trait_sources <- read_csv("bib/trait_categories/trait_categories_references.csv")

trait_sources |>
  filter(trait_sources[7] == "no") |>
  select(c(5:6, 8)) |>
  kbl(caption = "Table 1. Studies used for the selection of bat functional traits", col.names = c("Citation", "Title", "Published in")) |>
  kable_styling(full_width = F, html_font = "Calibri", fixed_thead = T, font_size = 16)
  


```

<br> <br>

Once the trait descriptors from each study were obtained, the data sheets were combined by stacking the data on top of each other using the column names specified previously (Figure 1a). A new data sheet was generated where each row is a different functional trait and each column is a study (Figure 1b). If any given functional trait is included in two or more studies, they occupy the same row in a different column, each with the name assigned by the study indicated in the column header (Figure 1b). If any given trait is present in a study (Database A), but absent in another (Database B), the respective row in the Database B was left empty. Following this methodology, any additional functional trait reported in a study included afterwards will generate a new row without affecting the studies already included. The number of times in which any given trait was represented in all the studies was counted, and the descriptors of each trait were obtained from the first publication in which it was identified (Figure 1c).

```{r trait selection process, fig.align = 'center', out.width = "90%", fig.cap = "Figure 2. Workflow for the screening and selection of bat functional traits to be evaluated. The first two columns in b) and c) correspond to trait type and the trait complex or functional dimension following Castillo-Figueroa & Pérez-Torres (2021).", echo=FALSE, message=FALSE}

knitr::include_graphics(here::here("doc/images", "FirstChapter_TraitSelection.png"))

```

<br> <br>
