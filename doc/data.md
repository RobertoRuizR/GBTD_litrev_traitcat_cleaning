Files in data/raw/literature_review folder:

-   Entries obtained using Harzig's Publish or Perish software:
    -   *scholar.csv*: Entries obtained from Google Scholar (n = 493).
    -   *scopus.csv*: Entries obtained from Scopus (n = 31).
    -   *wos.csv*: Entries obtained from Web of Science (n = 14).
-   Entries obtained by searching Clarivate's Web of Science manually. Format is ZoteroCollection_ZoteroSubcollection:
    -   *Bats_Databases.csv*: n = 14
    -   *Bats_Reviews.csv*: n = 168
    -   *Bats_Traits.csv*: n = 26
    -   *Databases_Traits*: n = 51

Files included in data/processed/literature_review folder:

-   *export_clean_citations.csv*: Citation data obtained from both literature searches. This file does not include entries removed using automated tools, nor it contains duplicated entries
-   *export_clean_citations_v1.csv:* Citation data screened manually to exclude entries which:
    -   Are not databases, review articles, or articles containing trait data from biological collections or long term studies.
    -   Do not include trait data.
    -   Are included in a study already included.
    -   For a detailed glossary of terms used view metadata/literature_search/literature_search_glossary.csv.

<br>

Files included in data/raw/trait_categories folder:

-   *ETS_Bat_Traits.xlsx*: Excel file where each sheet contains functional trait metadata from each study, harmonized following the Ecological Trait-data Standard (Schneider et al., 2019).
    -   *Definitions*: Trait data definitions obtained from Schneider et al., (2019).
    -   *trait_overlap*: Overlap of trait names (rows) as retrieved from each study (columns).
        -   *trait_overlap_zoosum*: This data sheet is the same as trait_overlap, the only difference is that in this sheet each trait reported in the studies included in Gonçalvez-Souza et al., 2023 are summarized in the column named *Gonçalvez-Souza_2023*.
    -   *trait_info*: Trait data descriptors as obtained from the data study consulted. Each study is stacked on top of each other for data summarizing purposes.
        -   *trait_info_zoosum*: This data sheet is the same as trait_info, the only difference is that in this sheet each study included in Gonçalvez-Souza et al., 2023 has *Gonçalvez-Souza_2023* in *fa_y* instead of the original study's first author and publication year.
    -   Each following sheet is the metadata of the functional traits as reported in any given study with column names taken from the Ecological trait-data standard (Scheider et al., 2019). Sheet names are reported as *FirstAuthor_Year*.
-   *trait_info.csv*: Trait data descriptors as obtained from the study consulted. Each study is stacked on top of each other for data summarizing purposes.
    -   Corresponds to *trait_info_zoosum* sheet in *ETS_Bat_Traits.xlsx*.
-   *trait_overlap.csv*: Overlap of trait names (rows) as retrieved from the study (columns).
    -   Corresponds to *trait_overlap_zoosum* sheet in *ETS_Bat_Traits.xlsx*.

Files included in data/processed/trait_categories folder:

-   *trait_type_count.csv:* Number of functional traits included by trait type.
-   *trait_dimension_count.csv:* Number of functional traits by complex or functional dimension.
-   *trait_overlap_summary.csv:* Summary of traits reported in the studies consulted for the trait selection process. The column names label, type, units, allowed_values_min, allowed_values_max, and description were taken from the traits.build package (Wenk et al., 2024).
