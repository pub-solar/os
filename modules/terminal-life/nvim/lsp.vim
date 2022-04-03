" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure neovim 5 experimental LSPs
" https://github.com/neovim/nvim-lspconfig
" https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
" https://gitlab.com/Iron_E/dotfiles/-/blob/master/.config/nvim/lua/_config/plugin/nvim_lsp.lua
lua <<EOF
  local nvim_lsp    = require('lspconfig')

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  end

  -- Add additional capabilities supported by nvim-cmp
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
            ['cmd'] = {"json-languageserver", "--stdio"}
        },
        'phpactor', ----------------------------- PHP
        'pylsp', --------------------------------- Python
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
        'angularls', ---------------------------- Angular
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
      local on_attach_setting = lsp_settings.on_attach

    lsp_settings.on_attach = function()
      if on_attach_setting then on_attach_setting() end
    end

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
EOF

" Visualize diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_trimmed_virtual_text = '40'
" Don't show diagnostics while in insert mode
let g:diagnostic_insert_delay = 1

" Show diagnostic popup on cursor hold
autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })

" Goto previous/next diagnostic warning/error
" nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<cr>
" nnoremap <silent> g] <cmd>NextDiagnosticCycle<cr>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes
