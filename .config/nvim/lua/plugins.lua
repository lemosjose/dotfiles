vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	-- orgmode 
	use 'nvim-treesitter/nvim-treesitter'
	use {'nvim-orgmode/orgmode', config = function()
		require('orgmode').setup{}
	end
        }
	-- autocomplete 
	use "hrsh7th/nvim-cmp"
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use 'hrsh7th/cmp-emoji'
        use 'hrsh7th/cmp-nvim-lua'
	use 'L3MON4D3/LuaSnip'

	use {
	      "windwp/nvim-autopairs",
	    config = function() require("nvim-autopairs").setup {} end
        }
	use{
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
end)
