-- matugen template: nixvim-colors.lua
-- Minimal but complete - covers essentials only

vim.cmd("highlight clear")
if vim.g.syntax_on then
	vim.cmd("syntax reset")
end

vim.g.colors_name = "matugen"

local c = {
	-- Surfaces
	bg = "{{colors.surface.default.hex}}",
	bg_dark = "{{colors.surface_container.default.hex}}",
	bg_darker = "{{colors.surface_container_low.default.hex}}",
	surface = "{{colors.surface_container_high.default.hex}}",
	surface_bright = "{{colors.surface_bright.default.hex}}",

	-- Text
	fg = "{{colors.on_surface.default.hex}}",
	fg_muted = "{{colors.on_surface_variant.default.hex}}",

	-- Accents
	primary = "{{colors.primary.default.hex}}",
	primary_bg = "{{colors.primary_container.default.hex}}",
	on_primary = "{{colors.on_primary.default.hex}}",

	secondary = "{{colors.secondary.default.hex}}",
	secondary_bg = "{{colors.secondary_container.default.hex}}",

	tertiary = "{{colors.tertiary.default.hex}}",
	tertiary_bg = "{{colors.tertiary_container.default.hex}}",

	-- Utility
	border = "{{colors.outline.default.hex}}",
	border_subtle = "{{colors.outline_variant.default.hex}}",

	-- Semantic
	error = "{{colors.error.default.hex}}",
	error_bg = "{{colors.error_container.default.hex}}",
	warning = "{{colors.tertiary.default.hex}}",
	success = "{{colors.secondary.default.hex}}",
}

-- ============================================
-- EDITOR UI
-- ============================================

vim.api.nvim_set_hl(0, "Normal", { bg = c.bg, fg = c.fg })
vim.api.nvim_set_hl(0, "NormalNC", { bg = c.bg_dark, fg = c.fg })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = c.bg_dark, fg = c.fg })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = c.bg_dark, fg = c.border })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = c.bg_dark, fg = c.primary, bold = true })

vim.api.nvim_set_hl(0, "CursorLine", { bg = c.bg_dark })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = c.bg_dark, fg = c.primary, bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = c.fg_muted })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = c.bg_darker })
vim.api.nvim_set_hl(0, "SignColumn", { bg = c.bg })

vim.api.nvim_set_hl(0, "Visual", { bg = c.secondary_bg })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = c.secondary_bg })

vim.api.nvim_set_hl(0, "Search", { bg = c.primary_bg, fg = c.fg })
vim.api.nvim_set_hl(0, "CurSearch", { bg = c.primary, fg = c.on_primary, bold = true })
vim.api.nvim_set_hl(0, "IncSearch", { bg = c.primary, fg = c.on_primary, bold = true })

vim.api.nvim_set_hl(0, "StatusLine", { bg = c.surface, fg = c.fg })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = c.bg_dark, fg = c.fg_muted })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = c.border })
vim.api.nvim_set_hl(0, "WinBar", { bg = c.bg, fg = c.fg })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = c.bg_dark, fg = c.fg_muted })

vim.api.nvim_set_hl(0, "Pmenu", { bg = c.bg_dark, fg = c.fg })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = c.primary_bg, fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = c.bg_darker })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = c.fg_muted })

vim.api.nvim_set_hl(0, "Folded", { bg = c.bg_dark, fg = c.fg_muted })
vim.api.nvim_set_hl(0, "FoldColumn", { fg = c.fg_muted })

vim.api.nvim_set_hl(0, "TabLine", { bg = c.bg_dark, fg = c.fg_muted })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = c.bg_dark })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = c.surface, fg = c.primary, bold = true })

vim.api.nvim_set_hl(0, "ErrorMsg", { fg = c.error, bold = true })
vim.api.nvim_set_hl(0, "WarningMsg", { fg = c.warning, bold = true })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = c.primary, bold = true })
vim.api.nvim_set_hl(0, "Question", { fg = c.primary, bold = true })

vim.api.nvim_set_hl(0, "DiffAdd", { bg = c.secondary_bg, fg = c.success })
vim.api.nvim_set_hl(0, "DiffChange", { bg = c.tertiary_bg, fg = c.warning })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.error_bg, fg = c.error })
vim.api.nvim_set_hl(0, "DiffText", { bg = c.primary_bg, fg = c.primary, bold = true })

vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = c.error })
vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = c.warning })
vim.api.nvim_set_hl(0, "SpellRare", { undercurl = true, sp = c.primary })
vim.api.nvim_set_hl(0, "SpellLocal", { undercurl = true, sp = c.secondary })

-- ============================================
-- SYNTAX (Treesitter + Classic)
-- ============================================

vim.api.nvim_set_hl(0, "Comment", { fg = c.fg_muted, italic = true })

-- Constants: strings, numbers, bools -> tertiary (warm, distinct)
vim.api.nvim_set_hl(0, "Constant", { fg = c.tertiary })
vim.api.nvim_set_hl(0, "String", { fg = c.tertiary })
vim.api.nvim_set_hl(0, "Character", { fg = c.tertiary })
vim.api.nvim_set_hl(0, "Number", { fg = c.tertiary })
vim.api.nvim_set_hl(0, "Boolean", { fg = c.tertiary, bold = true })
vim.api.nvim_set_hl(0, "Float", { fg = c.tertiary })

-- Variables -> neutral
vim.api.nvim_set_hl(0, "Identifier", { fg = c.fg })
vim.api.nvim_set_hl(0, "Function", { fg = c.primary })

-- Keywords: control flow -> secondary (often green-ish, stands out)
vim.api.nvim_set_hl(0, "Statement", { fg = c.secondary })
vim.api.nvim_set_hl(0, "Conditional", { fg = c.secondary })
vim.api.nvim_set_hl(0, "Repeat", { fg = c.secondary })
vim.api.nvim_set_hl(0, "Label", { fg = c.secondary })
vim.api.nvim_set_hl(0, "Operator", { fg = c.fg })
vim.api.nvim_set_hl(0, "Keyword", { fg = c.secondary, bold = true })
vim.api.nvim_set_hl(0, "Exception", { fg = c.error, bold = true })

-- Preprocessor: imports, macros -> primary
vim.api.nvim_set_hl(0, "PreProc", { fg = c.primary })
vim.api.nvim_set_hl(0, "Include", { fg = c.primary })
vim.api.nvim_set_hl(0, "Define", { fg = c.primary })
vim.api.nvim_set_hl(0, "Macro", { fg = c.primary })
vim.api.nvim_set_hl(0, "PreCondit", { fg = c.primary })

-- Types: structs, classes -> secondary (same family as keywords)
vim.api.nvim_set_hl(0, "Type", { fg = c.secondary })
vim.api.nvim_set_hl(0, "StorageClass", { fg = c.secondary })
vim.api.nvim_set_hl(0, "Structure", { fg = c.secondary })
vim.api.nvim_set_hl(0, "Typedef", { fg = c.secondary })

-- Special: escapes, tags -> primary
vim.api.nvim_set_hl(0, "Special", { fg = c.primary })
vim.api.nvim_set_hl(0, "SpecialChar", { fg = c.tertiary })
vim.api.nvim_set_hl(0, "Tag", { fg = c.primary })
vim.api.nvim_set_hl(0, "Delimiter", { fg = c.fg_muted })
vim.api.nvim_set_hl(0, "SpecialComment", { fg = c.fg_muted, bold = true })
vim.api.nvim_set_hl(0, "Debug", { fg = c.error })

vim.api.nvim_set_hl(0, "Underlined", { underline = true })
vim.api.nvim_set_hl(0, "Ignore", { fg = c.fg_muted })
vim.api.nvim_set_hl(0, "Error", { fg = c.error, bold = true })
vim.api.nvim_set_hl(0, "Todo", { bg = c.primary_bg, fg = c.primary, bold = true })

-- Treesitter mappings
vim.api.nvim_set_hl(0, "@variable", { fg = c.fg })
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = c.error, italic = true })
vim.api.nvim_set_hl(0, "@variable.parameter", { fg = c.fg })
vim.api.nvim_set_hl(0, "@variable.member", { fg = c.fg })

vim.api.nvim_set_hl(0, "@constant", { fg = c.tertiary })
vim.api.nvim_set_hl(0, "@constant.builtin", { fg = c.tertiary, bold = true })
vim.api.nvim_set_hl(0, "@constant.macro", { fg = c.primary })

vim.api.nvim_set_hl(0, "@module", { fg = c.secondary })
vim.api.nvim_set_hl(0, "@module.builtin", { fg = c.secondary, bold = true })

vim.api.nvim_set_hl(0, "@string", { fg = c.tertiary })
vim.api.nvim_set_hl(0, "@string.documentation", { fg = c.fg_muted })
vim.api.nvim_set_hl(0, "@string.regexp", { fg = c.warning })
vim.api.nvim_set_hl(0, "@string.escape", { fg = c.primary })

vim.api.nvim_set_hl(0, "@boolean", { fg = c.tertiary, bold = true })
vim.api.nvim_set_hl(0, "@number", { fg = c.tertiary })
vim.api.nvim_set_hl(0, "@number.float", { fg = c.tertiary })

vim.api.nvim_set_hl(0, "@type", { fg = c.secondary })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = c.secondary, italic = true })
vim.api.nvim_set_hl(0, "@type.definition", { fg = c.secondary })

vim.api.nvim_set_hl(0, "@attribute", { fg = c.primary })
vim.api.nvim_set_hl(0, "@property", { fg = c.fg })

vim.api.nvim_set_hl(0, "@function", { fg = c.primary })
vim.api.nvim_set_hl(0, "@function.builtin", { fg = c.primary, italic = true })
vim.api.nvim_set_hl(0, "@function.call", { fg = c.primary })
vim.api.nvim_set_hl(0, "@function.macro", { fg = c.primary })
vim.api.nvim_set_hl(0, "@function.method", { fg = c.primary })
vim.api.nvim_set_hl(0, "@function.method.call", { fg = c.primary })

vim.api.nvim_set_hl(0, "@constructor", { fg = c.secondary })
vim.api.nvim_set_hl(0, "@operator", { fg = c.fg })

vim.api.nvim_set_hl(0, "@keyword", { fg = c.secondary, bold = true })
vim.api.nvim_set_hl(0, "@keyword.function", { fg = c.secondary, bold = true })
vim.api.nvim_set_hl(0, "@keyword.operator", { fg = c.secondary, bold = true })
vim.api.nvim_set_hl(0, "@keyword.import", { fg = c.primary })
vim.api.nvim_set_hl(0, "@keyword.type", { fg = c.secondary, bold = true })
vim.api.nvim_set_hl(0, "@keyword.return", { fg = c.secondary, bold = true })
vim.api.nvim_set_hl(0, "@keyword.exception", { fg = c.error, bold = true })

vim.api.nvim_set_hl(0, "@conditional", { fg = c.secondary })
vim.api.nvim_set_hl(0, "@repeat", { fg = c.secondary })

vim.api.nvim_set_hl(0, "@include", { fg = c.primary })
vim.api.nvim_set_hl(0, "@exception", { fg = c.error, bold = true })

vim.api.nvim_set_hl(0, "@comment", { fg = c.fg_muted, italic = true })
vim.api.nvim_set_hl(0, "@comment.documentation", { fg = c.fg_muted, italic = true })

vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = c.fg_muted })
vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = c.fg_muted })
vim.api.nvim_set_hl(0, "@punctuation.special", { fg = c.primary })

-- ============================================
-- LSP / DIAGNOSTICS
-- ============================================

vim.api.nvim_set_hl(0, "DiagnosticError", { fg = c.error })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = c.warning })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = c.primary })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = c.secondary })
vim.api.nvim_set_hl(0, "DiagnosticOk", { fg = c.success })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = c.error })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = c.warning })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = c.primary })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = c.secondary })

vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = c.error, bg = c.bg })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = c.warning, bg = c.bg })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = c.primary, bg = c.bg })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = c.secondary, bg = c.bg })

-- LSP semantic tokens
vim.api.nvim_set_hl(0, "@lsp.type.class", { fg = c.secondary })
vim.api.nvim_set_hl(0, "@lsp.type.comment", { fg = c.fg_muted, italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.decorator", { fg = c.primary })
vim.api.nvim_set_hl(0, "@lsp.type.enum", { fg = c.secondary })
vim.api.nvim_set_hl(0, "@lsp.type.enumMember", { fg = c.tertiary })
vim.api.nvim_set_hl(0, "@lsp.type.function", { fg = c.primary })
vim.api.nvim_set_hl(0, "@lsp.type.interface", { fg = c.secondary })
vim.api.nvim_set_hl(0, "@lsp.type.macro", { fg = c.primary })
vim.api.nvim_set_hl(0, "@lsp.type.method", { fg = c.primary })
vim.api.nvim_set_hl(0, "@lsp.type.namespace", { fg = c.secondary })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = c.fg })
vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = c.fg })
vim.api.nvim_set_hl(0, "@lsp.type.struct", { fg = c.secondary })
vim.api.nvim_set_hl(0, "@lsp.type.type", { fg = c.secondary })
vim.api.nvim_set_hl(0, "@lsp.type.typeParameter", { fg = c.secondary })
vim.api.nvim_set_hl(0, "@lsp.type.variable", { fg = c.fg })

-- ============================================
-- POPULAR PLUGINS (minimal)
-- ============================================

-- Telescope
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = c.bg_dark, fg = c.fg })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = c.bg_dark, fg = c.border })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = c.bg_darker, fg = c.fg })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = c.bg_darker, fg = c.border })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = c.primary, fg = c.on_primary, bold = true })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = c.secondary, fg = c.bg, bold = true })
vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = c.primary_bg, fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = c.primary, bold = true })

-- GitSigns
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = c.success, bg = c.bg })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = c.warning, bg = c.bg })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = c.error, bg = c.bg })

-- Cmp
vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = c.fg })
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = c.fg_muted, strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = c.primary, bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = c.primary, bold = true })
vim.api.nvim_set_hl(0, "CmpItemKind", { fg = c.secondary })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = c.fg_muted })

-- Lazy
vim.api.nvim_set_hl(0, "LazyNormal", { bg = c.bg_dark, fg = c.fg })
vim.api.nvim_set_hl(0, "LazyH1", { bg = c.primary, fg = c.on_primary, bold = true })
vim.api.nvim_set_hl(0, "LazyButton", { bg = c.surface, fg = c.fg })
vim.api.nvim_set_hl(0, "LazyButtonActive", { bg = c.primary_bg, fg = c.primary, bold = true })

-- WhichKey
vim.api.nvim_set_hl(0, "WhichKey", { fg = c.primary, bold = true })
vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = c.secondary })
vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = c.fg_muted })
vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = c.fg })
vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = c.bg_dark })

-- IndentBlankline
vim.api.nvim_set_hl(0, "IblIndent", { fg = c.bg_darker })
vim.api.nvim_set_hl(0, "IblScope", { fg = c.primary })

-- Terminal colors
vim.g.terminal_color_0 = c.bg_dark
vim.g.terminal_color_1 = c.error
vim.g.terminal_color_2 = c.success
vim.g.terminal_color_3 = c.warning
vim.g.terminal_color_4 = c.primary
vim.g.terminal_color_5 = c.secondary
vim.g.terminal_color_6 = c.tertiary
vim.g.terminal_color_7 = c.fg
vim.g.terminal_color_8 = c.fg_muted
vim.g.terminal_color_9 = c.error
vim.g.terminal_color_10 = c.success
vim.g.terminal_color_11 = c.warning
vim.g.terminal_color_12 = c.primary
vim.g.terminal_color_13 = c.secondary
vim.g.terminal_color_14 = c.tertiary
vim.g.terminal_color_15 = c.fg
