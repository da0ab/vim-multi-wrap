if exists('g:loaded_wrap_tag') || &cp
  finish
endif
let g:loaded_wrap_tag = 1

function! s:WrapWithTag(type) abort
  let l:raw_input = input('tag или > tag): ')
  if empty(l:raw_input)
    return
  endif

  let l:raw_input = substitute(l:raw_input, '^>\(\S\)', '> \1', '')
  let l:parts = split(l:raw_input)

  let l:is_line_wrap = (get(l:parts, 0, '') ==# '>')
  let l:tag_part = l:is_line_wrap ? get(l:parts, 1, '') : get(l:parts, 0, '')

  if l:tag_part =~ '\.'
    let [l:tag, l:class] = split(l:tag_part, '\.', 1)
  else
    let l:tag = l:tag_part
    let l:class = ''
  endif

  if empty(l:tag)
    echo '❌ Не указан тег'
    return
  endif

  let l:class_str = l:class !=# '' ? ' class="'.l:class.'"' : ''
  let l:open_tag = '<'.l:tag.l:class_str.'>'
  let l:close_tag = '</'.l:tag.'>'

  if a:type ==# 'v'
    let [line1, col1] = getpos("'<")[1:2]
    let [line2, col2] = getpos("'>")[1:2]

    if line1 != line2
      let l:lines = getline(line1, line2)
      let l:lines[0] = l:lines[0][col1 - 1 :]
      let l:lines[-1] = l:lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 0)]
      let l:wrapped = [l:open_tag] + l:lines + [l:close_tag]
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

    while l:start > 0 && l:line[l:start] =~# '[\x80-\xBF]'
      let l:start -= 1
    endwhile
    while l:end < strlen(l:line) - 1 && l:line[l:end + 1] =~# '[\x80-\xBF]'
      let l:end += 1
    endwhile

    let l:selected = strcharpart(l:line, l:start, strchars(strpart(l:line, l:start, l:end - l:start + 1)))
    let l:before = strpart(l:line, 0, l:start)
    let l:after = strpart(l:line, l:end + 1)

    let l:newline = l:before . l:open_tag . l:selected . l:close_tag . l:after
    call setline(line1, l:newline)

  elseif a:type ==# 'V'
    let l:start = line("'<")
    let l:end = line("'>")

    if l:is_line_wrap
      let l:block = []
      let l:new_lines = []

      for lnum in range(l:start, l:end + 1)
        let l:line = getline(lnum)
        if l:line =~ '^\s*$'
          if !empty(l:block)
            call add(l:new_lines, l:open_tag)
            call extend(l:new_lines, l:block)
            call add(l:new_lines, l:close_tag)
            let l:block = []
          endif
          call add(l:new_lines, l:line)
        else
          call add(l:block, l:line)
        endif
      endfor

      if !empty(l:block)
        call add(l:new_lines, l:open_tag)
        call extend(l:new_lines, l:block)
        call add(l:new_lines, l:close_tag)
      endif

      call setline(l:start, l:new_lines)
      if l:end > l:start + len(l:new_lines) - 1
        execute (l:start + len(l:new_lines)) . ',' . l:end . 'delete _'
      endif
    else
      let l:lines = getline(l:start, l:end)
      let l:wrapped = [l:open_tag] + l:lines + [l:close_tag]
      call setline(l:start, l:wrapped)
      if l:end > l:start + len(l:wrapped) - 1
        execute (l:start + len(l:wrapped)) . ',' . l:end . 'delete _'
      endif
    endif

  else
    let l:line = getline('.')
    call setline('.', l:open_tag . l:line . l:close_tag)
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
