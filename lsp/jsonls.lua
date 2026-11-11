local schema_store = require("schemastore")
return {
  settings = {
    json = {
      validate = {
        enable = true,
      },
      -- Disable inbuilt store, use store provided by "schemastore" plugin
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = schema_store.json.schemas(),
    },
  },
}
