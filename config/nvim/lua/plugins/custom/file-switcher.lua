local function switch_file()
    local name = vim.fn.expand("%:t:r")
    local ext = vim.fn.expand("%:e")

    local targets = {
        h = { "cpp", "cc", "cxx" },
        hpp = { "cpp", "cc", "cxx" },
        cpp = { "h", "hpp" },
        cc = { "h", "hpp" },
        cxx = { "h", "hpp" },
    }

    if not targets[ext] then
        return
    end

    local files = {}

    for _, target in ipairs(targets[ext]) do
        vim.list_extend(files, vim.fn.glob(
            vim.fn.getcwd() .. "/**/" .. name .. "." .. target,
            false,
            true
        ))
    end

    if #files > 0 then
        vim.cmd("edit " .. vim.fn.fnameescape(files[1]))
        return
    end

    local target = targets[ext][1]

    vim.ui.select(
        { "Create " .. name .. "." .. target, "Cancel" },
        { prompt = "File not found:" },
        function(choice)
            if choice and choice:sub(1, 6) == "Create" then
                vim.cmd("edit " .. vim.fn.fnameescape(name .. "." .. target))
            end
        end
    )
end

vim.keymap.set("n", "<leader>\\", switch_file, {
    desc = "Switch source/header",
})

return {}
