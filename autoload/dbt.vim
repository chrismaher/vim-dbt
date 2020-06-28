if !exists('g:dbt_target')
    let g:dbt_target = 'dev'
endif

if !exists('g:dbt_vertical')
    let g:dbt_vertical = 1
endif

if !exists('g:dbt_splitright')
    let g:dbt_splitright = 1
endif

if !exists('g:dbt_term_buffer')
    let g:dbt_term_buffer = '__dbt__'
endif

function! s:ModelsDir()
    let path = fnamemodify('.', ':p')
    while fnamemodify(path, ':p:h:t') != 'models'
        let path = fnamemodify(path, ':p:h:h')
    endwhile
    return path
endfunction

function! s:send_command(cmd)
    let bnr = bufnr(g:dbt_term_buffer)
    echom a:cmd
    if bnr < 1
        call term_start('bash --noprofile --norc', {'term_name': g:dbt_term_buffer, 'vertical': 1, 'term_cols': '60'})
    else
        call term_sendkeys(bnr, a:cmd . "\<cr>")
    endif
endfunction

function! s:Split(cmd)
    let _splitright = &splitright
    " let _exec = 'terminal '
    " if g:dbt_vertical
    "     let _exec = 'vertical ' . _exec
    " endif
    if g:dbt_splitright
        set splitright
    endif
    " execute _exec . a:cmd
    call s:send_command(a:cmd)
    let &splitright = _splitright
endfunction

function! dbt#Models(A, L, P)
    let path = s:ModelsDir()
    return  map(split(globpath(path, '**/' . a:A . '*.sql')), {_, v -> fnamemodify(v, ':t:r')})
endfunction

function! dbt#Exec(cmd, ...)
    let args = filter(copy(a:000), {_, v -> len(v) != 0})
    let models = len(args) > 0 ? join(args, ' ') : expand('%:t:r')
    let cmd = "dbt ". a:cmd . " --models " . models . " --target " . g:dbt_target
    call s:Split(cmd)
    let s:dbt_terminal = bufname("%")
    wincmd p
endfunction

function! dbt#CloseTerm()
    let buffer = bufnr(s:dbt_terminal . '*')
    execute 'bdelete!' . buffer
endfunction

function! dbt#OpenRefs(...)
    let args = filter(copy(a:000), {_, v -> len(v) != 0})
    if len(args) == 0
        let model = expand('<cWORD>')
        if model !~? "ref('.*')"
            return
        else
            let models = [matchstr(model, '\vref\(''\zs.*\ze''\)')]
        endif
    else
        let models = args
    endif

    let path = s:ModelsDir()

    for fname in split(globpath(path, '**/*.sql'))
        if index(models, fnamemodify(fname, ':t:r')) != -1
            execute 'edit ' . fname
        endif
    endfor
endfunction

function! dbt#OpenSchema(...)
    let args = filter(copy(a:000), {_, v -> len(v) != 0})
    let model = len(args) > 0 ? args[0] : expand('%:t:r')
    let path = expand('%:p:h')
    while fnamemodify(path, ':p:h') =~# '/models/*'
        let files = split(globpath(path, '*.yml'))
        if len(files) == 0
            continue
        elseif len(files) == 1
            " why isn't this opening with cursor on search match?
            execute 'edit +/' . model . ' ' . files[0]
            return
        else
            " handle this as error case
            return
        endif
        let path = fnamemodify(path, ':p:h:h')
    endwhile
endfunction
