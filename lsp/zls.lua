---@brief
---
--- https://github.com
---
--- ZLS provides language server support for Zig. 
--- Compatibility: ZLS version must match your `zig version`.

local function show_zig_version(bufnr, client)
  local handle = io.popen("zig version")
  if not handle then return end
  local result = handle:read("*a")
  handle:close()
  vim.notify("Zig Version: " .. result, vim.log.levels.INFO, { title = "ZLS Info" })
end

---@type vim.lsp.Config
return {
  cmd = { '/home/nash/dev/zls/zig-out/bin/zls' },
  filetypes = { 'zig', 'zir' },
  root_markers = {
    'build.zig',
    'zls.json',
    '.git',
  },
  single_file_support = true,
  settings = {
    zls = {
      enable_autofix = true,
      enable_snippets = true,
      warn_style = true, -- Highlights non-canonical Zig style
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspZigVersion', function()
      show_zig_version(bufnr, client)
    end, { desc = 'Show Zig compiler version' })
    
    -- Zig's compiler is the formatter
    vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
  end,
}

