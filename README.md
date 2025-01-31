---
output: github_document
---

# GlobalBatTraitDatabase: Literature review and trait selection process

- [Introduction](#introduction)
- [Methodology](#methodology)
  - [Literature review](#literature-review)
  - [Functional trait selection process](#functional-trait-selection-process)
- [Preliminary results](#preliminary-results)
  - [Literature review](#literature-review-1)
  - [Functional trait selection process](#functional-trait-selection-process-1)
- [Points to discuss](#points-to-discuss)
- [References](#references)
- [File organization](#file-organization)
  - [Data](#data)
  - [Metadata](#metadata)
  - [Output](#output)
  - [Scripts](#scripts)
  - [References](#references-1)

## Introduction

This document compiles the code and data used for the literature review and functional trait selection process for the creation of a Global Bat Trait Database. This repository is maintained by Roberto A. Ruiz-Ramírez. Any questions or inquiries: [roberto.ruiz\@posgrado.ecologia.edu.mx](mailto:roberto.ruiz@posgrado.ecologia.edu.mx){.email}

This database is part of the first chapter of the PhD thesis "*Assessment of knowledge gaps in bats: a macroecological perspective*" which is being carried out by [Roberto Antonio Ruiz-Ramírez](https://maevolab.mx/authors/roberto/) at the [Evolutionary Macroecology Lab](https://maevolab.mx/){style="font-size: 11pt;"}. This chapter focuses on the assessment of knowledge gaps and biases in the information available on bat functional traits at a global level.

Functional traits (FT) – well-defined, measurable, morphophysiological and ecological characteristics that influence the fitness of individuals – have been used to model numerous ecological processes, as well as responses to environmental changes in diverse organisms and biological communities (Funk et al., 2017; Zakharova et al., 2019; Etard et al., 2020; Dawson et al., 2021). Thanks to their utility, their use has been extended to numerous taxonomic groups, unfortunately, the available information about species’ functional traits is incomplete (Rauenkerian shortfall; Hortal et al. 2015). Mainly, there are geographical biases (e.g. towards easily accessible areas) and taxonomic biases (e.g. towards abundant, easy-to-catch, or charismatic species) (Verde-Arregoitia, 2016; Troudet et al., 2017; dos Santos et al., 2020; Etard et al., 2020; García-Roselló et al., 2023). The lack of available information and existing biases limit the interpretation of results about the importance of FTs in a region or taxon studied, as well as the extrapolation and generalization to other regions or species not considered, therefore, the quantity and quality of the information must be evaluated (Zakharova et al., 2019; Etard et al., 2020). As in other organisms, a FT approach has recently been promoted for the study of bats and their responses to changes in their environment (Castillo-Figueroa & Pérez-Torres, 2021). However, despite their importance, to date there is no robust assessment of the completeness and geographic and taxonomic representativeness of functional traits for the order Chiroptera at a global level. Therefore, we ask the following question: Which are the most important gaps and biases in knowledge of the functional traits of the order Chiroptera at a global level? Given the available evidence on the gaps and biases found in trait assessments for several taxa, as well as in previous assessments made for specific dimensions of bat functional traits, we hypothesize that taxonomic and geographic biases will be found in the study of the bat functional trait towards taxa which are more easily captured and widely distributed, as well as towards the most accessible and studied areas.

The specific objectives of this chapter are: 1) to identify the gaps and biases in the knowledge of the functional traits of the order Chiroptera at a global level, and 2) to create a global bat functional trait database.

<br>
<br>

## Methodology

### Literature review

A literature search of the Web of Science and Scopus databases, and also the Google Scholar search engine, was conducted with Harzing’s Publish or Perish software using the following keywords: “bat review” OR “bat dataset” OR “bat global assessment” OR “bat traits” OR "bat functional traits" OR “bat meta-analysis” OR “bat data paper”. The inclusion criteria for entries included was:

1. Multi-taxa or specific studies that included information on bat functional traits

2. Secondary studies (e.g. databases and review articles). No publications from grey literature were considered..

3. Studies whose data was taken from biological collections and long term studies,.

4. Studies reported in the english or spanish languages.

5. Studies published in a scientific journal with an assigned impact factor.

<br>

The next series of steps were implemented in order to clean the citation data for the first phase of literature review (Figure 1):

1. The three files obtained in the first literature search (found in data/raw/literature_review/ as scholar.csv, scopus.csv, and wos.csv) were combined in the R environment (n left = 538).
2. Duplicate entries were removed (n left = 514).
3. Entries without any Source, Year, or Publisher information were removed (n left = 325).
4. Entries not related to bats (e.g. brown adipose tissue) were removed (n left = 163).
   - Keywords removed from the Source field: *Conference, Forum, Universe, Astrophysical, Astronomy, X-ray, X-Ray, bioRxiv, BioRxiv, arXiv, Medical, Authorea, Electronics, Industrial, Addiction, Law, Children, Patent, Fuel, Epiphany, Legal, Available, Congress, magnetic, EURASIP, Technology, IEEE, Neurocomputing, EPA, Engineering, Theological, Poet, Future, Drug, Energies, policy, Experientia, Nutrients, Intelligence, Physician, Network, Reform, Expert, Administration, Briefings, Pentagon, Computational, Entropy.*
   - Keywords removed from the Title field: *adipose, fat, poetry, GABA, Basophil, galaxies, gamma-ray, Combustion, UAV, Dances, cigarette, Cigarette, industrial, Brownian, President, magnetic, director, Children, carbon, CO2, Smoking, Court, package, cloning, Twitter, X-ray, Judges, archaeal, engagement, amnesic, adiposity, economic, benzene, policy, Internet, Education, stance, WAN, Diffusion, PasswordsVirtual, TECHNOLOGIES, eyetracking, Eye-Tracking, CCS, cluster*.
   - Keywords removed from the Publisher field: *donepetro, ebooks*.
5. Entries in a language other than english or spanish were removed (n left = 161).

A second phase of literature review was conducted by searching the Web of Science database using the following string search: (bat OR bats OR chiroptera) AND (review OR traits OR functional traits OR meta-analysis) NOT (vaccines OR biomaterial OR bio-medical OR brown adipose tissue OR therapeutics OR biosynthesis). The entries were reviewed up until page number 30 with the following results:

1. 259 entries were obtained
2. Duplicate entries were removed (n left = 233).
3. This dataset (second_phase) was combined with the previous dataset (first_phase) and duplicates were removed (n left = 379).
4. Entries were screened manually to discard any irrelevant publication (i.e. not related to bats) that was left behind by previous steps. (n left = 223).
   - *includes_bats_in_title*: Does the publication have the “bat” or any variation of the word in the title?
   - *includes_traits_in_title*: Does the publication have the “trait” or any variation of the word in the title?
   - *to_keep*: The publication is kept if it is a database, review, or a study which takes its data from biological collections or long term studies?
5. Each entry was manually screened in order to retain only entries with information on bat functional traits. (n left = 171).
   - *includes_trait_info*: Does the publication include bat functional trait data?
6. Each entry whose data comes from any other study considered in this literature search was discarded (n left = 157).
   - *fully_included_in_another_source*: Is the trait data fully obtained from any other study already included in the literature review?

```{r literature review selection process, fig.align = 'center', out.width = "100%", fig.cap = "Figure 1. PRISMA 2020 flow diagram for bat functional trait data retrieval for the creation of a Global Bat Trait Database", echo=FALSE, message=FALSE}

knitr::include_graphics(here::here("output/literature_review", "PRISMA_2020_flow_diagram.png"))

```

<br> <br>

### Functional trait selection process

A total of 12 studies were screened for the selection of the functional traits to be evaluated (Table 1). The proposal for a trait-based approach for the study of bats (Castillo-Figueroa & Pérez-Torres 2021) was used as a baseline to define the trait types, complex or functional dimensions, and traits to be evaluated. Full citation data is contained in the bib/trait_categories folder as .bib, .csv and .docx files. Studies were included if they were:

- A multi-taxa global compilation of functional trait data which includes bats.
- A bat-specific global compilation of functional trait data.
- A dimension-specific global compilation of bat functional trait data.

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

## Preliminary results

### Literature review

After the removal of duplicated and non relevant entries, a total of 157 studies were obtained from the literature search.

```{r Literature review list, echo=FALSE, message=FALSE, fig.cap= "Literature review"}

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
  select(Title, Year, Source, DOI, directly_available) |>
  kbl(caption = "Table 2. List of studies obtained from the literature review carried out for the extraction of bat functional trait data.", col.names = c("Title", "Year", "Study", "DOI", "Trait data directly available")) |>
  kable_styling(full_width = F, html_font = "Calibri", fixed_thead = T, font_size = 16) |>
  scroll_box(width = "1300px", height = "500px")

```

<br>
<br>

### Functional trait selection process

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

## Points to discuss

### Literature review

The creation of the database described is done using "only" data found in databases and review articles. The reason is simple: There are *too many traits* for *too many bats*. The present review, and subsequent database, aims to be the next step in the trait-based approach for the study of bats proposed by Castillo-Figueroa & Pérez-Torres. As such, it will be easy to access and to update, as the final goal is to be a dynamic repository of bat trait data.

The final database created should be dynamic and easy to contribute (e.g. ZooTraits, batbase.org, and ChiroVox).

### Trait selection process

The total number of times a trait is represented is affected by the different ways in which each source describes it. For example, the trait "Mating systems" is represented in Castillo-Figueroa & Pérez-Torres (2021) as a categorical variable with 4 levels: Monogamic, Polygyny, Polyandry, and Promiscuty; however, Cosentino et al., (2023) has Monogamic, Polygyny, Polyandry, and Promiscuty as separate categorical variables, each with two levels: 1 = yes, 2 = no (Table XX). In this example, this results in a variable representing the same trait being counted 5 times.

- In these cases, how should a variable be integrated in the database?

In the case of echolocation traits. Several data sources include echolocation variables such as: Frequency, number of harmonics, time in ms, and several other descriptors of any given echolocation pulse as separate traits. However, the vast majority of bat calls repositories available online "only" have the .wav files reported for any given species or genus included (e.g. ChiroVox). This gives the flexibility to extract any bat call parameter from the actual .wav file. This is most likely the reason for the echolocation traits being under represented in the data sources consulted.

- Given that the objective of the first chapter of this thesis is "to identify the gaps and biases in the knowledge of the functional traits of the order Chiroptera at a global level", how should these traits be integrated into the database?

<br>
<br>

## References

- Castillo-Figueroa, D., & Pérez-Torres, J. (2021). On the development of a trait-based approach for studying Neotropical bats. Papéis Avulsos de Zoologia, 61, e20216124. https://doi.org/10.11606/1807-0205/2021.61.24

- Dawson, S. K., Carmona, C. P., González-Suárez, M., Jönsson, M., Chichorro, F., Mallen-Cooper, M., Melero, Y., Moor, H., Simaika, J. P., & Duthie, A. B. (2021). The traits of “trait ecologists”: An analysis of the use of trait and functional trait terminology. Ecology and Evolution, 11(23), 16434–16445. https://doi.org/10.1002/ece3.8321

- dos Santos, J. W., Correia, R. A., Malhado, A. C. M., Campos-Silva, J. V., Teles, D., Jepson, P., & Ladle, R. J. (2020). Drivers of taxonomic bias in conservation research: A global analysis of terrestrial mammals. Animal Conservation, 23(6), 679–688. https://doi.org/10.1111/acv.12586

- Etard, A., Morrill, S., & Newbold, T. (2020). Global gaps in trait data for terrestrial vertebrates. Global Ecology and Biogeography, 29(12), 2143–2158. https://doi.org/10.1111/geb.13184

- Funk, J. L., Larson, J. E., Ames, G. M., Butterfield, B. J., Cavender-Bares, J., Firn, J., Laughlin, D. C., Sutton-Grier, A. E., Williams, L., & Wright, J. (2017). Revisiting the Holy Grail: Using plant functional traits to understand ecological processes. Biological Reviews, 92(2), 1156–1173. https://doi.org/10.1111/brv.12275

- García-Roselló, E., González-Dacosta, J., & Lobo, J. M. (2023). The biased distribution of existing information on biodiversity hinders its use in conservation, and we need an integrative approach to act urgently. Biological Conservation, 283, 110118. https://doi.org/10.1016/j.biocon.2023.110118

- Hortal, J., De Bello, F., Diniz-Filho, J. A. F., Lewinsohn, T. M., Lobo, J. M., & Ladle, R. J. (2015). Seven Shortfalls that Beset Large-Scale Knowledge of Biodiversity. Annual Review of Ecology, Evolution, and Systematics, 46(1), 523–549. https://doi.org/10.1146/annurev-ecolsys-112414-054400

- Schneider, F., Jochum, M., LeProvost, G., Ostrowski, A., Penone, C., & Simons, N. K. (2019). Ecological Trait-data Standard Vocabulary (v0.10). https://doi.org/10.5281/zenodo.2605377

- Troudet, J., Grandcolas, P., Blin, A., Vignes-Lebbe, R., & Legendre, F. (2017). Taxonomic bias in biodiversity data and societal preferences. Scientific Reports, 7(1), 9132. https://doi.org/10.1038/s41598-017-09084-6

- Verde Arregoitia, L. D. (2016). Biases, gaps, and opportunities in mammalian extinction risk research. Mammal Review, 46(1), 17–29. https://doi.org/10.1111/mam.12049

- Wenk, E., Bal, P., Coleman, D., Gallagher, R., Yang, S., & Falster, D. (2024). Traits.build: A data model, workflow and R package for building harmonised ecological trait databases. Ecological Informatics, 83, 102773. https://doi.org/10.1016/j.ecoinf.2024.102773

- Zakharova, L., Meyer, K. M., & Seifan, M. (2019). Trait-based modelling in ecology: A review of two decades of research. Ecological Modelling, 407, 108703. https://doi.org/10.1016/j.ecolmodel.2019.05.008

- Zamora-Gutierrez, V., Lopez-Gonzalez, C., MacSwiney Gonzalez, M. C., Fenton, B., Jones, G., Kalko, E. K. V., Puechmaille, S. J., Stathopoulos, V., & Jones, K. E. (2016). Acoustic identification of Mexican bats based on taxonomic and ecological constraints on call design. Methods in Ecology and Evolution, 7(9), 1082–1091. https://doi.org/10.1111/2041-210X.12556

- Zamora-Gutierrez, V., Ortega, J., Avila-Flores, R., Aguilar-Rodríguez, P. A., Alarcón-Montano, M., Avila-Torresagatón, L. G., Ayala-Berdón, J., Bolívar-Cimé, B., Briones-Salas, M., Chan-Noh, M., Chávez-Cauich, M., Chávez, C., Cortés-Calva, P., Cruzado, J., Cuevas, J. C., Del Real-Monroy, M., Elizalde-Arellano, C., García-Luis, M., García-Morales, R., … MacSwiney G., M. C. (2020). The Sonozotz project: Assembling an echolocation call library for bats in a megadiverse country. Ecology and Evolution, 10(11), 4928–4943. https://doi.org/10.1002/ece3.6245

<br>
<br>

## File organization

In order to document the data manipulation pipeline, the files obtained and produced were organized in several folders:

- *Data*: Contains the raw data used and the processed data obtained after manipulation.
- *Metadata*: Contains the glossaries of column names and definitions used during the literature review and trait selection process.
- *Output*: Contains tables and graphs generated.
- *Scripts*: Contains the R scripts used for data manipulation as well as tables and graphs generation.
- *References*: Contains the references obtained during the literature review and used during the trait selection process.

Each folder contains two sections: "*Literature review*" and "*Trait categories*".

- *Literature review*: Search of the published data sources where bat functional traits are included.
- *Trait categories*: This section includes the data and methodology used in order to compile, select, and clean the different functional traits to be evaluated.

### Data

Files in data/raw/literature_review folder:

- Entries obtained using Harzig's Publish or Perish software:
  - *scholar.csv*: Entries obtained from Google Scholar (n = 493).
  - *scopus.csv*: Entries obtained from Scopus (n = 31).
  - *wos.csv*: Entries obtained from Web of Science (n = 14).
- Entries obtained by searching Clarivate's Web of Science manually. Format is ZoteroCollection_ZoteroSubcollection:
  - *Bats_Databases.csv*: n = 14
  - *Bats_Reviews.csv*: n = 168
  - *Bats_Traits.csv*: n = 26
  - *Databases_Traits*: n = 51

Files included in data/processed/literature_review folder:

- *export_clean_citations.csv*: Citation data obtained from both literature searches. This file does not include entries removed using automated tools, nor it contains duplicated entries
- *export_clean_citations_v1.csv:* Citation data screened manually to exclude entries which:
  - Are not databases, review articles, or articles containing trait data from biological collections or long term studies.
  - Do not include trait data.
  - Are included in a study already included.
  - For a detailed glossary of terms used view metadata/literature_search/literature_search_glossary.csv.

<br>

Files included in data/raw/trait_categories folder:

- *ETS_Bat_Traits.xlsx*: Excel file where each sheet contains functional trait metadata from each study, harmonized following the Ecological Trait-data Standard (Schneider et al., 2019).
  - *Definitions*: Trait data definitions obtained from Schneider et al., (2019).
  - *trait_overlap*: Overlap of trait names (rows) as retrieved from each study (columns).
    - *trait_overlap_zoosum*: This data sheet is the same as trait_overlap, the only difference is that in this sheet each trait reported in the studies included in Gonçalvez-Souza et al., 2023 are summarized in the column named *Gonçalvez-Souza_2023*.
  - *trait_info*: Trait data descriptors as obtained from the data study consulted. Each study is stacked on top of each other for data summarizing purposes.
    - *trait_info_zoosum*: This data sheet is the same as trait_info, the only difference is that in this sheet each study included in Gonçalvez-Souza et al., 2023 has *Gonçalvez-Souza_2023* in *fa_y* instead of the original study's first author and publication year.
  - Each following sheet is the metadata of the functional traits as reported in any given study with column names taken from the Ecological trait-data standard (Scheider et al., 2019). Sheet names are reported as *FirstAuthor_Year*.
- *trait_info.csv*: Trait data descriptors as obtained from the study consulted. Each study is stacked on top of each other for data summarizing purposes.
  - Corresponds to *trait_info_zoosum* sheet in *ETS_Bat_Traits.xlsx*.
- *trait_overlap.csv*: Overlap of trait names (rows) as retrieved from the study (columns).
  - Corresponds to *trait_overlap_zoosum* sheet in *ETS_Bat_Traits.xlsx*.

Files included in data/processed/trait_categories folder:

- *trait_type_count.csv:* Number of functional traits included by trait type.
- *trait_dimension_count.csv:* Number of functional traits by complex or functional dimension.
- *trait_overlap_summary.csv:* Summary of traits reported in the studies consulted for the trait selection process. The column names label, type, units, allowed_values_min, allowed_values_max, and description were taken from the traits.build package (Wenk et al., 2024).

### Metadata

Files included in the metadata/literature_review folder:

- *literature_review_glossary.csv*: Names and descriptions of criteria for manual screening of the literature search results.

Files included in the metadata/trait_categories folder:

- *trait_categories_glossary.xlsx*: Glossaries of column names and definitions used during the trait selection process
  - *Schneider_2019*: Glossary of functional trait definitions as reported in the Ecological trait-data Standard. Used for column names in trait_info_zoosum.
  - *traits_types_dimensions*: Trait types and complex or functional dimensions of bat functional traits with sources.
  - *trait_overlap_summary*: Column names in *trait_overlap*. The column names label, type, units, allowed_values_min, allowed_values_max, and description were taken from the traits.build package (Wenk et al., 2024).

### Output

Files in output/literature_review folder:

- *table_literature_search.html*: Final list of entries obtained during the literature search of entries which contain bat functional trait data.
- *PRISMA_2020_flow_diagram*: PRISMA 2020 flow diagram for the literature search of entries which contain bat functional trait data. Reported as .docx, .pdf, and .png files.

Files in output/trait_categories folder:

- HTML table with trait types, functional dimensions, times a trait is represented in the studies, type of variable, description and citations for the:
  - *table_trait_sources_full.html:* Full list of traits obtained
  - *table_trait_sources_2plus.html:* Traits reported in 2 or more studies
  - *table_trait_sources_eq1.html*: Traits reported in only one study besides the proposal made by Castillo-Figueroa & Pérez-Torres (2021)
  - *table_trait_sources_cf2021.html:* Traits reported only in the proposal made by Castillo-Figueroa & Pérez-Torres (2021).
- Histogram of the total of times a functional trait is reported in the studies consulted by trait type and complex or functional dimension for the:
  - *type_dimensions_hist_full.png*: Full list of traits obtained
  - *type_dimensions_hist_2plus.png:* Traits reported in 2 or more studies
  - *type_dimensions_hist_1db.png*: Traits reported in only one study besides the proposal made by Castillo-Figueroa & Pérez-Torres (2021)
  - *type_dimensions_hist_cf2021.png*: Traits reported only in the proposal made by Castillo-Figueroa & Pérez-Torres (2021).

The reasoning for isolating traits reported in one study is twofold: a) A trait reported only in the proposal made by Castillo-Figueroa & Pérez-Torres (2021) doesn’t contain any data, and b) a trait found only once is prone to skew the representativeness of the trait to a single study. Nevertheless, traits represented once, besides of Castillo-Figueroa & Pérez-Torres (2021) proposal, should be individually checked as they might be too bat-specific to be well represented in multi-taxa assessments.

### Scripts

Files in scripts/trait_categories folder:

- *traits.overlap.R*: R code used for data manipulation.
- *traits_summary_sources.R*: File used to store R code used to generate tables and graphs.

Files in scripts/literature_review folder:

- *clean_citations.R*: R code used for first phase of data cleaning, and .bib file exporting.

### References

Files in bib/literature_review folder:

- *literature_review_references_v1*: Final list of references obtained from the literature review carried out for the obtention of bat functional trait data. Reported as . bib and .docx files.

Files in bib/trait_categories folder:

- *trait_categories_references:* References used for the selections of bat functional traits to be evaluated. Reported as . bib, .csv, and .docx files.
