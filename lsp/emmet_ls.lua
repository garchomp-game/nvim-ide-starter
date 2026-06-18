-- emmet_ls: Emmet Language Server 設定
return {
  cmd = { 'emmet-ls', '--stdio' },
  filetypes = { 'html', 'css', 'scss', 'typescriptreact', 'javascriptreact' },
  root_markers = { '.git', 'package.json' },
}
