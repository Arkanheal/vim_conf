require('telescope').setup{
  defaults = {
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    set_env = { COLORTERM = 'truecolor' },
    file_previewer = require'telescope.previewers'.cat.new,
    grep_previewer = require'telescope.previewers'.vimgrep.new,
    qflist_previewer = require'telescope.previewers'.qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
