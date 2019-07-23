package ${package.Entity};

import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

/**
* @author ${author}
*/
@Data
public class ${entity} {
<#list table.fields as field>
    private ${field.propertyType} ${field.propertyName};
</#list>
}
