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
  -- Attach `completion-nvim` to the buffer.
  local function lsp_setup()
    require('completion').on_attach()
  end

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
        'jsonls', ------------------------------- JSON
        'phpactor', ----------------------------- PHP
        'pyls', --------------------------------- Python
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
      nvim_lsp[lsp_settings].setup{['on_attach'] = lsp_setup}
    else -- Use the LSP's configuration.
      local on_attach_setting = lsp_settings.on_attach

    lsp_settings.on_attach = function()
      lsp_setup()
      if on_attach_setting then on_attach_setting() end
    end

      nvim_lsp[lsp_key].setup(lsp_settings)
    end
  end -- ‡
EOF

" Visualize diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_trimmed_virtual_text = '40'
" Don't show diagnostics while in insert mode
let g:diagnostic_insert_delay = 1

" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
" nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<cr>
" nnoremap <silent> g] <cmd>NextDiagnosticCycle<cr>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" NeoVim 0.5 Code navigation shortcuts
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <c-]>    <cmd>lua vim.lsp.buf.declaration()<CR>
