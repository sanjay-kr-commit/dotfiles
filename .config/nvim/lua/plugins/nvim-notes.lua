return {
  "kilavila/nvim-notes",
  dependencies = { "kkharji/sqlite.lua" },
  keys = {
    {
      "<leader>nn",
      ":NotesNew<CR>",
      desc = "Create a new note",
    },
    {
      "<leader>ns",
      ":NotesSave<CR>",
      desc = "Save current note",
    },
    {
      "<leader>ne",
      ":NotesEdit<CR>",
      desc = "Edit a note",
    },
    {
      "<leader>nd",
      ":NotesDelete<CR>",
      desc = "Deletes a note",
    },
    {
      "<leader>nl",
      ":NotesLoad<CR>",
      desc = "Loads a note",
    },
  },
  config = function()
    require("nvim-notes").setup({
      -- WARNING: By default nvim-notes creates a database in each project!
      -- the following config will make nvim-notes use a global database for all projects
      db_url = "~/nvim-notes.db", -- optional
      symbol = "⭐", -- optional
      delimiter = ";;", -- optional
    })
  end,
}
