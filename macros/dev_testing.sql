{% macro dev_testing(table_name, instance='prod') -%}   

{#
        Macro Usage:
        {{ dev_testing('table_name') }} can be used to replace {{ ref('table_name') }} while testing models in your local instance. This macro will point to the equivalent table in production rather than trying to refer to tables in your local schema in your sandbox env.
#}

{%- if instance == 'dev' -%}
`dev-project-name`.{{target.schema}}.{{ table_name }}
{%- else -%}
`prod-project-name`.`prod-schema-name`.{{ table_name }}
{%- endif -%}

{%- endmacro %}
