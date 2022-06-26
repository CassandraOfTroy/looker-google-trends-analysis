connection: "connection_name"

include: "../views/*.view.lkml"

explore: international_top_terms {

  label: "🌏 International Google Top Terms and Top Rising Terms Insights"
  persist_for: "12 hours"

  join: international_top_rising_terms {
    type: left_outer
    relationship: many_to_many
    sql_on: ${international_top_terms.top_term_refresh_date_date} = ${international_top_rising_terms.top_rising_term_refresh_date_date}
              AND
            ${international_top_terms.week_week} = ${international_top_rising_terms.week_week}
              AND
            ${international_top_terms.country_code} = ${international_top_rising_terms.country_code}
              AND
            ${international_top_terms.region_code} = ${international_top_rising_terms.region_code} ;;
  }

}

