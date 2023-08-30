local home = os.getenv "HOME"
local root_markers = { 'gradlew', '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_folder = home ..
    "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local java_debug_path = vim.fn.glob(
        home ..
        "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/*.jar"
        , 1)
    local jdtls_bundles = {
        java_debug_path
    };

    vim.list_extend(jdtls_bundles,
        vim.split(
            vim.fn.glob(
                home ..
                "/.local/share/nvim/mason/packages/java-test/extension/server/*.jar",
                1),
            "\n"))

    local config = {
        cmd = {
            '/home/thiago/.sdkman/candidates/java/17.0.7-tem/bin/java',
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
            '/home/thiago/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230622-2056.jar',
            '-configuration',
            '/home/thiago/.local/share/nvim/mason/packages/jdtls/config_linux',
            '-data', workspace_folder
        },
        root_dir = root_dir,
        settings = {
            java = {
                completion = {
                    favoriteStaticMembers = {
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
                            path =
                            "/home/thiago/.sdkman/candidates/java/8.0.382-amzn/",
                        },
                        {
                            name = "JavaSE-11",
                            path =
                            "/home/thiago/.sdkman/candidates/java/11.0.20-amzn/",
                        },
                        {
                            name = "JavaSE-17",
                            path =
                            "/home/thiago/.sdkman/candidates/java/17.0.8-amzn/",
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
            require('jdtls.setup').add_commands()
            require('jdtls').setup_dap({ hotcodereplace = 'auto' })
            require('dap.ext.vscode').load_launchjs()
        end,
        init_options = {
            bundles = jdtls_bundles,
            usePlaceholders = true
        },
        capabilities = capabilities
    }

    require('jdtls').start_or_attach(config);

