function! DetectDBT()
    let root = fnamemodify('~', ':p')
    let cwd = expand('%:p:h')

    while (cwd . '/') != root && cwd =~# root
        let dbt_project = join([cwd, "dbt_project.yml"], "/")
        if filereadable(dbt_project)
            " this is hacky, as it sets ft for a second time
            " probably better off using after/
            set filetype=dbt
        endif
        let cwd = fnamemodify(cwd, ':h')
	endwhile
endfunction

au BufNewFile,BufRead *.sql,*.yml call DetectDBT()
