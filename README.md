# useful-dbt-macros

This repo aims to provide useful macros that I've created as part of my day to day life as a BI Analyst. 

Please feel free to use/adapt them and I hope you find them as useful as I do.

---

# Contents

## Macros

### Sandbox Environment helper macros

These macros help to make the testing of your dbt models faster and improve the quality of the analytics engineering workflow.

#### dev_testing ([source](macros/dev_testing.sql))

This macro is intended to replace the `ref()` macro temporarily during sandbox testing so that it references the tables from the production rather than needing the tables to exist in your sandbox schema. The construction is identical to `ref` and can be replaced directly.

This macro also has an optional `instance` argument that can take values ['dev','prod'] which can specify which environment to take the tables from. However, the effect of `instance='dev'` can also be simulated by not replacing the `ref` function with the `dev_testing` function.

**Args:**

- `table_name` (required): The name of the model/table that you want to reference from the production or sandbox environment. Equivalent to the 'model_name' arg in ref().
- `instance` (optional, default=`'prod'`): The name of the instance you want to reference the table from. The default is set to `'prod'` i.e. by default the dev_testing macro will reference the table from your prod instance.


**Usage:**

When it's time to test your models, replace the `ref` functions with `dev_testing` for all the models except the ones that have been **modified**. And as a result the macro will point to the dev instance for any modified models and reference any unchanged models straight from production rather than having to recreate those tables in your dev instance. Hence saving time and costs.

Alternatively, if you can use the instance arg to specify which instance to point the macro to.

```sql
select
  *
from {{ dev_testing('my_model') }}

```

```sql
select
  *
from {{ dev_testing('my_model', instance='dev') }}

```
