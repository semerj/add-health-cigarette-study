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

[`cigarettes`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2075)

| code    | wave | description
| :------ | :--- | :----------
| H1TO5   | 1    | During the past 30 days, on how many days did you smoke cigarettes?
| H2TO5   | 2    | During the past 30 days, on how many days did you smoke cigarettes?
| H3TO7   | 3    | During the past 30 days, on how many days did you smoke cigarettes?
| H4TO5   | 4    | During the past 30 days, on how many days did you smoke cigarettes?

### Time-varying depression (totaled to compute CES-D)

[`disliked`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1067)

| code    | wave | description
| :------ | :--- | :----------
| H1FS17  | 1    | How often was the following true during the past week? You felt that people disliked you.
| H2FS17  | 2    | How often was the following true during the past seven days? You felt that people disliked you.
| H3SP13  | 3    | How often was the following true during the past seven days? You felt that people disliked you.
| H4MH27  | 4    | How often was the following true during the past seven days? You felt that people disliked you.

[`sad`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1066)

| code    | wave | description
| :------ | :--- | :----------
| H1FS16  | 1    | How often was the following true during the past week? You felt sad.
| H2FS16  | 2    | How often was the following true during the past seven days? You felt sad.
| H3SP12  | 3    | How often was the following true during the past seven days? You were sad.
| H4MH26  | 4    | How often was the following true during the past seven days? You felt sad.

[`enjoy_life`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1065)

| code    | wave | description
| :------ | :--- | :----------
| H1FS15  | 1    | How often was the following true during the past week? You enjoyed life.
| H2FS15  | 2    | How often was the following true during the past seven days? You enjoyed life.
| H3SP11  | 3    | How often was the following true during the past seven days? You enjoyed life.
| H4MH25  | 4    | How often was the following true during the past seven days? You enjoyed life.

[`tired`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1056)

| code    | wave | description
| :------ | :--- | :----------
| H1FS7   | 1    | How often was the following true during the past week? You felt that you were too tired to do things.
| H2FS7   | 2    | How often was the following true during the past seven days? You felt that you were too tired to do things.
| H3SP10  | 3    | How often was the following true during the past seven days? You were too tired to do things.
| H4MH23  | 4    | How often was the following true during the past seven days? You felt that you were too tired to do things.

[`not_good`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1053)

| code    | wave | description
| :------ | :--- | :----------
| H1FS4   | 1    | How often was the following true during the past week? You felt you were just as good as other people.
| H2FS4   | 2    | How often was the following true during the past week? You felt you were just as good as other people.
| H3SP7   | 3    | How often was the following true during the past seven days? You felt you were just as good as other people.
| H4MH20  | 4    | How often was the following true during the past seven days? You felt you were just as good as other people.

[`bothered`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1050)

| code    | wave | description
| :------ | :--- | :----------
| H1FS1   | 1    | How often was the following true during the past week? You were bothered by things that don't usually bother you.
| H2FS1   | 2    | How often was the following true during the past week? You were bothered by things that don't usually bother you.
| H3SP5   | 3    | How often was the following true during the past seven days? You were bothered by things that usually don't bother you.
| H4MH18  | 4    | How often was the following true during the past seven days? You were bothered by things that usually don't bother you.

[`blues`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1052)

| code    | wave | description
| :------ | :--- | :----------
| H1FS3   | 1    | How often was the following true during the past week? You felt that you could not shake off the blues, even with help from your family and your friends.
| H2FS3   | 2    | How often was the following true during the past week? You felt that you could not shake off the blues, even with help from your family and your friends.
| H3SP6   | 3    | How often was the following true during the past seven days? You could not shake off the blues, even with help from your family and your friends.
| H4MH19  | 4    | How often was the following true during the past seven days? You could not shake off the blues, even with help from your family and your friends.

[`depressed`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1055)

| code    | wave | description
| :------ | :--- | :----------
| H1FS6   | 1    | How often was the following true during the past week? You felt depressed.
| H2FS6   | 2    | How often was the following true during the past seven days? You felt depressed.
| H3SP9   | 3    | How often was the following true during the past seven days? You were depressed.
| H4MH22  | 4    | How often was the following true during the past seven days? You felt depressed.

### Meta data

[`month, day, year`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2416)

| code    | wave | description
| :------ | :--- | :----------
| IMONTH  | 1-4  |  Month interview completed
| IDAY    | 1-4  |  Day interview completed
| IYEAR   | 1-4  |  Year interview completed