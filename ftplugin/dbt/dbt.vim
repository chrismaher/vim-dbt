command! -nargs=* Run exe dbt#Run(<args>)
command! -nargs=* Test exe dbt#Test(<args>)
command! -nargs=0 Close call dbt#CloseTerm()
