# Longitudinal Data Analysis
### The National Longitudinal Study of Adolescent to Adult Health

> We examined three substance use behaviors: daily smoking, past-month marijuana use, and regular HED. Smoking was assessed as days smoked out of the past 30 days; this was dichotomized to indicate whether individuals smoked on all of the past 30 days. Marijuana use was assessed as times used during the past month; this was dichotomized into any/no past month marijuana use. Frequency of HED (WaveI–III definition: 5+ drinks; Wave IV definition: 4+ drinks for females, 5+ drinks formales) during the past year was assessed; this was dichotomized into any/no regular past year HED, where regular HED was defined as at least one time per month for the past 12 months

### Baseline variables

| variable      | code    | wave | description
| :------------ | :------ | :--  | :----------
| [`sex`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/codebookssearch?field=varname&match=contains&text=BIO_SEX) | BIO_SEX | 1    | Interviewer, please confirm that R’s sex is (male) female. (Ask if necessary.)
| [`bday_m`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2) | H1GI1M | 1    | What is your birth date? (month)
| [`bday_y`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2) | H1GI1Y | 1    | What is your birth date? (year)
| [`race1`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/codebookssearch?field=varname&match=contains&text=H1GI8+++) | H1GI8 | 1    | Which one category best describes your racial background?
| [`race3`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/codebookssearch?field=varname&match=contains&text=H3OD6) | H3OD6 | 3    | Which one category best describes your racial background?
| [`intercourse`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=726) | H1CO1, H2CO2 | 1,2 | Have you ever had sexual intercourse?
| [`intercourse`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=726) | H3SE1, H4SE6 | 3,4 | Have you ever had vaginal intercourse? (Vaginal intercourse is when a man inserts his penis into a woman's vagina.)
| [`vaginal`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=727) | H3SE2 | 3 | How old were you the first time you had vaginal intercourse?
| [`oral`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=809) | H4SE10 | 4 | How old were you the very first time you had oral sex?

### Meta data

[`month, day, year`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2416)

| code    | wave | description
| :------ | :--- | :----------
| IMONTH  | 1-4  |  Month interview completed
| IDAY    | 1-4  |  Day interview completed
| IYEAR   | 1-4  |  Year interview completed

### Longitudinal

[`weight`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=203)

| code    | wave | description
| :------ | :--- | :----------
| H1GH60  | 1    | What is your weight?
| H2GH53  | 2    | What is your weight?
| H3DA44  | 3    | What is your current weight in pounds?
| H4GH6   | 4    | What is your current weight in pounds?

[`think_weight`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=409)

| code    | wave | description
| :------ | :--- | :----------
| H1GH28  | 1    | How do you think of yourself in terms of weight?
| H2GH30  | 2    | How do you think of yourself in terms of weight?
| H3GH2   | 3    | How do you think of yourself in terms of weight?
| H4GH7   | 4    | How do you think of yourself in terms of weight?

[`depressed`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=1055)

| code    | wave | description
| :------ | :--- | :----------
| H1FS6   | 1    | How often was the following true during the past week? You felt depressed.
| H2FS6   | 2    | How often was the following true during the past seven days? You felt depressed.
| H3SP9   | 3    | How often was the following true during the past seven days? You were depressed.
| H4MH22  | 4    | How often was the following true during the past seven days? You felt depressed.

[`cigarettes`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2076)

| code    | wave | description
| :------ | :--- | :----------
| H1TO5   | 1    | During the past 30 days, on how many days did you smoke cigarettes?
| H2TO5   | 2    | During the past 30 days, on how many days did you smoke cigarettes?
| H3TO7   | 3    | During the past 30 days, on how many days did you smoke cigarettes?
| H4TO5   | 4    | During the past 30 days, on how many days did you smoke cigarettes?

[`marijuana`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2123)

| code    | wave | description
| :------ | :--- | :----------
| H1TO32  | 1    | During the past 30 days, how many times did you use marijuana?
| H2TO46  | 2    | During the past 30 days, how many times did you use marijuana?
| H3TO110 | 3    | During the past 30 days, how many times have you used marijuana?
| H4TO71  | 4    | During the past 30 days, on how many days did you use marijuana?

[`drunk`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2010)

| code    | wave | description
| :------ | :--- | :----------
| H1TO18  | 1    | Over the past 12 months, on how many days have you gotten drunk or "very, very high" on alcohol?
| H2TO22  | 2    | Over the past 12 months, on how many days have you gotten drunk or "very, very high" on alcohol?
| H3TO43  | 3    | During the past 12 months, on how many days have you been drunk or very high on alcohol?
| H4TO38  | 4    | During the past 12 months, on how many days have you been drunk or very high on alcohol?

