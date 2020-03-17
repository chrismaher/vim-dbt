function! DetectDBT()
    let l:root = fnamemodify('~', ':p')
    " should be using the filepath, not cwd
    let l:cwd = getcwd()

    while (l:cwd . '/') != l:root
        let s:dbt_project = join([l:cwd, "dbt_project.yml"], "/")
        if filereadable(s:dbt_project)
            " this is hacky, as it sets ft for a second time
            " probably better off using after/
            set filetype=dbt
        endif
        let l:cwd = fnamemodify(l:cwd, ':h')
	endwhile
endfunction

au BufNewFile,BufRead *.sql call DetectDBT()
