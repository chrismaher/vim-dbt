if !exists('g:dbt_target')
    let g:dbt_target = 'workspace'
endif

if !exists('g:dbt_window')
    let g:dbt_window = 'vertical'
endif

function! s:ModelsDir()
    let path = fnamemodify('.', ':p')
    while fnamemodify(path, ':p:h:t') != 'models'
        let path = fnamemodify(path, ':p:h:h')
    endwhile
    return path
endfunction

function! s:Job(cmd)
    let _exec = ''
    if g:dbt_window != ''
        let _exec = g:dbt_window . ' '
    endif

    let _buf = '1.dbtout'
    if bufwinnr(_buf) == -1
        let cmd = _exec . 'new ' . _buf
        echom cmd
        execute cmd
        set buftype=nofile
        " nowrap should be an option?
        setlocal nonumber nowrap
    else
        let bn = bufnr(_buf)
        if bn == -1
            execute _exec . 'sbuffer '. _buf
        else
            execute bufwinnr(bn) 'wincmd w'
        endif
        set modifiable
        execute 'normal! ggdG'
    endif

    call job_start(a:cmd, {'out_io': 'buffer', 'out_name': _buf, 'out_modifiable': 0}) " NERD_tree_1
    wincmd p
endfunction

function! dbt#Models(A, L, P)
    let path = s:ModelsDir()
    return map(split(globpath(path, '**/' . a:A . '*.sql')), {_, v -> fnamemodify(v, ':t:r')})
endfunction

function! dbt#Exec(cmd, ...)
    let args = filter(copy(a:000), {_, v -> len(v) != 0})
    let models = len(args) > 0 ? join(args, ' ') : expand('%:t:r')
    let cmd = "dbt ". a:cmd . " --models " . models
    call s:Job(cmd)
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
