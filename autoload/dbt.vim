if !exists('g:dbt_target')
    let g:dbt_target = 'dev'
endif

if !exists('g:dbt_term_vertical')
    let g:dbt_term_vertical = 1
endif

if !exists('g:dbt_term_splitright')
    let g:dbt_term_splitright = 1
endif

function! s:DBT(...)
    let models = a:0 > 0 ? join(a:000, ' ') : expand('%:t:r')
    let cmd = s:cmd_start . models . " --target " . g:dbt_target
    if has('terminal')
        let cmd = "vert ter " . cmd
    endif
    let _splitright = &splitright
    set splitright
    exe cmd
    let &splitright = _splitright
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

function! dbt#Config(...)
    if a:0 == 0
        echoerr ""
    endif

    try
        let win_view = winsaveview()
        let old_query = getreg('/')
        exe "norm! gg"
        let result = search('config(', 'e')
        if result == 0

        elseif result == 1
            exe "norm! %i <ESC>"
        else
            exe "norm! %O, <ESC>"
        endif

        for f in config
            let pair = split(trim(f), '=')

        endfor
    finally
        call winrestview(win_view)
        call setreg('/', old_query)
    endtry
endfunction
