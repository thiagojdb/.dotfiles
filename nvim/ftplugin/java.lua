--local jdtls = require('jdtls')
--local root_markers = { 'gradlew', '.git' }
--local root_dir = require('jdtls.setup').find_root(root_markers)
--local home = os.getenv('HOME')
--local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
--local mason = home .. '/.local/share/nvim/mason/packages'
--local config = {}
--config.settings = {
--  java = {
--    signatureHelp = { enabled = true },
--    contentProvider = { preferred = 'fernflower' },
--    completion = {
--      favoriteStaticMembers = {
--        "org.hamcrest.MatcherAssert.assertThat",
--        "org.hamcrest.Matchers.*",
--        "org.hamcrest.CoreMatchers.*",
--        "org.junit.jupiter.api.Assertions.*",
--        "java.util.Objects.requireNonNull",
--        "java.util.Objects.requireNonNullElse",
--        "org.mockito.Mockito.*"
--      },
--      filteredTypes = {
--        "com.sun.*",
--        "io.micrometer.shaded.*",
--        "java.awt.*",
--        "jdk.*",
--        "sun.*",
--      },
--    },
--    sources = {
--      organizeImports = {
--        starThreshold = 9999,
--        staticStarThreshold = 9999,
--      },
--    },
--    codeGeneration = {
--      toString = {
--        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
--      },
--      hashCodeEquals = {
--        useJava7Objects = true,
--      },
--      useBlocks = true,
--    },
--    configuration = {
--      runtimes = {
--        {
--          name = "JavaSE-11",
--          path =
--          "/home/thiago/.sdkman/candidates/java/11.0.21-ms/",
--        },
--        {
--          name = "JavaSE-17",
--          path =
--          "/home/thiago/.sdkman/candidates/java/17.0.9-graalce/",
--        },
--
--      }
--    },
--  },
--}
--config.cmd = {
--  home .. "/.sdkman/candidates/java/17.0.9-graalce/bin/java",
--  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--  '-Dosgi.bundles.defaultStartLevel=4',
--  '-Declipse.product=org.eclipse.jdt.ls.core.product',
--  '-Dlog.protocol=true',
--  '-Dlog.level=ALL',
--  --"-javaagent:" .. mason .. "/jdtls/lombok.jar",
--  '-Xmx4g',
--  '--add-modules=ALL-SYSTEM',
--  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
--  '-jar', vim.fn.glob(mason .. '/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
--  '-configuration',
--  mason .. '/jdtls/config_linux',
--  '-data', workspace_folder,
--}
--config.on_attach = function(client, bufnr)
--  jdtls.setup_dap({ hotcodereplace = 'auto' })
--  jdtls.setup.add_commands()
--  local opts = { silent = true, buffer = bufnr }
--  vim.keymap.set('n', "<A-o>", jdtls.organize_imports, opts)
--  vim.keymap.set('n', "<leader>df", jdtls.test_class, opts)
--  vim.keymap.set('n', "<leader>dn", jdtls.test_nearest_method, opts)
--  vim.keymap.set('n', "crv", jdtls.extract_variable, opts)
--  vim.keymap.set('v', 'crm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
--  vim.keymap.set('n', "crc", jdtls.extract_constant, opts)
--end
--
--local jar_patterns = {
--  mason .. "/java-debug-adapter/extension/server/*.jar",
--  mason .. "/java-test/extension/server/*.jar",
--  mason .. "/vscode-java-decompiler/server/*.jar"
--
--}
--
--local bundles = {}
--for _, jar_pattern in ipairs(jar_patterns) do
--  for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
--    if not vim.endswith(bundle, 'com.microsoft.java.test.runner-jar-with-dependencies.jar')
--        and not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
--      table.insert(bundles, bundle)
--    end
--  end
--end
--local extendedClientCapabilities = jdtls.extendedClientCapabilities;
--extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
--config.init_options = {
--  bundles = bundles,
--  extendedClientCapabilities = extendedClientCapabilities,
--}
---- mute; having progress reports is enough
----config.handlers['language/status'] = function() end
--jdtls.start_or_attach(config)

local home = os.getenv "HOME"
local root_markers = { 'gradlew', '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_folder = home ..
    "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- This bundles definition is the same as in the previous section (java-debug installation)
local bundles = {
  vim.fn.glob(
    home ..
    "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/*.jar", 1),
};
--/home/thiago/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.47.0.jar

-- This is the new part
vim.list_extend(bundles, vim.split(vim.fn.glob(home .."/.local/share/nvim/mason/packages/java-test/extension/server/*.jar", 1), "\n"))

local config = {
  cmd = {
    '/home/thiago/.sdkman/candidates/java/21.0.1-amzn/bin/java',
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
    '/home/thiago/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.600.v20231012-1237.jar',
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
            "/home/thiago/.sdkman/candidates/java/17.0.9-amzn/",
          },
          {
            name = "JavaSE-21",
            path =
            "/home/thiago/.sdkman/candidates/java/21.0.1-amzn/",
          }
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
  end,
  init_options = {
    bundles = bundles,
    usePlaceholders = true
  },
  capabilities = capabilities
}

require('jdtls').start_or_attach(config);
