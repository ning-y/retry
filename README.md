# retry

The *retry* package exports a single function, *retry* which takes an arbitrary
code block and executes it a number of times, or until it succeeds.

## Example

*retry* works well for code chunks which fail sometimes, stochastically.

```
library(retry)
retry({
  stopifnot(rbinom(1, 1, 0.2) == 1)
  one <- 1
})
```

One practical use for *retry* is for unreliable API calls.
For example, Ensembl's [BioMart](https://asia.ensembl.org/info/data/biomart/index.html) sometimes undergoes maintenance, during which only some API calls will randomly succeed.

```
library(biomaRt)
library(retry)

affyids=c("202763_at","209310_s_at","207500_at")
retry({
  ensembl <- useMart("ensembl",dataset="hsapiens_gene_ensembl")
  annotations <- getBM(
    attributes=c('affy_hg_u133_plus_2', 'entrezgene_id'),
    filters = 'affy_hg_u133_plus_2',
    values = affyids,
    mart = ensembl
  )
})
```

## Installation

```
install.packages('retry')
```
