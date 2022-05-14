" if has_key(plugs, 'vim-sandwich')
  nmap s <Nop>
  xmap s <Nop>

  let g:sandwich_no_default_key_mappings = 1
  " add
  silent! nmap <unique><silent> sa <Plug>(operator-sandwich-add)<Plug>(operator-sandwich-release-count)
  " Shortcuts
  silent! nmap <unique><silent> ss <Plug>(operator-sandwich-add)<Plug>(operator-sandwich-release-count)iw"
  silent! nmap <unique><silent> s' <Plug>(operator-sandwich-add)<Plug>(operator-sandwich-release-count)iw'
  silent! nmap <unique><silent> s" <Plug>(operator-sandwich-add)<Plug>(operator-sandwich-release-count)iw"
  silent! nmap <unique><silent> s` <Plug>(operator-sandwich-add)<Plug>(operator-sandwich-release-count)iw`
  silent! nmap <unique><silent> s( <Plug>(operator-sandwich-add)<Plug>(operator-sandwich-release-count)iw(
  silent! nmap <unique><silent> s[ <Plug>(operator-sandwich-add)<Plug>(operator-sandwich-release-count)iw[
  silent! nmap <unique><silent> s{ <Plug>(operator-sandwich-add)<Plug>(operator-sandwich-release-count)iw{
  silent! nmap <unique><silent> s< <Plug>(operator-sandwich-add)<Plug>(operator-sandwich-release-count)iw<
  " delete
  silent! nmap <unique><silent> sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  silent! nmap <unique><silent> sdb <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
  silent! nmap <unique><silent> sx <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
  " replace
  silent! nmap <unique><silent> sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  silent! nmap <unique><silent> srb <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
  silent! nmap <unique><silent> sc <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)

  " Mappings for Visual mode
  let g:operator_sandwich_no_default_key_mappings = 1
  " add
  silent! xmap <unique> sa <Plug>(operator-sandwich-add)
  " shortcuts for add
  silent! xmap <unique> ss <Plug>(operator-sandwich-add)"
  silent! xmap <unique> s' <Plug>(operator-sandwich-add)'
  silent! xmap <unique> s" <Plug>(operator-sandwich-add)"
  silent! xmap <unique> s` <Plug>(operator-sandwich-add)`
  silent! xmap <unique> s( <Plug>(operator-sandwich-add)(
  silent! xmap <unique> s[ <Plug>(operator-sandwich-add)[
  silent! xmap <unique> s{ <Plug>(operator-sandwich-add){
  silent! xmap <unique> s< <Plug>(operator-sandwich-add)<
  " delete
  silent! xmap <unique> sx <Plug>(operator-sandwich-delete)
  " replace
  silent! xmap <unique> sc <Plug>(operator-sandwich-replace)

" endif
