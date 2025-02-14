A literature search of the Web of Science database and Google Scholar search engine was conducted on February, 2025, using the following keywords: (bat OR bats OR chiropter\*) AND (review OR trait OR traits OR functional traits OR functional trait OR characteristic OR characteristics OR morphological OR life history). The literature search was not restricted in the date range and it included studies from 1966 up to 2025. Entries not related to bats were excluded from the search terms: (vaccines OR biomaterial OR bio-medical OR brown adipose tissue OR therapeutics OR biosynthesis). The first 300 listed results were inspected from the Web of Science and Google Scholar searches, as this number is also reported in published systematic reviews of bats (e.g. Crane et al., 2022) (Figure 1). The reference lists and supplementary information from relevant publications were also inspected (AfroBat, EuroBaTrait) for further relevant entries.

The inclusion criteria for entries considered was:

1.  Multi-taxa or bat-specific studies that included information on bat functional traits published on peer-reviewed journals.

    -   This includes data papers, review articles, and case studies.

2.  Multi-taxa or bat-specific publications that included information on bat functional traits but were not published on peer-reviewed journals.

    -   This includes online databases, books, book chapters, and reports.

3.  Studies published in the english or spanish languages.

<br>

The bat functional trait information available from the Handbook of Mammals of the World (Wilson & Mittermeier 2019, obtained from Sherman et al., 2024), as well as the Mammalian Species records, which are published by the American Society of Mammalogists, will also be obtained for integration into the database.

1.  Eeach entry will be screened manually to identify publications reporting bat functional trait data. The following columns were added to the csv file for screening purposes.
    -   *includes_bats_in_title*: Does the publication have the “bat” or any variation of the word in the title?
    -   *includes_traits_in_title*: Does the publication have the “trait” or any variation of the word in the title?
    -   *to_keep*: Column to exclude duplicates, non english or spanish publications, not excluded by automatic tools. Also excludes publications not accessible for initial screening.
    -   *includes_trait_info*: Does the publication include bat functional trait data?
    -   *fully_included_in_another_source*: Is the trait data fully obtained from any other study already included in the literature review?

```{r literature review selection process, fig.align = 'center', out.width = "100%", fig.cap = "Figure 1. PRISMA 2020 flow diagram for bat functional trait data retrieval for the creation of a Global Bat Trait Database", echo=FALSE, message=FALSE}

knitr::include_graphics(here::here("output/literature_review", "PRISMA_2020_flow_diagram.png"))

```

<br> <br>
