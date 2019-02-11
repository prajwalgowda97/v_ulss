merge -overwrite -out cov_merged_output test*
load -run ./cov_work/scope/cov_merged_output


report -detail -all -text -out cov_report.txt
report -detail -text -out cov_uncovered_report.txt
report -detail -html -out ./cov_report_html
