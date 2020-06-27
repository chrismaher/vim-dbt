command! -nargs=* DbtRun exe dbt#DBT('run', <q-args>)
command! -nargs=* DbtTest exe dbt#DBT('test', <q-args>)
command! -nargs=0 DbtClose call dbt#CloseTerm()
command! -nargs=* DbtRef exe dbt#OpenRefs(<q-args>)
command! -nargs=? DbtSchema exe dbt#OpenSchema(<q-args>)

" Plugin mappings
nnoremap <silent> <Plug>(dbt-run) :<C-u>call dbt#Run()<CR>
nnoremap <silent> <Plug>(dbt-test) :<C-u>call dbt#Test()<CR>
nnoremap <silent> <Plug>(dbt-close) :<C-u>call dbt#CloseTerm()<CR>
