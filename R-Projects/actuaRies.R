# Using imaginator package for individual claim simulation extract from the vignette

set.seed(12345)
tbl_policy <- policies_simulate(2, 2001:2005)
tbl_claim_transaction <- claims_by_wait_time(
  tbl_policy,
  claim_frequency = 2,
  payment_frequency = 3,
  occurrence_wait = 10,
  report_wait = 5,
  pay_wait = 5,
  pay_severity = 50)
kableExtra::kbl(tbl_claim_transaction[1:8,], 
                caption = "Wait-time modelling with policies simulation") %>%
  kableExtra::kable_classic(full_width = F, html_font = "Cambria")

# Using MortalityTables package - Mortality tables extract from the vignette 
mortalityTables.load("Austria_Annuities")
mortalityTables.load("Austria_Census")
plotMortalityTables(
  title="Using dimensional information for mortality tables",
  mort.AT.census[c("m", "w"), c("1951", "1991", "2001", "2011")]) + 
  aes(color = as.factor(year), linetype = sex) + labs(color = "Period", linetype = "Sex")+
  scale_fill_brewer(palette="PiYG")

# Using MortalityTables package extract from the vignette 
mortalityTables.load("Austria_Annuities")
# Get the cohort death probabilities for Austrian Annuitants born in 1977:
qx.coh1977 = deathProbabilities(AVOe2005R.male, YOB = 1977)
# Get the period death probabilities for Austrian Annuitants observed in the year 2020:
qx.per2020 = periodDeathProbabilities(AVOe2005R.male, Period = 2020)
# Get the cohort death probabilities for Austrian Annuitants born in 1977 as a mortalityTable.period object:
table.coh1977 = getCohortTable(AVOe2005R.male, YOB = 1977)
# Get the period death probabilities for Austrian Annuitants observed in the year 2020:
table.per2020 = getPeriodTable(AVOe2005R.male, Period = 2020)
# Compare those two in a plot:
plot(table.coh1977, table.per2020, title = "Comparison of cohort 1977 with period 2020", legend.position = c(1,0))+
  scale_fill_brewer(palette="PiYG")

# Using lifecontingencies package
# Extract from vignette
# Calculation example for the benefit reserve for a deferred annuity-due on a policyholder aged 25 when the annuity is deferred until age 65.
yearlyRate <- 12000
irate <- 0.02
APV <- yearlyRate*axn(soa08Act, x=25, i=irate,m=65-25,k=12)
levelPremium <- APV/axn(soa08Act, x=25,n=65-25,k=12)
annuityReserve<-function(t) {
  out<-NULL
  if(t<65-25) out <- yearlyRate*axn(soa08Act, x=25+t,
                                    i=irate, m=65-(25+t),k=12)-levelPremium*axn(soa08Act,
                                                                                x=25+t, n=65-(25+t),k=12) else {
                                                                                  out <- yearlyRate*axn(soa08Act, x=25+t, i=irate,k=12)
                                                                                }
  return(out)
}
years <- seq(from=0, to=getOmega(soa08Act)-25-1,by=1)
annuityRes <- numeric(length(years))
for(i in years) annuityRes[i+1] <- annuityReserve(i)
dataAnnuityRes <- data.frame(years=years, reserve=annuityRes)
dataAnnuityRes%>%ggplot(aes(years, reserve))+
  geom_line(color="blue")+
  labs(x = "Years", y = "Amount",
       title ="Deferred annuity benefit reserve")

survey<-read_csv("survey_actuaries.csv")
survey%>%pivot_longer(-Tasks, names_to="Time", values_to="Score")%>%
  group_by(Tasks) %>% 
  mutate(sum_response = sum(Score))%>%
  ungroup()%>%
  ggplot(aes(x=fct_reorder(Tasks, sum_response), Score, fill=Time))+
  geom_col(show.legend = TRUE)+
  coord_flip()+
  scale_fill_brewer(palette="PiYG")+
  labs(y = "Responses", x = "Tasks",
       title ="Data and model management tasks - wasted time")
