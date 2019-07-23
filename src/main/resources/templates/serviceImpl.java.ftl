package ${package.ServiceImpl};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ${package.Service}.${table.serviceName};
import ${package.Mapper}.${table.mapperName};

/**
 * @author ${author}
 */
@Service
public class ${table.serviceImplName} implements ${table.serviceName} {

    @Autowired
    private ${table.mapperName} ${table.mapperName?uncap_first};
}
