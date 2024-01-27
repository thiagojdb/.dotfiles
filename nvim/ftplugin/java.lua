local home = os.getenv "HOME"
local root_markers = { 'gradlew', '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_folder = home ..
    "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local JAVA_1_8 = home .. '/.sdkman/candidates/java/8.0.402-amzn/'
local JAVA_17 = home .. '/.sdkman/candidates/java/17.0.10-oracle/'



-- This bundles definition is the same as in the previous section (java-debug installation)
local bundles = {
    vim.fn.glob(
        home ..
        "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/*.jar", 1),
};
-- This is the new part
vim.list_extend(bundles,
    vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-test/extension/server/*.jar", 1), "\n"))

require('jdtls').start_or_attach({
    cmd = {
        JAVA_17 .. 'bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        "-javaagent:" ..
        "/home/thiago/.local/share/nvim/mason/packages/jdtls/lombok.jar",
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar',
        '-configuration',
        '/home/thiago/.local/share/nvim/mason/packages/jdtls/config_linux',
        '-data', workspace_folder
    },
    root_dir = root_dir,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            completion = {
                favoriteStaticMembers = {
                    "java.util.Objects.*",
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
            },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-1.8",
                        path = JAVA_1_8
                    },
                    {
                        name = "JavaSE-17",
                        path = JAVA_17
                    },
                }
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                settings = {
                    url =
                    "/home/thiago/.config/nvim/format/eclipse-google-java-style.xml"
                }
            },
            codeGeneration = {
                toString = {
                    template =
                    "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
            },
            flags = {
                allow_incremental_sync = true,
            }
        }
    },
    on_attach = function(_, bufnr)
        require('dap.ext.vscode').load_launchjs()
    end,
    init_options = {
        bundles = bundles,
        usePlaceholders = true
    },
    capabilities = capabilities
});
