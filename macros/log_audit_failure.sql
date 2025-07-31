{% macro log_audit_failure_from_results(results) %}
    {% for result in results if result.status != 'pass' and result.resource_type == 'test' %}
        {% set sql %}
            insert into {{ target.schema }}.central_audit_log (
                model_name,
                test_name,
                failure_reason,
                logged_at
            )
            values (
                '{{ result.node.name }}',
                '{{ result.unique_id }}',
                '{{ result.message | default("Test failure") | replace("'", "''") }}',
                current_timestamp()
            )
        {% endset %}
        {% do run_query(sql) %}
    {% endfor %}
{% endmacro %}