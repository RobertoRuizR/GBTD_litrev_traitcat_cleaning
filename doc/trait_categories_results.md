A total of 345 different traits were identified in the studies consulted (Table 3). Four trait types are represented: Morphological (n traits = 70), Life history (n traits = 259), Genetic (n traits = 9), and Interactions (n traits = 7). The types are subdivided in 17 complexes or functional dimensions: Size, Wings, Pollex, Hindlimbs, Head, and Tail (Morphological); Reproductive, Physiological, Behavioral, Trophic niche, Spatial niche, Echolocation, Conservation, and Threats (Life history); Genetic composition (Genetic); and Ecological interactions and Pathogens (Interactions).

```{r Trait list, echo=FALSE, message=FALSE, fig.cap= "Trait representation list"}

library(tidyverse)
library(ggh4x)
library(kableExtra)

# Import clean trait overlap summary csv
trait_summary <- read_csv("data/processed/trait_categories/trait_overlap_summary.csv")

# Order types and dimensions
trait_summary$trait_type <- fct_relevel(trait_summary$trait_type, c("Morphological", "Life history",  "Genetic",       "Interactions"))
trait_summary$complex_or_functional_dimension <- fct_relevel(trait_summary$complex_or_functional_dimension, c("Size", "Wings", "Pollex", "Hindlimbs", "Head", "Tail", "Reproductive", "Physiological", "Behavioral", "Trophic niche", "Spatial niche", "Echolocation", "Genetic composition", "Ecological interactions", "Conservation", "Threats", "Pathogens"))


# Get html tables for the full list of traits and where they are represented
trait_summary[c(1:4,7,12,5)] |>
  kbl(caption = "Table 3. Full list of traits represented the studies consulted. Times represented: Number of times a trait is found in the studies; Description: Trait description as found in the study consulted; Represented in (FirstAuthor_Year): Studies where a trait is included.", col.names = c("Trait type",	"Complex or functional dimension",	"Label",	"Times represented",	"Variable type",	"Description",	"Represented in (FirstAuthor_Year)")) |>
  kable_styling(full_width = F, html_font = "Calibri", fixed_thead = T, font_size = 16, position = "center") |>
  column_spec(1:2, bold = T) |>
  footnote(general = "The trait name, type, and description were extracted from the first citation of the respective <<Represented in>> column and are reported as written in the study consulted.", footnote_as_chunk = T) |>
  scroll_box(width = "1300px", height = "500px")

```

<br> <br>

The trait types better represented are the Morphological (n traits = 70) and Life history (n traits = 259) types. Each of which has 6 and 8 complexes or functional dimensions, respectively (Figure 3).

```{r histogram, echo=FALSE, message=FALSE, warning = FALSE, fig.cap= "Figure 3. Total number of times a functional trait is represented in the studies consulted"}

# Represented full
trait_summary |>
  ggplot(aes(interaction(complex_or_functional_dimension, trait_type), times_represented)) +
  geom_col() +
  guides(x = "axis_nested") +
  theme(axis.text.x =  element_text(angle = 90, size = 9), aspect.ratio = 4/10) +
  labs(x = "Trait type and dimension", y = "Number of times represented")
```

<br> <br>
