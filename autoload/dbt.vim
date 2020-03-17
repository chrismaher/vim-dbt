if !existst('g:dbt_target')
    let g:dbt_target = 'dev'
endif

function! s:DBT(...)
    let models = a:0 > 0 ? join(a:000, ' ') : expand('%:t:r')
    let cmd = s:cmd_start . models . " --target " . g:dbt_target
    if has('terminal')
        let cmd = "vert ter " . cmd
    endif
    exe cmd
    let s:dbt_terminal = bufname("%")
    wincmd p
endfunction

function! dbt#Run(...)
    let s:cmd_start = "dbt run -m "
    call call("s:DBT", a:000)
endfunction

function! dbt#Test(...)
    let s:cmd_start = "dbt test -m "
    call call("s:DBT", a:000)
endfunction

function! dbt#CloseTerm()
    let buffer = bufnr(s:dbt_terminal . '*')
    exe 'bd!' . buffer
endfunction
