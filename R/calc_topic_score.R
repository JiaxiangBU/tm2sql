#' Count the regular expression frequency.
#'
#' @importFrom stringr str_split str_flatten
#' @examples
#' \dontrun{select length(regexp_replace("测试试测", "[^测][^试]",""))/length("测试") as x1}
str_count_sql <-
    function(input = "x1",
             regexp = "测试",
             is_rename = TRUE,
             output = input) {
        drop_text_sql <-
            glue::glue('regexp_replace({input}, "[^{regexp}]"," ")')

        text <-
            glue::glue('(length(regexp_replace({drop_text_sql}, "{regexp}", "")) - length({drop_text_sql}))/length("{regexp}")*(-1)')
        if (is_rename == TRUE) {
            text <- glue::glue('{text} as {output}')
        }
        text <- as.character(text)
        return(text)
    }

multiply_by_beta <- function(sql_text, beta) {
    text <- glue::glue("{beta} * {sql_text}")
    text <- as.character(text)
    return(text)
}

#' Calcuate the topic score from beta data table.
#'
#' @param df data.frame. beta data table
#' @param word Character. word column.
#' @param beta numeric. beta scores for the words.
#' @importFrom dplyr mutate summarise pull
#' @importFrom purrr map2_chr
#' @importFrom stringr str_flatten
#' @export
#' @examples
#' beta_df <- data.frame(dict = c("文本", "分析", "学习", "笔记"),
#'                       loading = c(0.1, 0.2, 0.3, 0.4))
#' calc_topic_score_sql(beta_df, dict, loading)
calc_topic_score_sql <- function(df, word, beta) {
    df %>%
        dplyr::mutate(sql_text = purrr::map2_chr(
            {{word}}, {{beta}},
            ~ str_count_sql(.x, is_rename = FALSE) %>% multiply_by_beta(.y)
        )) %T>%
        print %>%
        dplyr::summarise(sql_text = stringr::str_flatten(sql_text, " + \n")) %>%
        dplyr::pull() %T>%
        cat %>%
        invisible()
}
