vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'dcampos/nvim-snippy'
	use 'honza/vim-snippets'
	--cmp plugins
	--
	use "hrsh7th/nvim-cmp"
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-cmdline"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-path"

	use 'nvim-treesitter/nvim-treesitter'
	use {'nvim-orgmode/orgmode', config = function()
		require('orgmode').setup{}
	end
        }
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		--- branch = '0.1.x',
                requires = { {'nvim-lua/plenary.nvim'} }
        }
	-- autocomplete 
	use 'm4xshen/autoclose.nvim'
	use 'rebelot/kanagawa.nvim'
	use {
	      "windwp/nvim-autopairs",
	    config = function() require("nvim-autopairs").setup {} end
        }
	use{
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
end)
