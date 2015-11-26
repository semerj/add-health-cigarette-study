## Longitudinal Data Analysis of The National Longitudinal Study of Adolescent to Adult Health

### Measures

> Depressive symptoms during the past seven days were measured at each wave with a subset of nine items from the Center for Epidemiological Studies Depression Scale (CES-D). This short form of the CES-D has good reliability and has been used widely in studies of adolescent depression (Dunn et al., 2013). In our overall sample, the Cronbach’s = 0.80; internal consistency was invariant across age. The items included:
> * "bothered by things that usually don't bother you"
> * "could not shakeoff the blues"
> * "felt that you were just as good as other people [reverse coded]"
> * "had trouble keeping your mind on what you were doing"
> * "were depressed"
> * "were too tired to do things"
> * "enjoyed life [reverse coded]"
> * "were sad"
> * "felt that people disliked you"

> Each item was rated on a scale of 0–3, representing whether an individual experienced the symptom "never/rarely" to "most/all of the time."

> We examined three substance use behaviors: daily smoking, past-month marijuana use, and regular heavy episodic drinking (HED). Smoking was assessed as days smoked out of the past 30 days; this was dichotomized to indicate whether individuals smoked on all of the past 30 days. Marijuana use was assessed as times used during the past month; this was dichotomized into any/no past month marijuana use. Frequency of HED (Wave I–III definition: 5+ drinks; Wave IV definition: 4+ drinks for females, 5+ drinks for males) during the past year was assessed; this was dichotomized into any/no regular past year HED, where regular HED was defined as at least one time per month for the past 12 months.


### Baseline variables

| variable      | code    | wave | description
| :------------ | :------ | :--  | :----------
| [`sex`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/codebookssearch?field=varname&match=contains&text=BIO_SEX) | BIO_SEX | 1    | Interviewer, please confirm that R’s sex is (male) female. (Ask if necessary.)
| [`bday_m`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2) | H1GI1M | 1    | What is your birth date? (month)
| [`bday_y`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2) | H1GI1Y | 1    | What is your birth date? (year)


### Meta data

[`month, day, year`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2416)

| code    | wave | description
| :------ | :--- | :----------
| IMONTH  | 1-4  |  Month interview completed
| IDAY    | 1-4  |  Day interview completed
| IYEAR   | 1-4  |  Year interview completed

### Depedent Variable

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

### Longitudinal covariates

[`cigarettes`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2075)

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

[`drink`](http://www.cpc.unc.edu/projects/addhealth/codebooks/ace/tool/variablecollection?VariableCollectionId=2008)

| code    | wave | description
| :------ | :--- | :----------
| H1TO15  | 1    | During the past 12 months, on how many days did you drink alcohol?
| H2TO19  | 2    | During the past 12 months, on how many days did you drink alcohol?
| H3TO38  | 3    | During the past 12 months, on how many days did you drink alcohol?
| H4TO35  | 4    | During the past 12 months, on how many days did you drink alcohol?
