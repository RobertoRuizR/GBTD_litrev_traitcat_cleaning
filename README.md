# Global Bat Trait Database: Literature review and trait selection process

- [Overview](#overview)
- [File organization](#file-organization)
  - [Data](#data)
  - [Metadata](#metadata)
  - [Output](#output)
  - [Scripts](#scripts)
  - [References](#references)
- [License](#license)

## Overview

This document compiles the code and data used for the literature review and functional trait selection process needed for the creation of a Global Bat Trait Database. This database is part of the first chapter of the PhD thesis "*Assessment of knowledge gaps in bats: A macroecological perspective*" which is being carried out by [Roberto Antonio Ruiz-Ramírez](https://maevolab.mx/authors/roberto/) at the [Evolutionary Macroecology Lab](https://maevolab.mx/).

This repository is a work in progress maintained by Roberto A. Ruiz-Ramírez. If you have any questions or inquiries regarding the use of this document, please write to: [roberto.ruiz\@posgrado.ecologia.edu.mx](mailto:roberto.ruiz@posgrado.ecologia.edu.mx)

A detailed report of the data, methodology, and references used can be found in the following [Quarto document](https://robertoruizr.github.io/GBTD_litrev_traitcat_cleaning/).

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

- Entries obtained during the literature search:
  - *Scholar_search_YYYY-MM-DD.csv*: Entries obtained from Google Scholar (n = 268).
  - *Wos_search_YYYY-MM-DD.csv*: Entries obtained from Web of Science (n = 300).
  - *manual_search_YYYY-MM-DD.csv*: Entries obtained from manual citation searching relevant publications (n = 51).

Files included in data/processed/literature_review folder:

- *export_clean_citations.csv*: Citation data obtained from the literature search. This file does not include entries removed using automated tools, nor it contains duplicated entries
- *export_clean_citations_v1.csv:* Citation data screened manually to exclude entries which:
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

- *table_literature_search.html*: List of entries obtained during the literature search of entries which contain bat functional trait data.
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

- *literature_review_references_v1*: List of references obtained from the literature review carried out for the obtention of bat functional trait data. Reported as . bib and .docx files.

Files in bib/trait_categories folder:

- *trait_categories_references:* References used for the selections of bat functional traits to be evaluated. Reported as . bib, .csv, and .docx files.

## License

The contents of this repository are made available under the Open Data Commons Attribution License (ODC-By): http://opendatacommons.org/licenses/by/1.0/
