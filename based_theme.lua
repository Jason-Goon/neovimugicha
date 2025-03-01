local lush = require("lush")
local hsl = lush.hsl

local based_theme = lush(function()
  return {
    Normal       { fg = hsl("#f7cdd4"), bg = hsl("#151517") },
    CursorLine   { bg = hsl("#151517") },
    Visual       { bg = hsl("#53c0cd") },
    Cursor       { fg = hsl("#61f2c7"), bg = hsl("#151517") },

    Comment      { fg = hsl("#80baa7"), gui = "italic" },

    Constant     { fg = hsl("#53c0cd") },
    Number       { fg = hsl("#53c0cd") },
    Boolean      { fg = hsl("#61f2c7") },
    Character    { fg = hsl("#61f2c7") },

    String       { fg = hsl("#5cdb8d") },

    Identifier   { fg = hsl("#f7cdd4") },
    Function     { fg = hsl("#d496c1") },

    Keyword      { fg = hsl("#d65e7c") },
    Statement    { fg = hsl("#d65e7c") },
    Conditional  { Statement },
    Repeat       { Statement },
    Exception    { Statement },

    Type         { fg = hsl("#d496c1") },
    StorageClass { fg = hsl("#d65e7c") },
    Structure    { fg = hsl("#d496c1") },
    Typedef      { fg = hsl("#d496c1") },

    Operator     { fg = hsl("#d65e7c") },
    Delimiter    { fg = hsl("#d65e7c") },
    Special      { fg = hsl("#d65e7c") },
    SpecialChar  { fg = hsl("#d65e7c") },
    Tag          { fg = hsl("#d496c1") },

    Underlined   { fg = hsl("#d65e7c"), gui = "underline" },
    Todo         { fg = hsl("#d65e7c"), gui = "bold" },
    Error        { fg = hsl("#d65e7c"), gui = "bold" },

    ["@comment"]          = { Comment },
    ["@keyword"]          = { Keyword },
    ["@keyword.function"] = { Keyword },
    ["@string"]           = { String },
    ["@constant"]         = { Constant },
    ["@number"]           = { Number },
    ["@function"]         = { Function },
    ["@type"]             = { Type },
    ["@operator"]         = { Operator },
  }
end)

return based_theme
