return {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = { "cpp", "c", "cmake" },
    keys = {
        { "<F5>",  "<cmd>CMakeRun<cr>",              desc = "CMake Run" },
        { "<F7>",  "<cmd>CMakeBuild<cr>",            desc = "CMake Build" },
        { "<F4>",  "<cmd>CMakeDebug<cr>",            desc = "CMake Debug" },
        { "<F6>",  "<cmd>CMakeGenerate<cr>",         desc = "CMake Generate" },
        { "<F8>",  "<cmd>CMakeSelectBuildTarget<cr>", desc = "CMake Select Target" },
    },
    opts = {
        cmake_command = "cmake",
        cmake_build_directory = "build",
        cmake_generate_options = {
            "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
            "-DCMAKE_BUILD_TYPE=Debug",
        },
        cmake_build_options = {},
        cmake_show_console = "always",
        cmake_console_size = 10,
        cmake_console_position = "belowright",
        cmake_dap_configuration = {
            name = "cmake-debug",
            type = "codelldb",
            request = "launch",
            stopOnEntry = false,
            console = "integratedTerminal",
        },
        cmake_executor = {
            name = "quickfix",
            opts = {
                show = "always",
                position = "belowright",
                size = 10,
            },
        },
    },
}
