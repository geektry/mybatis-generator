package ${package.Mapper};

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import ${package.Entity}.${entity};

import java.util.List;

/**
 * @author ${author}
 */
@Mapper
@Repository
public interface ${table.mapperName} {

    ${entity} selectOneBy(${entity} columns);

    List<${entity}> selectAllBy(${entity} columns);

    int insertOne(${entity} row);

    int insertAll(List<${entity}> rows);

    int updateOneById(${entity} row);

    int updateAllById(List<${entity}> rows);

    int deleteOneById(Long id);

    int deleteAllById(List<Long> ids);
}
