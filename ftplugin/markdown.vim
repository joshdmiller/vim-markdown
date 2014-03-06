" Vim filetype plugin
" Language:		Markdown
" Maintainer:		Josh David Miller <josh@joshdavidmiller.com>
" Last Change:		2014 March 04

if exists("b:did_ftplugin")
  finish
endif

runtime! ftplugin/html.vim ftplugin/html_*.vim ftplugin/html/*.vim

setlocal comments=fb:*,fb:-,fb:+,n:> commentstring=>\ %s
setlocal formatoptions+=tcqln formatoptions-=r formatoptions-=o
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= "|setl cms< com< fo< flp<"
else
  let b:undo_ftplugin = "setl cms< com< fo< flp<"
endif

func! Foldexpr_markdown(lnum)
    let l1 = getline(a:lnum)

" ignore empty lines
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    let l2 = getline(a:lnum+1)

    if l2 =~ '^==\+\s*'
" next line is underlined (level 1)
        return '>1'
    elseif l2 =~ '^--\+\s*'
" next line is underlined (level 2)
        return '>2'
    elseif l1 =~ '^#'
" current line starts with hashes
        return '>'.matchend(l1, '^#\+')
    elseif a:lnum == 1
" fold any 'preamble'
        return '>1'
    else
" keep previous foldlevel
        return '='
    endif
endfunc

" setlocal foldexpr=Foldexpr_markdown(v:lnum)
" setlocal foldmethod=expr

"  vim:set sw=2:
