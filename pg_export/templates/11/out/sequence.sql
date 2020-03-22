create sequence {{ full_name }}
    {%- if start %}
    start with {{ start }}
    {%- endif %}
    {%- if increment %}
    increment by {{ increment }}
    {%- endif %}
    {%- if min %}
    minvalue {{ min }}
    {%- endif %}
    {%- if max %}
    maxvalue {{ max }}
    {%- endif %}
    {%- if cache %}
    cache {{ cache }}
    {%- endif %}
    {%- if cycle %}
    cycle
    {%- endif %};

