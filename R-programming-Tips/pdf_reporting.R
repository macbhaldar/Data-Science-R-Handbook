# Automate PDF Reporting

library(rmarkdown)

# AUTOMATE PDF REPORTING 
# Make sure you have tinytex installed with: tinytex::install_tinytex()

# Technology Portfolio
portfolio_name <- "Technology Portfolio"
symbols        <- c("AAPL", "GOOG", "NFLX", "NVDA")
output_file    <- "technology_portfolio.pdf"

# Financial Portfolio
portfolio_name <- "Financial Portfolio"
symbols        <- c("V", "MA", "PYPL")
output_file    <- "financial_portfolio.pdf"

# Automation Code
rmarkdown::render(
  input         = "template/stock_report_template.Rmd",
  output_format = "pdf_document",
  output_file   = output_file,
  output_dir    = "R-raw/output/",
  params        = list(
    portfolio_name = portfolio_name,
    symbols        = symbols,
    start          = "2010-01-01",
    end            = "2019-12-31",
    show_code      = FALSE
  )
)
