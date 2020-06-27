if !exists('g:dbt_target')
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
