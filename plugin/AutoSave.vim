"======================================
"    Script Name:  vim-auto-save (http://www.vim.org/scripts/script.php?script_id=4521)
"    Plugin Name:  AutoSave
"        Version:  0.1.5
"  Last Modified:  09.15.2014 07:59
"======================================

if exists("g:auto_save_loaded")
  finish
else
  let g:auto_save_loaded = 1
endif

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:auto_save")
  let g:auto_save = 0
endif

if !exists("g:auto_save_no_updatetime")
  let g:auto_save_no_updatetime = 0
endif

if g:auto_save_no_updatetime == 0
  set updatetime=200
endif

if !exists("g:auto_save_silent")
  let g:auto_save_silent = 0
endif

au CursorHold,CursorHoldI,InsertLeave * call AutoSave()
command! AutoSaveToggle :call AutoSaveToggle()

function! AutoSave()
  if g:auto_save >= 1
    let was_modified = &modified
    silent! wa
    if was_modified && !&modified && g:auto_save_silent == 0
      echo "(AutoSaved at " . strftime("%H:%M:%S") . ")"
    endif
  endif
endfunction

function! AutoSaveToggle()
  if g:auto_save >= 1
    let g:auto_save = 0
    echo "AutoSave is OFF"
  else
    let g:auto_save = 1
    echo "AutoSave is ON"
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
