
#!/bin/bash


#H
mkdir DE_H
python prepare_Metadata_for_DE.py metadataNew.csv /Users/serghei/Dropbox/papers/Vazquez/DE/counts/ DE_H/metadata H

Rscript de.R /Users/serghei/Dropbox/papers/Vazquez/DE/DE_H/metadata_control_steatosis_uncertain_vs_NASH.csv /Users/serghei/Dropbox/papers/Vazquez/DE/DE_H/control_steatosis_uncertain_vs_NASH_H/ control_steatosis_uncertain_vs_NASH_H
Rscript de.R /Users/serghei/Dropbox/papers/Vazquez/DE/DE_H/metadata_control_steatosis_vs_NASH.csv /Users/serghei/Dropbox/papers/Vazquez/DE/DE_H/control_steatosis_vs_NASH_H/ control_steatosis_vs_NASH_H
Rscript de.R /Users/serghei/Dropbox/papers/Vazquez/DE/DE_H/metadata_control_vs_NASH.csv /Users/serghei/Dropbox/papers/Vazquez/DE/DE_H/control_vs_NASH_H/ control_vs_NASH_H
Rscript de.R /Users/serghei/Dropbox/papers/Vazquez/DE/DE_H/metadata_steatosis_unceratin_vs_NASH.csv /Users/serghei/Dropbox/papers/Vazquez/DE/DE_H/steatosis_unceratin_vs_NASH_H/ steatosis_unceratin_vs_NASH_H


#V
mkdir DE_V

python prepare_Metadata_for_DE.py metadataNew.csv /Users/serghei/Dropbox/papers/Vazquez/DE/counts/ DE_V/metadata V

Rscript de.R /Users/serghei/Dropbox/papers/Vazquez/DE/DE_V/metadata_control_steatosis_uncertain_vs_NASH.csv /Users/serghei/Dropbox/papers/Vazquez/DE/DE_V/control_steatosis_uncertain_vs_NASH_V/ control_steatosis_uncertain_vs_NASH_V
Rscript de.R /Users/serghei/Dropbox/papers/Vazquez/DE/DE_V/metadata_control_steatosis_vs_NASH.csv /Users/serghei/Dropbox/papers/Vazquez/DE/DE_V/control_steatosis_vs_NASH_V/ control_steatosis_vs_NASH_V
Rscript de.R /Users/serghei/Dropbox/papers/Vazquez/DE/DE_V/metadata_control_vs_NASH.csv /Users/serghei/Dropbox/papers/Vazquez/DE/DE_V/control_vs_NASH_V/ control_vs_NASH_V
Rscript de.R /Users/serghei/Dropbox/papers/Vazquez/DE/DE_V/metadata_steatosis_unceratin_vs_NASH.csv /Users/serghei/Dropbox/papers/Vazquez/DE/DE_V/steatosis_unceratin_vs_NASH_V/ steatosis_unceratin_vs_NASH_V


