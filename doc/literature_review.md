A literature search of the Web of Science and Scopus databases, and also the Google Scholar search engine, was conducted on December 1st, 2024, with Harzing’s Publish or Perish software using the following keywords: “bat review” OR “bat dataset” OR “bat global assessment” OR “bat traits” OR "bat functional traits" OR “bat meta-analysis” OR “bat data paper”. The inclusion criteria for entries included was:

1.  Multi-taxa or specific studies that included information on bat functional traits

2.  Secondary studies (e.g. databases and review articles). No publications from grey literature were considered..

3.  Studies withdata was taken from biological collections and long term studies,.

4.  Studies reported in the english or spanish languages.

5.  Studies published in a scientific journal with an assigned impact factor.

<br>

The next series of steps were implemented in order to clean the citation data for the first phase of literature review (Figure 1):

1.  The three files obtained in the first literature search (found in data/raw/literature_review/ as scholar.csv, scopus.csv, and wos.csv) were combined in the R environment (n left = 538).
2.  Duplicate entries were removed (n left = 514).
3.  Entries without any Source, Year, or Publisher information were removed (n left = 325).
4.  Entries not related to bats (e.g. brown adipose tissue) were removed (n left = 163).
    -   Keywords removed from the Source field: *Conference, Forum, Universe, Astrophysical, Astronomy, X-ray, X-Ray, bioRxiv, BioRxiv, arXiv, Medical, Authorea, Electronics, Industrial, Addiction, Law, Children, Patent, Fuel, Epiphany, Legal, Available, Congress, magnetic, EURASIP, Technology, IEEE, Neurocomputing, EPA, Engineering, Theological, Poet, Future, Drug, Energies, policy, Experientia, Nutrients, Intelligence, Physician, Network, Reform, Expert, Administration, Briefings, Pentagon, Computational, Entropy.*
    -   Keywords removed from the Title field: *adipose, fat, poetry, GABA, Basophil, galaxies, gamma-ray, Combustion, UAV, Dances, cigarette, Cigarette, industrial, Brownian, President, magnetic, director, Children, carbon, CO2, Smoking, Court, package, cloning, Twitter, X-ray, Judges, archaeal, engagement, amnesic, adiposity, economic, benzene, policy, Internet, Education, stance, WAN, Diffusion, PasswordsVirtual, TECHNOLOGIES, eyetracking, Eye-Tracking, CCS, cluster*.
    -   Keywords removed from the Publisher field: *donepetro, ebooks*.
5.  Entries in a language other than english or spanish were removed (n left = 161).

A second phase of literature review was conducted from the 2nd of December to December 15, 2024, undefinedby searching the Web of Science database using the following string search: (bat OR bats OR chiroptera) AND (review OR traits OR functional traits OR meta-analysis) NOT (vaccines OR biomaterial OR bio-medical OR brown adipose tissue OR therapeutics OR biosynthesis). The entries were reviewed up until page number 30. The databases included in the supplementary tables available in Cosentino et al., (2023) and Froidevaux et al., (2023) were also included at this point in the Bats_Data

1.  259 entries were obtained
2.  Duplicate entries were removed (n left = 233).
3.  This dataset (second_phase) was combined with the previous dataset (first_phase) and duplicates were removed (n left = 379).
4.  Entries were screened manually to discard any irrelevant publication (i.e. not related to bats) that was left behind by previous steps. (n left = 223).
    -   *includes_bats_in_title*: Does the publication have the “bat” or any variation of the word in the title?
    -   *includes_traits_in_title*: Does the publication have the “trait” or any variation of the word in the title?
    -   *to_keep*: The publication is kept if it is a database, review, or a study which takes its data from biological collections or long term studies?
5.  Each entry was manually screened in order to retain only entries with information on bat functional traits. (n left = 171).
    -   *includes_trait_info*: Does the publication include bat functional trait data?
6.  Each entry whose data comes from any other study considered in this literature search was discarded (n left = 157).
    -   *fully_included_in_another_source*: Is the trait data fully obtained from any other study already included in the literature review?

```{r literature review selection process, fig.align = 'center', out.width = "100%", fig.cap = "Figure 1. PRISMA 2020 flow diagram for bat functional trait data retrieval for the creation of a Global Bat Trait Database", echo=FALSE, message=FALSE}

knitr::include_graphics(here::here("output/literature_review", "PRISMA_2020_flow_diagram.png"))

```

<br> <br>
