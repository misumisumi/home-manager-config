" Dein(プラグインマネージャー)の設定
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
" プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.config/nvim')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,	   {'lazy':0})
  call dein#load_toml(s:lazy_toml, {'lazy':1})
  call dein#end()
  call dein#save_state()
endif

" auto install dein.vim
let s:dein_dir = "~/.cache/dein"
let s:dein_url = "https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh"
if !filereadable(s:dein_dir)
  call system(printf('mkdir -p %s', s:dein_dir))
  call system(printf('curl %s > %s/install.sh', s:dein_url, s:dein_dir))
  call system(printf('sh %s/install.sh %s', s:dein_dir, s:dein_dir))
endif

if dein#check_install()
    call dein#install()
endif

"deinの自動更新
let g:dein#auto_recache = 1

