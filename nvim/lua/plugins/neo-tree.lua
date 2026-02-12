return {
  "nvim-neo-tree/neo-tree.nvim",
  -- プラグイン読み込み時に実行される処理
  init = function()
    -- 1. 起動時にファイル指定がある場合 (nvim filename)
    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Open Neo-Tree automatically on startup with args",
      callback = function()
        if vim.fn.argc() > 0 then
          require("neo-tree.command").execute({ action = "show" })
        end
      end,
    })

    -- 2. ダッシュボードからファイルを開いた場合 (後から読み込まれた時)
    vim.api.nvim_create_autocmd("BufReadPost", {
      desc = "Open Neo-Tree automatically on first file open",
      callback = function()
        -- ファイル名があり、かつ特定の除外ファイルタイプでない場合
        local file = vim.fn.expand("%")
        if file ~= "" and vim.bo.filetype ~= "gitcommit" then
          require("neo-tree.command").execute({ action = "show" })
          -- 一度実行したらこの自動コマンドを削除する (ファイルを開くたびにツリーが再表示されるのを防ぐため)
          return true
        end
      end,
    })
  end,
}
