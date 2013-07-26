" Make portals.
" Version: 1.0
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

if exists('g:loaded_portal')
  finish
endif
let g:loaded_portal = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=1 -bar -complete=customlist,portal#_complete
\             PortalShoot call portal#shoot(<q-args>)
command! -bar PortalReset call portal#reset()

nnoremap <silent> <Plug>(portal-gun-blue)   :PortalShoot blue<CR>
nnoremap <silent> <Plug>(portal-gun-orange) :PortalShoot orange<CR>

function! s:make_mapping(mode, lhs, rhs)
  if (exists('g:portal_no_default_key_mappings') &&
  \     g:portal_no_default_key_mappings) ||
  \   hasmapto(a:rhs, a:mode)
    return
  endif
  silent! execute a:mode . 'map <unique> ' a:lhs a:rhs
endfunction
call s:make_mapping('n', '<Leader>pb', '<Plug>(portal-gun-blue)')
call s:make_mapping('n', '<Leader>po', '<Plug>(portal-gun-orange)')

augroup plugin-portal
  autocmd!
  autocmd CursorMoved       * nested call portal#jump()
  autocmd TabEnter          * call portal#show_all()
  autocmd WinEnter,BufEnter * call portal#show()
  autocmd ColorScheme       * call portal#highlight()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
