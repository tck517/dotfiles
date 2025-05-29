# Dotfiles Configuration Guide

## Commands
- **VIM Plugin Install**: `nvim +PlugInstall +qall`
- **Lint Neovim Config**: `vint init.vim`
- **Test Single Test**: `nvim -c "TestNearest"`
- **Update Dotfiles**: `git add . && git commit -m "update dotfiles"`

## Style Guidelines
- **Indentation**: 2 spaces (no tabs)
- **Line Length**: Avoid exceeding 80 characters when possible
- **VIM Mappings**: Use `<leader>` prefix for custom mappings (leader is `_`)
- **Snippets Format**: Follow existing snippet structure with alias, abbr, and options
- **Plugin Declarations**: Group plugins by functionality with descriptive comments
- **Function Names**: Use snake_case for VIM functions
- **Error Handling**: Use conditional statements for graceful failure
- **Comments**: Add comments for non-obvious configuration sections
- **Code Organization**: Group related settings together
- **Lua Configuration**: Use lua blocks for plugins that support it

## Shortcuts
- **Tests**: `t<C-n>` (TestNearest), `t<C-f>` (TestFile), `t<C-s>` (TestSuite)
- **FZF**: `<C-p>` (Files), `<C-b>` (Buffers), `<leader>g` (Grep word under cursor)
- **Explorer**: `<C-t>` (Toggle NvimTree)