local schema_store = require("schemastore")
return {
  settings = {
    taplo = {
      -- Disable inbuilt store, use store provided by "schemastore" plugin
      schemaStore = {
        enabled = false,
        url = "",
      },
      schemas = schema_store.yaml.schemas(),
    },
  }
}
