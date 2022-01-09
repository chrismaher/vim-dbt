if exists('g:loaded_dbt')
    finish
endif
let g:loaded_dbt = 1

if !exists('g:dbt')
    if executable('dbt')
        let g:dbt  = 'dbt'
    else
        echohl WarningMsg
        echo 'dbt not found'
        echohl None
    endif
endif

command! -nargs=* -complete=customlist,dbt#Models DbtRun execute dbt#Exec('run', <q-args>)
command! -nargs=* -complete=customlist,dbt#Models DbtTest execute dbt#Exec('test', <q-args>)
command! -nargs=* DbtRef execute dbt#OpenRefs(<q-args>)
command! -nargs=? DbtSchema execute dbt#OpenSchema(<q-args>)

" Plugin mappings
nnoremap <silent> <buffer> <Plug>(dbt-run) :<C-u>call dbt#Exec('run')<CR>
nnoremap <silent> <buffer> <Plug>(dbt-test) :<C-u>call dbt#Exec('test')<CR>
