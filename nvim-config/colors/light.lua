-- Vim color scheme: terminal-green
-- Maintainer: You
-- Description: A minimal green terminal colorscheme

-- Clear any existing highlighting
vim.cmd('syntax off')
vim.cmd('highlight clear')

if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

-- Disable true color support
vim.opt.termguicolors = false

-- Set the colorscheme name
vim.g.colors_name = 'terminal-green'

-- day
bmcolor = "223"
mcolor = "black"
-- night
--bmcolor = "black"
--mcolor = "214"
-- Helper function to set highlights
local function hi(group, opts)
  local cmd = 'highlight ' .. group
  if opts.fg then cmd = cmd .. ' ctermfg=' .. opts.fg end
  if opts.bg then cmd = cmd .. ' ctermbg=' .. opts.bg end
  if opts.attr then cmd = cmd .. ' cterm=' .. opts.attr end
  vim.cmd(cmd)
end

local function link(from, to)
  vim.cmd('hi def link ' .. from .. ' ' .. to)
end

-- 1. Define the CORE styles for UI and special elements
hi('Normal', { fg = mcolor, bg = bmcolor, attr = 'NONE' })
hi('Visual', { fg = bmcolor, bg = mcolor, attr = 'NONE' })
hi('PmenuSel', { attr = 'underdashed' })

-- The current match under cursor - add underline only
hi('CurSearch', { bg = mcolor, fg = bmcolor, attr = 'underdashed' })
-- IncSearch is for incremental search (while typing)
hi('IncSearch', { bg = mcolor, fg = bmcolor, attr = 'underdashed' })
hi('Search', { bg = mcolor, fg = bmcolor })

-- Note: These are intentionally 'green'. Change to mcolor if you want
-- absolutely no variation anywhere.
hi('CursorLineNr', { fg = mcolor, bg = bmcolor, attr = 'NONE' })
hi('TabLineSel', { fg = mcolor, bg = bmcolor, attr = 'NONE' })

-- 2. Explicitly define all common SYNTAX groups to be mcolor and NOT bold
--hi('Comment', { fg = bmcomment, attr = 'underdotted' })
hi('Comment', { fg = mcolor })
hi('Constant', { fg = mcolor, attr = 'NONE' })
hi('Statement', { fg = mcolor, attr = 'NONE' })
hi('Identifier', { fg = mcolor, attr = 'NONE' })
hi('Function', { fg = mcolor, attr = 'NONE' })
hi('Type', { fg = mcolor, attr = 'NONE' })
hi('PreProc', { fg = mcolor, attr = 'NONE' })
hi('Special', { fg = mcolor, attr = 'NONE' })
hi('String', { fg = mcolor, attr = 'NONE' })
hi('Number', { fg = mcolor, attr = 'NONE' })
hi('ModeMsg', { fg = mcolor, bg = bmcolor, attr = 'NONE' })
hi('NormalFloat', { fg = bmcolor, bg = mcolor, attr = 'NONE' })
hi('FloatBorder', { fg = bmcolor, bg = mcolor, attr = 'NONE' })

-- 3. Link the remaining UI groups to 'Normal'
link('NonText', 'Normal')
link('LineNr', 'Normal')
hi('StatusLine', { fg = mcolor, bg = bmcolor, attr = 'NONE' })
hi('StatusLineNC', { fg = mcolor, bg = bmcolor, attr = 'NONE' })
link('VertSplit', 'Normal')
link('Pmenu', 'Normal')
link('TabLine', 'Normal')
link('TabLineFill', 'Normal')
link('VisualNOS', 'Visual')
