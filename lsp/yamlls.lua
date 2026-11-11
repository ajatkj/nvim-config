local schema_store = require("schemastore")
return {
  settings = {
    yaml = {
      -- Disable inbuilt store, use store provided by "schemastore" plugin
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = schema_store.yaml.schemas(),
    },
  }
}
