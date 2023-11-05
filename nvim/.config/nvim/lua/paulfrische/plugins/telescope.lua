return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
  },
  keys = {
    '<leader>f',
    '<leader>ds',
    '<leader>ws',
    '<leader>s',
    '<leader>a',
  },
  cmd = { 'Telescope', 'TH' },
  config = function()
    local builtin = require('telescope.builtin')
    local telescope = require('telescope')

    telescope.setup({
      extensions = {
        ['fzf'] = {
          override_generic_sorter = true,
        },
        ['ui-select'] = {},
      },
      defaults = {
        sorting_strategy = 'ascending',
        borderchars = {
          { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          prompt = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
          results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
          preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        },

        prompt_prefix = ' 🔎 ',
        selection_caret = '➡️ ',

        file_ignore_patterns = {
          '__pycache__/',
          'node_modules/',
          '.git/',
        },

        layout_strategy = 'center',
        layout_config = {
          anchor = 'N',
        },
      },
    })

    local ok, err = pcall(telescope.load_extension, 'fzf')
    if not ok then
      print(err)
    end

    telescope.load_extension('ui-select')

    local map = require('paulfrische.util').map

    map('n', '<leader>f', builtin.find_files, 'find file')
    map('n', '<leader>ds', builtin.lsp_document_symbols, 'document symbols')
    map(
      'n',
      '<leader>ws',
      builtin.lsp_dynamic_workspace_symbols,
      'workspace symbols'
    )
    map('n', '<leader>s', function()
      builtin.grep_string({ search = vim.fn.input('Grep > ') })
    end, 'find string in project')

    vim.api.nvim_create_user_command('TH', 'Telescope help_tags', {})
  end,
}
