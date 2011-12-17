set autoindent
set number
set cindent
set expandtab
set tabstop=4
retab
set shiftwidth=4
syntax on

set wildmenu
set wcm=<Tab>
menu Encoding.utf-8 :e ++enc=utf8 <CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
map <F6> :emenu Encoding.<TAB>

imap <F2> <Esc>:tabprevious<CR>i
nmap <F2> :tabprevious<CR>
imap <F3> <Esc>:tabnext<CR>i
nmap <F3> :tabnext<CR>
imap <C-o> <Esc>:tabnew<Space>
nmap <C-o> :tabnew<Space>

set makeprg=make\ -j4
nmap <C-b> :w<CR>:make<CR>:cw<CR>

function MyTabLine()
    let tabline = ''
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let tabline .= '%#TabLineSel#'
        else
            let tabline .= '%#TabLine#'
        endif

        let tabline .= '%' . (i + 1) . 'T'

        let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
    endfor

    let tabline .= '%#TabLineFill#%T'

    if tabpagenr('$') > 1
        let tabline .= '%=%#TabLine#%999XX'
    endif

    return tabline
endfunction

function MyTabLabel(n)
    let label = ''
    let buflist = tabpagebuflist(a:n)

    let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')

    if label == ''
      let label = '[No Name]'
    endif

    let label .= ' (' . a:n . ')'

    for i in range(len(buflist))
        if getbufvar(buflist[i], "&modified")
            let label = '[+] ' . label
            break
        endif
    endfor

    return label
endfunction

map <Space> <C-d>
map <BS> <C-u>

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
