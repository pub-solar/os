" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

function AddTemplate(tmpl_file)
    exe "0read " . a:tmpl_file
    set nomodified
    6
endfunction

autocmd BufNewFile shell.nix call AddTemplate("$XDG_DATA_HOME/nvim/templates/shell.nix.tmpl")

" Configure neovim 0.6+ experimental LSPs
" https://github.com/neovim/nvim-lspconfig
" https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
" https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
" https://gitlab.com/Iron_E/dotfiles/-/blob/master/.config/nvim/lua/_config/plugin/nvim_lsp.lua
lua <<EOF
  local nvim_lsp    = require('lspconfig')

  -- Mappings (global)
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>dq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings (available if LSP is configured and attached to buffer)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    -- Show diagnostic popup on cursor hold
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end
    })

  end

  -- Add additional capabilities supported by nvim-cmp
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  -- vscode HTML lsp needs this https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  for lsp_key, lsp_settings in pairs({
        'bashls', ------------------------------- Bash
        'ccls', --------------------------------- C / C++ / Objective-C
        'cssls', -------------------------------- CSS / SCSS / LESS
        'dockerls', ----------------------------- Docker
        ['gopls'] = { --------------------------- Go
            ['settings'] = {
                ['gopls'] = {
                    ['analyses'] = {
                        ['unusedparams'] = true,
                    },
                    ['staticcheck'] = true
                },
            },
        },
        'html', --------------------------------- HTML
        ['jdtls'] = { --------------------------- Java
            ['root_dir'] = nvim_lsp.util.root_pattern('.git', 'pom.xml', 'build.xml'),
            ['init_options'] = {
                ['jvm_args'] = {['java.format.settings.url'] = vim.fn.stdpath('config')..'/eclipse-formatter.xml'},
                ['workspace'] = vim.fn.stdpath('cache')..'/java-workspaces'
            }
        },
        ['jsonls'] = { -------------------------- JSON
            ['settings'] = {
                ['json'] = {
                    ['schemas' ] = require('schemastore').json.schemas()
                }
            }
        },
        'phpactor', ----------------------------- PHP
        'pylsp', -------------------------------- Python
        'rnix', --------------------------------- Nix
        'solargraph', --------------------------- Ruby
        'rust_analyzer', ------------------------ Rust
        ['sqlls'] = {
            ['cmd'] = {"$XDG_DATA_HOME/nvm/versions/node/v12.19.0/bin/sql-language-server", "up", "--method", "stdio"}
        },
        ['terraformls'] = { --------------------- Terraform
            ['filetypes'] = { "terraform", "hcl", "tf" }
        },
        'tsserver', ----------------------------- Typescript / JavaScript
        'vuels', -------------------------------- Vue
        'svelte', ------------------------------- Svelte
        ['yamlls'] = { -------------------------- YAML
            ['settings'] = {
                ['yaml'] = {
                    ['schemas'] = {
                        ['https://json.schemastore.org/github-workflow'] = '.github/workflows/*.{yml,yaml}',
                        ['https://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
                        ['https://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
                        ['https://json.schemastore.org/drone'] = '*.drone.{yml,yaml}',
                        ['https://json.schemastore.org/swagger-2.0'] = 'swagger.{yml,yaml}',
                    }
                }
            }
        }
  }) do -- Setup all of the language servers. †
    if type(lsp_key) == 'number' then -- Enable the LSP with defaults.
      -- The `lsp` is an index in this case.
      nvim_lsp[lsp_settings].setup{
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
        capabilities = capabilities,
      }
    else -- Use the LSP's configuration.
      lsp_settings.on_attach = on_attach
      lsp_settings.capabilities = capabilities

      nvim_lsp[lsp_key].setup(lsp_settings)
    end
  end -- ‡

  -- Set completeopt to have a better completion experience
  vim.o.completeopt = 'menuone,noselect'

  -- luasnip setup
  local luasnip = require 'luasnip'

  -- nvim-cmp setup
  local cmp = require 'cmp'
  cmp.setup {
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    },
  }

-- Configure diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- Change diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
EOF

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes:2
