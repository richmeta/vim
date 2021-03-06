" Vim color file - nature
" Generated by http://bytefluent.com/vivify 2014-02-04
set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "nature"

"hi IncSearch -- no settings --
"hi WildMenu -- no settings --
"hi SignColumn -- no settings --
hi SpecialComment guifg=#729FCF guibg=#000000 guisp=#000000 gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Typedef guifg=#4E9A06 guibg=#000000 guisp=#000000 gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi Title guifg=#EEEEEC guibg=#06989A guisp=#06989A gui=NONE ctermfg=255 ctermbg=30 cterm=NONE
"hi Folded -- no settings --
hi PreCondit guifg=#EEEEEC guibg=#000000 guisp=#000000 gui=bold ctermfg=255 ctermbg=NONE cterm=bold
hi Include guifg=#EEEEEC guibg=#000000 guisp=#000000 gui=bold ctermfg=255 ctermbg=NONE cterm=bold
"hi TabLineSel -- no settings --
hi StatusLineNC guifg=#D3D7CF guibg=#000000 guisp=#000000 gui=bold,underline ctermfg=151 ctermbg=NONE cterm=bold,underline
"hi CTagsMember -- no settings --
hi NonText guifg=#555753 guibg=#000000 guisp=#000000 gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE
"hi CTagsGlobalConstant -- no settings --
"hi DiffText -- no settings --
hi ErrorMsg guifg=#EF2929 guibg=#000000 guisp=#000000 gui=bold ctermfg=196 ctermbg=NONE cterm=bold
"hi Ignore -- no settings --
hi Debug guifg=#729FCF guibg=#000000 guisp=#000000 gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=NONE guibg=#000000 guisp=#000000 gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Identifier guifg=#34E2E2 guibg=#000000 guisp=#000000 gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#729FCF guibg=#000000 guisp=#000000 gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Conditional guifg=#4E9A06 guibg=#000000 guisp=#000000 gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#4E9A06 guibg=#000000 guisp=#000000 gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
"hi Todo -- no settings --
hi Special guifg=#729FCF guibg=#000000 guisp=#000000 gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi LineNr guifg=#C4A000 guibg=#000000 guisp=#000000 gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#EEEEEC guibg=#000000 guisp=#000000 gui=bold,underline ctermfg=255 ctermbg=NONE cterm=bold,underline
hi Normal guifg=#D3D7CF guibg=#000000 guisp=#000000 gui=NONE ctermfg=151 ctermbg=NONE cterm=NONE
hi Label guifg=#4E9A06 guibg=#000000 guisp=#000000 gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
"hi CTagsImport -- no settings --
hi PMenuSel guifg=#EEEEEC guibg=#000000 guisp=#000000 gui=NONE ctermfg=255 ctermbg=NONE cterm=NONE
"hi Search -- no settings --
"hi CTagsGlobalVariable -- no settings --
hi Delimiter guifg=#729FCF guibg=#000000 guisp=#000000 gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Statement guifg=#8AE234 guibg=#000000 guisp=#000000 gui=bold ctermfg=113 ctermbg=NONE cterm=bold
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
hi Comment guifg=#555753 guibg=#000000 guisp=#000000 gui=italic ctermfg=240 ctermbg=NONE cterm=NONE
hi Character guifg=#3465A4 guibg=#000000 guisp=#000000 gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
"hi Float -- no settings --
hi Number guifg=#06989A guibg=#000000 guisp=#000000 gui=NONE ctermfg=30 ctermbg=NONE cterm=NONE
hi Boolean guifg=#3465A4 guibg=#000000 guisp=#000000 gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi Operator guifg=#4E9A06 guibg=#000000 guisp=#000000 gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
"hi CursorLine -- no settings --
"hi Union -- no settings --
"hi TabLineFill -- no settings --
"hi Question -- no settings --
hi WarningMsg guifg=#FCE94F guibg=#000000 guisp=#000000 gui=NONE ctermfg=227 ctermbg=NONE cterm=NONE
"hi VisualNOS -- no settings --
"hi DiffDelete -- no settings --
"hi ModeMsg -- no settings --
"hi CursorColumn -- no settings --
hi Define guifg=#EEEEEC guibg=#000000 guisp=#000000 gui=bold ctermfg=255 ctermbg=NONE cterm=bold
hi Function guifg=#34E2E2 guibg=#000000 guisp=#000000 gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
"hi FoldColumn -- no settings --
hi PreProc guifg=#EEEEEC guibg=#000000 guisp=#000000 gui=bold ctermfg=255 ctermbg=NONE cterm=bold
"hi EnumerationName -- no settings --
hi Visual guifg=#EEEEEC guibg=#555753 guisp=#555753 gui=NONE ctermfg=255 ctermbg=240 cterm=NONE
"hi MoreMsg -- no settings --
"hi SpellCap -- no settings --
hi VertSplit guifg=#EEEEEC guibg=#000000 guisp=#000000 gui=NONE ctermfg=255 ctermbg=NONE cterm=NONE
hi Exception guifg=#4E9A06 guibg=#000000 guisp=#000000 gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi Keyword guifg=#4E9A06 guibg=#000000 guisp=#000000 gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi Type guifg=#4E9A06 guibg=#000000 guisp=#000000 gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
"hi DiffChange -- no settings --
hi Cursor guifg=#EEEEEC guibg=#EEEEEC guisp=#EEEEEC gui=NONE ctermfg=255 ctermbg=255 cterm=NONE
"hi SpellLocal -- no settings --
hi Error guifg=#EEEEEC guibg=#EF2929 guisp=#EF2929 gui=bold,underline ctermfg=255 ctermbg=196 cterm=bold,underline
hi PMenu guifg=#D3D7CF guibg=#000000 guisp=#000000 gui=NONE ctermfg=151 ctermbg=NONE cterm=NONE
"hi SpecialKey -- no settings --
hi Constant guifg=#06989A guibg=#000000 guisp=#000000 gui=NONE ctermfg=30 ctermbg=NONE cterm=NONE
"hi DefinedName -- no settings --
hi Tag guifg=#729FCF guibg=#000000 guisp=#000000 gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi String guifg=#06989A guibg=#000000 guisp=#000000 gui=NONE ctermfg=30 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=NONE guibg=#C4A000 guisp=#C4A000 gui=NONE ctermfg=NONE ctermbg=1 cterm=NONE
"hi MatchParen -- no settings --
"hi LocalVariable -- no settings --
hi Repeat guifg=#FCE94F guibg=#000000 guisp=#000000 gui=bold ctermfg=227 ctermbg=NONE cterm=bold
"hi SpellBad -- no settings --
"hi CTagsClass -- no settings --
hi Directory guifg=#34E2E2 guibg=#3465A4 guisp=#3465A4 gui=NONE ctermfg=80 ctermbg=67 cterm=NONE
hi Structure guifg=#4E9A06 guibg=#000000 guisp=#000000 gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi Macro guifg=#EEEEEC guibg=#000000 guisp=#000000 gui=bold ctermfg=255 ctermbg=NONE cterm=bold
hi Underlined guifg=#AD7FA8 guibg=#000000 guisp=#000000 gui=bold,underline ctermfg=139 ctermbg=NONE cterm=bold,underline
"hi DiffAdd -- no settings --
"hi TabLine -- no settings --
hi cursorim guifg=#242424 guibg=#96cdcd guisp=#96cdcd gui=NONE ctermfg=235 ctermbg=152 cterm=NONE
"hi clear -- no settings --
hi sql_statement guifg=#9400d3 guibg=NONE guisp=NONE gui=NONE ctermfg=92 ctermbg=NONE cterm=NONE
hi cics_statement guifg=#4e9a06 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi lcursor guifg=#ffffff guibg=#0080f0 guisp=#0080f0 gui=NONE ctermfg=15 ctermbg=33 cterm=NONE
hi namespace guifg=#006400 guibg=NONE guisp=NONE gui=NONE ctermfg=22 ctermbg=NONE cterm=NONE
hi builtin guifg=#1e90ff guibg=NONE guisp=NONE gui=NONE ctermfg=33 ctermbg=NONE cterm=NONE
hi tablinefillsel guifg=#0000ff guibg=NONE guisp=NONE gui=NONE ctermfg=21 ctermbg=NONE cterm=NONE
