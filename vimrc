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

function MyTabLine()
    let tabline = ''
    " Формируем tabline для каждой вкладки -->
    for i in range(tabpagenr('$'))
        " Подсвечиваем заголовок выбранной в данный момент вкладки.
        if i + 1 == tabpagenr()
            let tabline .= '%#TabLineSel#'
        else
            let tabline .= '%#TabLine#'
        endif

        " Устанавливаем номер вкладки
        let tabline .= '%' . (i + 1) . 'T'

        " Получаем имя вкладки
        let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
    endfor
    " Формируем tabline для каждой вкладки <--

    " Заполняем лишнее пространство
    let tabline .= '%#TabLineFill#%T'

    " Выровненная по правому краю кнопка закрытия вкладки
    if tabpagenr('$') > 1
        let tabline .= '%=%#TabLine#%999XX'
    endif

    return tabline
endfunction

function MyTabLabel(n)
    let label = ''
    let buflist = tabpagebuflist(a:n)

    " Имя файла и номер вкладки -->
    let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')

    if label == ''
      let label = '[No Name]'
    endif

    let label .= ' (' . a:n . ')'
    " Имя файла и номер вкладки <--

    " Определяем, есть ли во вкладке хотя бы один
    " модифицированный буфер.
    " -->
    for i in range(len(buflist))
        if getbufvar(buflist[i], "&modified")
            let label = '[+] ' . label
            break
        endif
    endfor
    " <--

    return label
endfunction
