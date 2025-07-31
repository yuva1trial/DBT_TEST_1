{% macro log_audit_failure(model_name, test_name, failure_reason) %}
    {% set sql %}
        insert into {{ target.schema }}.central_audit_log (
            model_name,
            test_name,
            failure_reason,
            logged_at
        )
        values (
            '{{ model_name }}',
            '{{ test_name }}',
            '{{ failure_reason | replace("'", "''") }}',
            current_timestamp()
        )
    {% endset %}

    {% do run_query(sql) %}
{% endmacro %}