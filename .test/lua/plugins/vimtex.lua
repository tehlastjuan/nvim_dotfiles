return {

  {
    "lervag/vimtex",
    -- opt = true,
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
      vim.g.vimtex_view_method = "zathura"
      --vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
      vim.g.vimtex_view_general_viewer = "zathura"
      vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex", }
      vim.g.tex_comment_nospell = 1
      vim.g.vimtex_compiler_progname = "latexrun"
      --vim.g.vimtex_compiler_method = "latexrun"
      vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
      -- vim.g.vimtex_view_general_options_latexmk = '--unique'
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
    end,
    keys = {
      { "<localLeader>l", "", desc = "+vimtex" },
    },
    ft = "tex",
  },

}
