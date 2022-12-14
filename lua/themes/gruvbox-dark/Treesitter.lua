local Treesitter = {
  TSComment = { fg = C.gray },
  TSAnnotation = { fg = C.purple },
  TSAttribute = { fg = C.cyan },
  TSConstructor = { fg = C.purple },
  TSType = { fg = C.purple },
  TSTypeBuiltin = { fg = C.purple },
  TSConditional = { fg = C.aqua_light },
  TSException = { fg = C.aqua_light },
  TSInclude = { fg = C.aqua_light },
  TSKeyword = { fg = C.red_light }, -- const/var/let
  TSKeywordFunction = { fg = C.aqua_light },
  TSLabel = { fg = C.aqua_light },
  TSNamespace = { fg = C.aqua_light },
  TSRepeat = { fg = C.aqua_light },
  TSConstant = { fg = C.orange },
  TSConstBuiltin = { fg = C.orange },
  TSFloat = { fg = C.red },
  TSNumber = { fg = C.red },
  TSBoolean = { fg = C.red },
  TSCharacter = { fg = C.light_green },
  TSError = { fg = C.error_red },
  TSFunction = { fg = C.yellow },
  TSFuncBuiltin = { fg = C.yellow },
  TSMethod = { fg = C.yellow },
  TSConstMacro = { fg = C.cyan },
  TSFuncMacro = { fg = C.cyan },
  TSVariable = { fg = C.cyan },
  TSVariableBuiltin = { fg = C.cyan },
  TSProperty = { fg = C.blue },
  TSOperator = { fg = C.gray_blue },
  TSField = { fg = C.white },
  TSParameter = { fg = C.white },
  TSParameterReference = { fg = C.white },
  TSSymbol = { fg = C.white },
  TSText = { fg = C.fg },
  TSPunctDelimiter = { fg = C.gray },
  TSTagDelimiter = { fg = C.gray },
  TSPunctBracket = { fg = C.gray },
  TSPunctSpecial = { fg = C.gray },
  TSString = { fg = C.green },
  TSStringRegex = { fg = C.light_green },
  TSStringEscape = { fg = C.light_green },
  TSTag = { fg = C.aqua_light },
  TSEmphasis = { style = "italic" },
  TSUnderline = { style = "underline" },
  TSTitle = { fg = C.aqua_light, style = "bold" },
  TSLiteral = { fg = C.green },
  TSURI = { fg = C.cyan, style = "underline" },
  TSKeywordOperator = { fg = C.aqua_light },
  TSStructure = { fg = C.purple_test },
  TSStrong = { fg = C.yellow },
  TSQueryLinterError = { fg = C.warning_orange },

  -- My Update
  typescriptVariableDeclaration = { fg = C.red_light },
  typescriptBlock = { fg = C.blue },
  tsxEscJs = { fg = C.red_light }, -- variable
  -- typescriptFuncName = { fg = C.blue },
  typescriptIdentifierName = { fg = C.red_light },
}

return Treesitter
