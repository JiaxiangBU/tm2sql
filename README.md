
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tm2sql

<!-- badges: start -->

[![DOI](https://zenodo.org/badge/206491593.svg)](https://zenodo.org/badge/latestdoi/206491593)
<!-- badges: end -->

The goal of tm2sql is to translate topic model into SQL. I use it into
production by impala successfully.

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

## Installation

The development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("JiaxiangBU/tm2sql")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(tm2sql)
library(tidyverse)
## basic example code
```

``` r
beta_df <- data.frame(dict = c("文本", "分析", "学习", "笔记"),
                      loading = c(0.1, 0.2, 0.3, 0.4))
calc_topic_score_sql(beta_df, dict, loading)
#>   dict loading
#> 1 文本     0.1
#> 2 分析     0.2
#> 3 学习     0.3
#> 4 笔记     0.4
#>                                                          sql_text
#> 1 0.1 * length(regexp_replace(文本, "[^测试]",""))/length("测试")
#> 2 0.2 * length(regexp_replace(分析, "[^测试]",""))/length("测试")
#> 3 0.3 * length(regexp_replace(学习, "[^测试]",""))/length("测试")
#> 4 0.4 * length(regexp_replace(笔记, "[^测试]",""))/length("测试")
#> 0.1 * length(regexp_replace(文本, "[^测试]",""))/length("测试") + 
#> 0.2 * length(regexp_replace(分析, "[^测试]",""))/length("测试") + 
#> 0.3 * length(regexp_replace(学习, "[^测试]",""))/length("测试") + 
#> 0.4 * length(regexp_replace(笔记, "[^测试]",""))/length("测试")
```

## Citations

Jiaxiang Li. (2019, September 5). JiaxiangBU/tm2sql: tm2sql 0.1.0
(Version v0.1.0). Zenodo. <http://doi.org/10.5281/zenodo.3386724>

``` bibtex
@misc{jiaxiang_li_2019_3386724,
  author       = {Jiaxiang Li},
  title        = {JiaxiangBU/tm2sql: tm2sql 0.1.0},
  month        = sep,
  year         = 2019,
  doi          = {10.5281/zenodo.3386724},
  url          = {https://doi.org/10.5281/zenodo.3386724}
}
```

If you use tm2sql, I would be very grateful if you can add a citation in
your published work. By citing tm2sql, beyond acknowledging the work,
you contribute to make it more visible and guarantee its growing and
sustainability. For citation, please use the BibTex or the citation
content.

-----

<h4 align="center">

**Code of Conduct**

</h4>

<h6 align="center">

Please note that the `tm2sql` project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md).<br>By contributing to this
project, you agree to abide by its terms.

</h6>

<h4 align="center">

**License**

</h4>

<h6 align="center">

MIT © [Jiaxiang Li](LICENSE.md)

</h6>
