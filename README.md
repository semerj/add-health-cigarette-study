## Longitudinal Data Analysis of The National Longitudinal Study of Adolescent to Adult Health

### Abstract

The National Longitudinal Study of Adolescent to Adult Health (Add Health) is alongitudinal study of a nationally representative sample of adolescents in grades 7-12 in the United States during the 1994-95 school year. The Add Health cohort has been followed into young adulthood with four in-home interviews. Add Health combines longitudinal survey data across multiple domains, including substance use and depression.A subset of the the Add Health data was used to study the effect of depression, sex, and age on daily cigarette use over time. A continuous measure of depression was based on a subset of 9 items from Center for Epidemiological Studies Depression Scale (CES-D) was used. Subjects assessed their depressive feelings from the past 7 days and daily cigarette smoking from the last 30 days at each wave.
Age and sex were both associated with an increase in the odds of daily cigarette smoking. The longitudinal effect of CES-D was also associated with an increase in the odds of smoking, while the baseline effect of CES-D resulted in non-significant results from a Simple Random Effects model. However, GEE models supported a population-based effect from baseline CES-D scores.

### Data
Publically available data was obtained online from the [Odum Institute at UNC](http://arc.irss.unc.edu/dvn/dv/addhealth).

### Research QuestionHow are the time-varying and baseline depression levels (as measured by CESDepression Scale) related to the propensity to smoking cigarettes daily amongsurvey respondents?

## Variables

### Baseline

| variable      | code    | wave | description
| :------------ | :------ | :--  | :----------
| [`sex`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/codebookssearch?field=varname&match=contains&text=BIO_SEX) | BIO_SEX | 1    | Interviewer, please confirm that R’s sex is (male) female. (Ask if necessary.)
| [`bday_m`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2) | H1GI1M | 1    | What is your birth date? (month)
| [`bday_y`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2) | H1GI1Y | 1    | What is your birth date? (year)

### Outcome



| variable      | code    | wave | description
| :------------ | :------ | :--  | :----------
|  [`cigarettes`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2075) | H1TO5, H2TO5, H3TO7, H4TO5 | 1-4   | During the past 30 days, on how many days did you smoke cigarettes?

### Time-varying depression (totaled to compute CES-D)

| variable      | code    | wave | description
| :------------ | :------ | :--  | :----------
| [`disliked`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1067) | H1FS17, H2FS17, H3SP13, H4MH27 | 1-4 | How often was the following true during the past week? You felt that people disliked you.
| [`sad`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1066) | H1FS16, H2FS16, H3SP12, H4MH26 | 1-4 | How often was the following true during the past week? You felt sad.
| [`enjoy_life`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1065) | H1FS15, H2FS15, H3SP11, H4MH25 | 1-4 | How often was the following true during the past week? You enjoyed life.
| [`tired`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1056) | H1FS7, H2FS7, H3SP10, H4MH23 | 1-4 | How often was the following true during the past week? You felt that you were too tired to do things.
| [`not_good`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1053) | H1FS4, H2FS4, H3SP7, H4MH20 | 1-4 | How often was the following true during the past week? You felt you were just as good as other people.
| [`bothered`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1050) | H1FS1, H2FS1, H3SP5, H4MH18 | 1-4 | How often was the following true during the past week? You were bothered by things that don't usually bother you.
| [`blues`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1052) | H1FS3, H2FS3, H3SP6, H4MH19 | 1-4 | How often was the following true during the past week? You felt that you could not shake off the blues, even with help from your family and your friends.
| [`depressed`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1055) | H1FS6, H2FS6, H3SP9, H4MH22 | 1-4 | How often was the following true during the past week? You felt depressed.

### Meta data

| variable      | code    | wave | description
| :------------ | :------ | :--  | :----------
| [`month`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2416) | IMONTH  | 1-4  |  Month interview completed
| [`day`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2416) | IDAY    | 1-4  |  Day interview completed
| [`year`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2416) | IYEAR   | 1-4  |  Year interview completed