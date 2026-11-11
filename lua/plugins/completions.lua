return {
  "saghen/blink.cmp",
  enabled = true,
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
  },
  -- use a release tag to download pre-built binaries
  version = "*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type function|blink.cmp.Config
  opts = function(_, opts)
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load({
      include = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    })

    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/snippets" },
    })
    opts.fuzzy = {
      implementation = 'prefer_rust_with_warning',
    }
    opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        lsp = {
          name = "LSP",
          enabled = true,
          module = "blink.cmp.sources.lsp",
          fallbacks = { "snippets", "luasnip", "buffer" },
          score_offset = 90, -- the higher the number, the higher the priority
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 25,
          fallbacks = { "snippets", "buffer" },
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end,
            show_hidden_files_by_default = true,
          },
        },
        buffer = {
          name = "Buffer",
          enabled = true,
          max_items = 3,
          module = "blink.cmp.sources.buffer",
          min_keyword_length = 4,
          score_offset = 15, -- the higher the number, the higher the priority
        },
        snippets = {
          name = "Snippets",
          enabled = true,
          module = "blink.cmp.sources.snippets",
          score_offset = 95, -- the higher the number, the higher the priority
        },
      },
    })
    opts.cmdline = {
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        if type == ":" then
          return { "cmdline" }
        end
        return {}
      end,
    }
    opts.completion = {
      list = {
        selection = {
          preselect = true, auto_insert = true
        },
        -- max_items = 10,
      },
      accept = {
        auto_brackets = {
          enabled = true,
          default_brackets = { "(", ")" },
          kind_resolution = {
            enabled = true,
            blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
          },
        },
      },
      menu = {
        draw = {
          -- We don't need label_description now because label and label_description are already
          -- combined together in label by colorful-menu.nvim.
          columns = { { "kind_icon" }, { "label", gap = 4 }, { gap = 1, "source_id" }, { "kind" } },
          components = {
            kind_icon = {
              text = function(item)
                local kind = require("lspkind").symbol_map[item.kind] or ""
                return kind .. " "
              end,
              highlight = "CmpItemKind",
            },
            label = {
              text = function(item)
                return item.label
              end,
              highlight = "CmpItemAbbr",
            },
            kind = {
              text = function(item)
                return item.kind
              end,
              highlight = "CmpItemKind",
            },
            source_id = {
              text = function(ctx)
                if ctx.source_id == "lsp" and ctx.item and ctx.item.client_name and ctx.item.client_name ~= "" then
                  return ctx.item.client_name
                end
                return ctx.source_id
              end,
              highlight = "CmpItemMenu",
            },
          },
        },
        border = "rounded",
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        treesitter_highlighting = true,
        window = { border = "rounded" },
      },
      -- Displays a preview of the selected item on the current line
      ghost_text = {
        enabled = false,
      },
    }
    opts.snippets = {
      preset = "luasnip",
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
    }
    opts.keymap = {
      preset = "super-tab",
    }
    opts.signature = {
      enabled = true,
      window = {
        border = "single",
      },
    }
    opts.appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'normal'
    }
    return opts
  end,
}
