local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

-- vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#f5a97f", bg = "#24273a" })
-- vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#cad3f5", bg = "#24273a", bold = false })
-- -- vim.api.nvim_set_hl(0, "SLProgress", { fg = "#D7BA7D", bg = "#252525" })
-- vim.api.nvim_set_hl(0, "SLProgress", { fg = "#8087a2", bg = "#24273a" })
-- vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#8087a2", bg = "#24273a" })
-- vim.api.nvim_set_hl(0, "SLLSP", { fg = "#8aadf4", bg = "#24273a" })
-- darkerplus
-- vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#303030" })
-- vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#abb2bf", bg = "#303030", bold = false })
-- -- vim.api.nvim_set_hl(0, "SLProgress", { fg = "#D7BA7D", bg = "#252525" })
-- vim.api.nvim_set_hl(0, "SLProgress", { fg = "#abb2bf", bg = "#303030" })
-- vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#545862", bg = "#252525" })
-- local mode_color = {
--   n = "#8aadf4",
--   i = "#a6da95",
--   v = "#c6a0f6",
--   [""] = "#ee99a0",
--   V = "#ed8796",
--   -- c = '#B5CEA8',
--   -- c = '#D7BA7D',
--   c = "#f5a97f",
--   no = "#8aadf4",
--   s = "#f5a97f",
--   S = "#f5a97f",
--   [""] = "#f5a97f",
--   ic = "#ed8796",
--   R = "#f5a97f",
--   Rv = "#ed8796",
--   cv = "#8aadf4",
--   ce = "#8aadf4",
--   r = "#ed8796",
--   rm = "#f5bde6",
--   ["r?"] = "#f5bde6",
--   ["!"] = "#f5bde6",
--   t = "#a6da95",
-- }

local mode = {
  -- mode component
  function()
    -- return "▊"
    return "  "
    -- return "  "
  end,
  -- color = function()
  --   -- auto change color according to neovims mode
  --   return { bg = mode_color[vim.fn.mode()] }
  -- end,
  -- padding = { right = 1 },
  padding = 0,
}

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
  separator = "%#SLSeparator#" .. "│ " .. "%*",
}

-- local mode = {
--   "mode",
--   fmt = function(str)
--     return "-- " .. str .. " --"
--   end,
-- }

local filetype = {
  "filetype",
  icons_enabled = true,
  -- icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. "" .. "%*" .. "%#SLBranchName#",
  -- color = "Constant",
  colored = false,
}

local progress = {
  "progress",
  -- color = "SLProgress",
  -- fmt = function(str)
  --   print(vim.fn.expand(str))
  --   if str == "1%" then
  --     return "TOP"
  --   end
  --   if str == "100%" then
  --     return "BOT"
  --   end
  --   return str
  -- end,
  -- padding = 0,
}

-- local progress = {
--   "progress",
--   fmt = function(str)
--     print(vim.fn.expand(str))
--     if str == "1%" then
--       return "TOP"
--     end
--     if str == "100%" then
--       return "BOT"
--     end
--     return str
--   end,
--   -- padding = 0,
-- }

local current_signature = function()
  if not pcall(require, "lsp_signature") then
    return
  end
  local sig = require("lsp_signature").status_line(30)
  -- return sig.label .. "🐼" .. sig.hint
  return "%#SLSeparator#" .. sig.hint .. "%*"
end

-- cool function for progress
-- local progress = function()
--   local current_line = vim.fn.line "."
--   local total_lines = vim.fn.line "$"
--   local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
--   local line_ratio = current_line / total_lines
--   local index = math.ceil(line_ratio * #chars)
--   -- return chars[index]
--   return "%#SLProgress#" .. chars[index] .. "%*"
-- end

local spaces = {
  function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end,
  padding = 0,
  separator = "%#SLSeparator#" .. " │" .. "%*",
}

local lanuage_server = {
  function()
    local clients = vim.lsp.buf_get_clients()
    local client_names = {}

    -- add client
    for _, client in pairs(clients) do
      if client.name ~= "copilot" and client.name ~= "null-ls" then
        table.insert(client_names, client.name)
      end
    end

    local buf_ft = vim.bo.filetype

    -- add formatter
    local s = require "null-ls.sources"
    local available_sources = s.get_available(buf_ft)
    local registered = {}
    for _, source in ipairs(available_sources) do
      for method in pairs(source.methods) do
        registered[method] = registered[method] or {}
        table.insert(registered[method], source.name)
      end
    end

    local formatter = registered["NULL_LS_FORMATTING"]
    local linter = registered["NULL_LS_DIAGNOSTICS"]
    if formatter ~= nil then
      vim.list_extend(client_names, formatter)
    end
    if linter ~= nil then
      vim.list_extend(client_names, linter)
    end

    -- join client names with commas
    local client_names_str = table.concat(client_names, ", ")
    -- 
    return "%#SLLSP#" .. "[" .. client_names_str .. "]" .. "%*"
  end,
  padding = 0,
  cond = hide_in_width,
  separator = "%#SLSeparator#" .. " │ " .. "%*",
}

-- local location = {
--   "location",
--   color = function()
--     -- darkerplus
--     -- return { fg = "#252525", bg = mode_color[vim.fn.mode()] }
--     return { fg = "#1E232A", bg = mode_color[vim.fn.mode()] }
--   end,
-- }

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    -- theme = "auto",
    theme = theme,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode, branch },
    lualine_b = { diagnostics },
    -- lualine_c = {},
    lualine_c = { { current_signature, cond = hide_in_width } },
    -- lualine_x = { diff, spaces, "encoding", filetype },
    lualine_x = { diff, lanuage_server, spaces, filetype },
    lualine_y = { progress },
    -- lualine_z = { location },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
