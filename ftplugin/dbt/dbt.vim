command! -nargs=* -complete=customlist,dbt#Models DbtRun execute dbt#Exec('run', <q-args>)
command! -nargs=* -complete=customlist,dbt#Models DbtTest execute dbt#Exec('test', <q-args>)
command! -nargs=0 DbtClose call dbt#CloseTerm()
command! -nargs=* DbtRef execute dbt#OpenRefs(<q-args>)
command! -nargs=? DbtSchema execute dbt#OpenSchema(<q-args>)

" Plugin mappings
nnoremap <silent> <Plug>(dbt-run) :<C-u>call dbt#Exec('run')<CR>
nnoremap <silent> <Plug>(dbt-test) :<C-u>call dbt#Exec('test')<CR>
nnoremap <silent> <Plug>(dbt-close) :<C-u>call dbt#CloseTerm()<CR>
