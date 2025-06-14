" plugin/wrap_tag.vim
if exists('g:loaded_wrap_tag') || &cp
  finish
endif
let g:loaded_wrap_tag = 1

function! s:WrapWithTag(type) abort
  let l:raw_input = input('Tag (> для построчной обёртки): ')
  if empty(l:raw_input)
    return
  endif

  let l:raw_input = substitute(l:raw_input, '^>\(\S\)', '> \1', '')
  let l:parts = split(l:raw_input)

  let l:is_line_wrap = (get(l:parts, 0, '') ==# '>')
  let l:tags_str = l:is_line_wrap ? join(l:parts[1:], ' ') : join(l:parts, ' ')
  if empty(l:tags_str)
    echo '❌ Не указан тег'
    return
  endif

  " Разбор вложенных тегов
  let l:tag_defs = split(l:tags_str)
  let l:open_tags = []
  let l:close_tags = []

  for def in l:tag_defs
    let tag = ''
    let id = ''
    let class = ''
    let attr = ''

    let is_a_blank = def =~# '^a_blank'

    if is_a_blank
      let tag = 'a'
      let rest = substitute(def, '^a_blank', '', '')
      if rest =~# '\.'
        let class = matchstr(rest, '\.\zs.*')
      endif
      let attr .= ' href="" target="_blank" rel="nofollow"'
    else
      let tag = matchstr(def, '^[^#.\s]\+')
      let id = matchstr(def, '#\zs[^.]*')
      let class = matchstr(def, '\.\zs.*')

      if tag ==# 'a'
        let attr .= ' href=""'
      endif
      if id !=# ''
        let attr .= ' id="'.id.'"'
      endif
      if class !=# ''
        let attr .= ' class="'.class.'"'
      endif
    endif


    call add(l:open_tags, '<'.tag.attr.'>')
    call insert(l:close_tags, '</'.tag.'>')
  endfor

  let l:open_str = join(l:open_tags, '')
  let l:close_str = join(l:close_tags, '')

  " === Далее остальная часть без изменений ===
  if a:type ==# 'v'
    let [line1, col1] = getpos("'<")[1:2]
    let [line2, col2] = getpos("'>")[1:2]

    if line1 != line2
      let l:lines = getline(line1, line2)
      let l:lines[0] = l:lines[0][col1-1 :]
      let l:lines[-1] = l:lines[-1][: col2-1]
      let l:wrapped = [l:open_str] + l:lines + [l:close_str]
      call setline(line1, l:wrapped)
      if line2 > line1 + len(l:wrapped) - 1
        execute (line1 + len(l:wrapped)) . ',' . line2 . 'delete _'
      endif
      return
    endif

    let l:line = getline(line1)
    if col2 < col1
      let [col1, col2] = [col2, col1]
    endif

    let l:start = col1 - 1
    let l:end = col2 - 1

    while l:start > 0 && l:line[l:start] =~ '[\x80-\xBF]'
      let l:start -= 1
    endwhile
    while l:end < strlen(l:line) - 1 && l:line[l:end + 1] =~ '[\x80-\xBF]'
      let l:end += 1
    endwhile

    let l:has_trailing_space = 0
    if l:end < strlen(l:line) - 1 && l:line[l:end + 1] ==# ' '
      let l:has_trailing_space = 1
    endif

    if l:line[l:end] ==# ' '
      let l:end -= 1
      let l:has_trailing_space = 1
    endif

    let l:newline = strpart(l:line, 0, l:start) .
          \ l:open_str .
          \ strpart(l:line, l:start, l:end - l:start + 1) .
          \ l:close_str .
          \ (l:has_trailing_space ? ' ' : '') .
          \ strpart(l:line, l:end + 1 + (l:has_trailing_space ? 1 : 0))

    call setline(line1, l:newline)

  elseif a:type ==# 'V'
    let l:start = line("'<")
    let l:end = line("'>")

    if l:is_line_wrap
      for lnum in range(l:start, l:end)
        let l:line = getline(lnum)
        if l:line =~ '^\s*$'
          continue
        endif
        call setline(lnum, l:open_str . l:line . l:close_str)
      endfor
    else
      let l:lines = getline(l:start, l:end)
      let l:wrapped = [l:open_str] + l:lines + [l:close_str]
      call setline(l:start, l:wrapped)
      if l:end > l:start + len(l:wrapped) - 1
        execute (l:start + len(l:wrapped)) . ',' . l:end . 'delete _'
      endif
    endif

  else
    let l:line = getline('.')
    call setline('.', l:open_str . l:line . l:close_str)
  endif
endfunction


" Маппинги через <Plug> для лучшей совместимости
nnoremap <silent> <Plug>WrapTag :call <SID>WrapWithTag('n')<CR>
vnoremap <silent> <Plug>WrapTag :<C-u>call <SID>WrapWithTag(visualmode())<CR>
inoremap <silent> <Plug>WrapTag <Esc>:call <SID>WrapWithTag('n')<CR>

" Стандартные маппинги, если не отключены в настройках
if !exists('g:wrap_tag_no_mappings') || !g:wrap_tag_no_mappings
  nmap <leader>w <Plug>WrapTag
  vmap <leader>w <Plug>WrapTag
  imap <leader>w <Plug>WrapTag
endif
