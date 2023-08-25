vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('paulfrische.plugins', {
  checker = {
    enabled = true,
    concurrency = 5,
    notify = false,
  }
})

pcall(require, 'paulfrische.set')
pcall(require, 'paulfrische.remap')
pcall(require, 'paulfrische.disable-builtin')
pcall(require, 'paulfrische.autocommands')
-- pcall(require, 'paulfrische.statusline')
