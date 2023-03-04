<div align="center">

# sentiment.nvim

Enhanced matchparen plugin for Neovim.

</div>

## 📦 Installation

- [lazy.nvim][lazy.nvim]

  ```lua
  {
    "utilyre/sentiment.nvim",
    name = "sentiment",
    opts = {
      -- configurations go here
    },
  }
  ```

- [packer.nvim][packer.nvim]

  ```lua
  use({
    "utilyre/sentiment.nvim",
    config = function()
      require("sentiment").setup()
    end,
  })
  ```
