if !exists('g:dbt_target')
    let g:dbt_target = 'dev'
endif

if !exists('g:dbt_vertical')
    let g:dbt_vertical = 1
endif

if !exists('g:dbt_splitright')
    let g:dbt_splitright = 1
endif

function! s:Exec(cmd)
    let _splitright = &splitright
    let _exec = 'terminal '
    if g:dbt_vertical
        let _exec = 'vertical ' . _exec
    endif
    if g:dbt_splitright
        set splitright
    endif
    execute _exec . a:cmd
    let &splitright = _splitright
endfunction

function! s:DBT(...)
    let models = a:0 > 0 ? join(a:000, ' ') : expand('%:t:r')
    let cmd = s:cmd_start . models . " --target " . g:dbt_target
    call s:Exec(cmd)
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

function! dbt#OpenRefs(...)
    if a:0 == 0
        let model = expand('<cWORD>')
        if model !~? "ref('.*')"
            return
        else
            let models = [strcharpart(model, 5, len(model)-7)]
        endif
    else
        let models = a:000
    endif

    let p = fnamemodify('.', ':p')
    while fnamemodify(p, ':p:h:t') != 'models'
        let p = fnamemodify(p, ':p:h:h')
    endwhile

    for f in split(globpath('.', '**'))
        if index(models, fnamemodify(f, ':t:r')) != -1
            exe 'edit ' . f
        endif
    endfor
endfunction

function! dbt#OpenSchema(...)
    let model = a:0 > 0 ? a:1 : expand('%:t:r')
    let p = fnamemodify('.', ':p')
    while fnamemodify(p, ':p:h') =~# '/models/*'
        for f in split(globpath('.', '*'))
            if f =~# '.*\.yml$'
                exe "edit " . f | exe "normal! /name: " . model . "\<CR>"
                return
            endif
        endfor
        let p = fnamemodify(p, ':p:h:h')
    endwhile
endfunction
