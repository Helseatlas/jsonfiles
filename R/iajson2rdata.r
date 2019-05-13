#' Read json-data from IA
#'
#' All the data used to produce an Instant Atlas is stored in
#' a json file. This function will read such a file and put the
#' data into a data frame.
#'
#' @param json_file The json file used by IA
#'
#' @return A data frame
#' @export
#' @importFrom magrittr "%>%"
#'
read_iajson <- function(json_file = NULL) {
  json_file <- "../json-files/kols.json"
  # json_file <- "../json-files/barn.json"
  # Read the json file
  # NOTE: The js-file HAS to be converted from UTF-8 BOM to UTF-8 (in notepad++) before this will work!
  json_data <- jsonlite::fromJSON(json_file, simplifyDataFrame = TRUE)

  themes <- data.frame(json_data$geographies$themes)

  feature <- data.frame(json_data$geographies$features)
  area <- feature$name

  # Name of reference areas
  # nolint start
  comparisonFeature <- data.frame(json_data$geographies$comparisonFeature)
  ref_area <- comparisonFeature$name
  # nolint end

  level1 <- data.frame(json_data$geographies$themes)$name

  #  all_data <- data.frame()

  for (i in 1:length(data.frame(json_data$geographies$themes)$indicators)) {
    data <- data.frame(data.frame(json_data$geographies$themes)$indicators[i])
    data$level1 <- level1[i]



    #    all_data <- rbind(all_data, data)
  }

  testthat::compare(tmp, tmp2)


  mylist2 <- data.frame(json_data$geographies$themes)$indicators

  test <- data.frame(mylist[2])

  test$values[1]

  tmp <- json_data$geographies$features

  all_data <- do.call("rbind", data.frame(json_data$geographies$themes)$indicators)

  all_data$values[3]

  #  all_data <- data.frame()
  #  for (i in 1:length(data.frame(json_data$geographies$themes)$indicators)) {
  #    all_data <- rbind(all_data, data.frame(data.frame(json_data$geographies$themes)$indicators[i]))
  #  }

  level2 <- all_data$name

  url <- all_data$href

  precision <- all_data$precision

  values <- all_data$values



  data1 <- data.frame(data.frame(json_data$geographies$themes)$indicators[1])
  data2 <- data.frame(data.frame(json_data$geographies$themes)$indicators[2])

  level2 <- data.frame(json_data$geographies$themes)$indicators

  length(test)

  # Define an empty data frame, so we can add data to this frame in the loop.
  all_data <- data.frame()

  # Loop over level one
  for (i in 1:length(themes$name)) {

    # Names for first level
    level1 <- themes$name[i]

    # Evereything else is stored in next_level
    next_level <- data.frame(themes$indicators[i])

    # Rates to be plotted
    rates <- data.frame(next_level$values) %>%
      tibble::as_tibble()
    # Rates for Norway etc
    # nolint start
    ref_rates <- data.frame(next_level$comparisonValues) %>%
      tibble::as_tibble()
    # nolint end
    # Link to fact sheets
    href <- next_level$href

    # Extract the numeraters and denominators
    extra <- data.frame(next_level$associates)

    # Dummy definition, to later check if level3 is equal to previous level3
    prev_level3 <- "qwerty"

    k <- 0

    for (j in 1:length(next_level)) {
      # Level 2

      if (!is.na(next_level$id[j])) {

        # Names for the second level
        level2 <- next_level$name[j]
        level3 <- NULL
        # Names for the third level, if it exists
        level3 <- try(next_level$date[j])
        # ID for level 2 (not unique with three levels)
        selection_id <- next_level$id[j]

        # numeraters and denominaters stored in extra$values.1 etc.
        k <- j - 1
        if (k == 0) {
          post <- ""
        } else {
          post <- paste0(".", k)
        }
        numerater <- data.frame(extra[, paste0("values", post)][2])
        denominator <- data.frame(extra[, paste0("values", post)][1])
        name_numerater <- extra[, paste0("name", post)][2]
        name_denominator <- extra[, paste0("name", post)][1]
        # nolint start
        ref_numerater <- data.frame(extra[, paste0("comparisonValues", post)][2])
        ref_denominator <- data.frame(extra[, paste0("comparisonValues", post)][1])
        # nolint end

        combined <- data.frame(area, level1, level2)
        colnames(combined) <- c("area", "level1", "level2")
        ref_combined <- data.frame(ref_area, level1, level2)
        colnames(ref_combined) <- c("area", "level1", "level2")

        # Extract metatext, if present
        properties <- NULL
        properties <- try(next_level$properties)
        metatext <- NULL
        if (!is.null(properties)) {
          # Metatext can either be stored in next_level$properties[l]$value[n] or in
          # next_level$properties$value[n], next_level$properties$value.1[n] etc.
          if (length(properties) > 1) {
            # If metatext is stored in next_level$properties[l]$value[n]
            for (l in 1:length(properties)) {
              df_properties <- data.frame(properties[l])
              for (n in 1:length(df_properties$value)) {
                if (df_properties$name[n] == "metatext") {
                  metatext[l] <- try(df_properties[, "value"][n])
                }
              }
            }
          } else {
            # If metatext is stored in next_level$properties$value[n], next_level$properties$value.1[n] etc.
            df_properties <- data.frame(properties)
            for (l in 1:(length(df_properties) / 2)) {
              m <- l - 1
              if (m == 0) {
                for (n in 1:length(df_properties$value)) {
                  if (df_properties$name[n] == "metatext") {
                    metatext[l] <- try(df_properties[, "value"][n])
                  }
                }
              }
            }
          }
        }
        if (is.null(level3)) {

          # Only for two-level atlases
          combined["id"] <- selection_id
          ref_combined["id"] <- selection_id
        } else {
          # A new unique identifier has to be defined if it is a three-level atlas
          if (level3 != prev_level3) {
            k <- k + 1
            id2 <- paste0(selection_id, "j", k)
          }
          combined["level3"] <- level3
          ref_combined["level3"] <- level3
          combined["id"] <- id2
          ref_combined["id"] <- id2
          prev_level3 <- level3
        }
        combined["rate"] <- rates[j]
        ref_combined["rate"] <- ref_rates[j]

        combined["name_numerater"] <- name_numerater
        ref_combined["name_numerater"] <- name_numerater

        combined["numerater"] <- numerater
        ref_combined["numerater"] <- ref_numerater

        combined["name_denominator"] <- name_denominator
        ref_combined["name_denominator"] <- name_denominator

        combined["denominator"] <- denominator
        ref_combined["denominator"] <- ref_denominator

        combined["ref"] <- 0
        ref_combined["ref"] <- 1

        combined["href"] <- href[j]
        ref_combined["href"] <- href[j]

        if (!is.null(metatext)) {
          combined["metatext"] <- metatext[j]
          ref_combined["metatext"] <- metatext[j]
        }


        all_data <- rbind(all_data, combined, ref_combined)
      }
    }
  }

  if (!is.null(rdata_file)) {
    save(all_data, file = rdata_file)
  }
  
  return(all_data)
}
