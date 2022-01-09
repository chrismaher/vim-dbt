if exists("b:current_syntax")
    finish
endif

hi Passes term=bold ctermfg=DarkGreen
match Passes /\[\zsPASS\ze/
hi Failures term=bold ctermfg=DarkRed
2match Failures /\[\zsFAIL \d\+\ze/
hi Warnings term=bold ctermfg=DarkYellow
3match Warnings /\[\zsWARN \d\+\ze/

let b:current_syntax = "dbtout"
