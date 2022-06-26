view: international_top_rising_terms {
  derived_table: {
    sql: SELECT
          *
         FROM
          `bigquery-public-data.google_trends.international_top_rising_terms`
        ;;
  }

####
#Define the compound primary key
####

  dimension: compound_pk {
    hidden: yes
    primary_key: yes
    type: number
    sql: CONCAT(${top_rising_term_refresh_date_date},${week_week},${country_code},${region_code},${term});;
  }

###
#Visible dimensions
###

  dimension_group: top_rising_term_refresh_date {
    type: time
    datatype: date
    timeframes: [
      raw,
      date,
      day_of_week,
      day_of_week_index,
      week,
      day_of_month,
      month_name,
      month_num,
      month,
      quarter,
      day_of_year,
      year
    ]
    sql: CAST(datetime(timestamp(${TABLE}.refresh_date), "America/Los_Angeles") AS DATE) ;;
  }

  dimension: region_code {
    type: string
    sql: ${TABLE}.region_code ;;
  }

  dimension_group: week {
    type: time
    datatype: date
    timeframes: [
      date,
      day_of_week,
      week,
      week_of_year,
      month_name,
      month_num,
      month,
      year
    ]
    sql: ${TABLE}.week ;;
  }

  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }

  dimension: region_name {
    type: string
    sql: ${TABLE}.region_name ;;
  }

  dimension: term {
    label: "Top RISING term"
    type: string
    sql: ${TABLE}.term ;;
    link: {
      label: "Google"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }
  }

  dimension: rank {
    label: "Top RISING term Rank"
    description: "Use the Rank dimension for filtering purposes."
    hidden: no
    type: number
    sql: ${TABLE}.rank ;;
  }

###
#Hidden dimensions
###

  dimension: score {
    hidden: yes
    type: number
    sql: ${TABLE}.score ;;
  }

  dimension: percent_gain {
    hidden: yes
    type: number
    sql: ${TABLE}.percent_gain ;;
  }

#####
#Measures
#####

  measure: score_measure {
    label: "Average Top Rising Term SCORE [1-100]"
    description: "Score denotes how popular this term was for a country's region during the current date,
                  relative to the other dates in the same time series for this term."
    type: average
    value_format_name: decimal_2
    sql: ${score} ;;
  }

  measure: rank_measure {
    label: "Average Top Rising Term RANK [1-25]"
    description: "Numeric representation of where the term falls in comparison to the other top terms for the day across the globe.
                  The rank value shows the same rank across all historical data and all regions of a country."
    type: average
    value_format_name: decimal_2
    sql: ${rank} ;;
  }

  measure: percent_gain_measure {
    label: "Average Rising Term PERCENT GAIN [%]"
    description: "Percentage gain (rate) at which term rose compared to the previous date period."
    type: average
    value_format_name: decimal_0
    sql: ${percent_gain} ;;
  }

}
