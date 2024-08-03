return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  init = function() vim.g.neo_tree_remove_legacy_commands = true end,
  opts = function()
    local global_commands = {
      system_open = function(state) require("core.utils").system_open(state.tree:get_node():get_id()) end,
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if (node.type == "directory" or node:has_children()) and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      child_or_open = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" or node:has_children() then
          if not node:is_expanded() then -- if unexpanded, expand
            state.commands.toggle_node(state)
          else                           -- if expanded and has children, seleect the next child
            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          end
        else -- if not a directory just open it
          state.commands.open(state)
        end
      end,
    }
    return {
      close_if_last_window = true,
      source_selector = {
        winbar = true,
        content_layout = "center",
      },
      default_component_configs = {
        indent = { padding = 0 },
      },
      window = {
        position = "left",
        width = 35,
        mappings = {
          ["<space>"] = false,
          ["[b"] = "prev_source",
          ["]b"] = "next_source",
          o = "open",
          O = "system_open",
          h = "parent_or_close",
          l = "child_or_open",
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        commands = global_commands,
      },
      buffers = { commands = global_commands },
      git_status = { commands = global_commands },
      event_handlers = {
        { event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
      },
    }
  end,
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
}
