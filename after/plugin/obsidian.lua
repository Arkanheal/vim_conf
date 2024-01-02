local handle = io.popen("uname -a")
local os_result = handle:read("*a")
handle:close()

require("obsidian").setup({
	dir = "~/main_vault/",

	notes_subdir = "notes",

	daily_notes = {
		-- Optional, if you keep daily notes in a separate directory.
		folder = "notes/dailies",
		-- Optional, if you want to change the date format for daily notes.
		date_format = "%Y-%m-%d",

		template = "daily_note.md",
	},

	completion = {
		nvim_cmp = true,
		-- Trigger completion at 2 chars
		min_chars = 2,
		-- Where to put new notes created from completion. Valid options are
		--  * "current_dir" - put new notes in same directory as the current buffer.
		--  * "notes_subdir" - put new notes in the default notes subdirectory.
		new_notes_location = "notes_subdir",

		-- Whether to add the output of the node_id_func to new notes in autocompletion.
		-- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
		prepend_note_id = true,
		-- Optional, completion.
	},
	note_id_func = function(title)
		-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
		-- In this case a note with the title 'My new note' will given an ID that looks
		-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
		local suffix = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name.
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			-- If title is nil, just add 4 random uppercase letters to the suffix.
			local time = tostring(os.time())
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
			suffix = time .. "-" .. suffix
		end
		return suffix
	end,
	follow_url_func = function(url)
		-- Open the URL in the default web browser.
		if string.match(os_result, "Linux") ~= nil then
			vim.fn.jobstart({ "xdg-open", url }) -- Linux
		elseif string.match(os_result, "Mac") ~= nil then
			vim.fn.jobstart({ "open", url }) -- Mac OS
		end
	end,

	-- Optional, for templates (see below).
	templates = {
		subdir = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M",
		-- A map for custom variables, the key should be the variable and the value a function
		substitutions = {},
	},

	-- Optional, key mappings.
	mappings = {
		-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
		["gf"] = {
			action = function()
				return require("obsidian").util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
		-- Toggle check-boxes.
		["<leader>ch"] = {
			action = function()
				return require("obsidian").util.toggle_checkbox()
			end,
			opts = { buffer = true },
		},
	},
})
