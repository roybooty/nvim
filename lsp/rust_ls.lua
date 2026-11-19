---@brief
---
--- https://rust-analyzer.github.io/
---
--- - **NOTE:** Make sure `rust-analyzer` is installed in your system PATH or managed via Mason/LSP installers.
--- - rust-analyzer relies on Cargo workspaces and looks for `Cargo.toml`.

local function run_cargo_command(bufnr, client, command)
  local method_name = 'experimental/runnables'
  ---@diagnostic disable-next-line:param-type-mismatch
  if not client or not client:supports_method(method_name) then
    return vim.notify(
      ('method %s is not supported by any servers active on the current buffer'):format(method_name)
    )
  end
  -- Additional custom buffer commands or workspace management can go here
end

---@class RustAnalyzerInitializeResult: lsp.InitializeResult
---@field offsetEncoding? string

---@type vim.lsp.Config
return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = {
    'Cargo.toml',
    'rust-project.json',
    '.git',
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { 'utf-8', 'utf-16' },
  },
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = true,
      procMacro = {
        enable = true,
      },
    },
  },
  ---@param init_result RustAnalyzerInitializeResult
  on_init = function(client, init_result)
    if init_result.offsetEncoding then
      client.offset_encoding = init_result.offsetEncoding
    end
  end,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspRustExpandMacro', function()
      -- Example custom command hook
      local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
      client:request('rust-analyzer/expandMacro', params, function(err, result)
        if err then
          error(tostring(err))
        end
        if result then
          print(result.expansion)
        end
      end, bufnr)
    end, { desc = 'Expand macro recursively' })
  end,
}
