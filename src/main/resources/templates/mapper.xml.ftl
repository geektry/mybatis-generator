<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package.Mapper}.${table.mapperName}">

    <!-- Please add 'allowMultiQueries=true' to jdbcUrl to enable multi-line insert/update -->

    <sql id="BaseColumns">
    <#list table.fields as field>
        t.${field.name}<#sep>,</#sep>
    </#list>
    </sql>

    <resultMap id="BaseResultMap" type="${package.Entity}.${entity}">
    <#list table.fields as field>
    <#if field.keyFlag>
        <id column="${field.name}" property="${field.propertyName}"/>
    <#else>
        <result column="${field.name}" property="${field.propertyName}"/>
    </#if>
    </#list>
    </resultMap>

    <select id="selectOneBy" resultMap="BaseResultMap">
        select
            <include refid="BaseColumns"/>
        from ${table.name} t
        <where>
        <#list table.fields as field>
        <#if field.name != 'is_deleted'>
            <if test="${field.propertyName} != null">and t.${field.name} = <#noparse>#</#noparse>{${field.propertyName}}</if>
        <#else>
            and t.is_deleted = false
        </#if>
        </#list>
        </where>
    </select>

    <select id="selectAllBy" resultMap="BaseResultMap">
        select
        <include refid="BaseColumns"/>
        from ${table.name} t
        <where>
        <#list table.fields as field>
        <#if field.name != 'is_deleted'>
            <if test="${field.propertyName} != null">and t.${field.name} = <#noparse>#</#noparse>{${field.propertyName}}</if>
        <#else>
            and t.is_deleted = false
        </#if>
        </#list>
        </where>
    </select>

    <insert id="insertOne" useGeneratedKeys="true" keyProperty="id">
        insert into ${table.name}
        <trim prefix="(" suffix=")" suffixOverrides=",">
        <#list table.fields as field>
            <if test="${field.propertyName} != null">${field.name},</if>
        </#list>
        </trim>
        values
        <trim prefix="(" suffix=")" suffixOverrides=",">
        <#list table.fields as field>
            <if test="${field.propertyName} != null"><#noparse>#</#noparse>{${field.propertyName}},</if>
        </#list>
        </trim>
    </insert>

    <insert id="insertAll">
        <foreach collection="list" item="item" separator=";">
            insert into ${table.name}
            <trim prefix="(" suffix=")" suffixOverrides=",">
            <#list table.fields as field>
                <if test="item.${field.propertyName} != null">${field.name},</if>
            </#list>
            </trim>
            values
            <trim prefix="(" suffix=")" suffixOverrides=",">
            <#list table.fields as field>
                <if test="item.${field.propertyName} != null"><#noparse>#</#noparse>{item.${field.propertyName}},</if>
            </#list>
            </trim>
        </foreach>
    </insert>

    <update id="updateOneById">
        update ${table.name}
        <set>
        <#list table.fields as field>
        <#if !field.keyFlag>
            <if test="${field.propertyName} != null">${field.name} = <#noparse>#</#noparse>{${field.propertyName}},</if>
        </#if>
        </#list>
        </set>
        where id = <#noparse>#</#noparse>{id}
        and is_deleted = false
    </update>

    <update id="updateAllById">
        <foreach collection="list" item="item" separator=";">
            update ${table.name}
            <set>
            <#list table.fields as field>
            <#if !field.keyFlag>
                <if test="item.${field.propertyName} != null">${field.name} = <#noparse>#</#noparse>{item.${field.propertyName}},</if>
            </#if>
            </#list>
            </set>
            where id = <#noparse>#</#noparse>{item.id}
            and is_deleted = false
        </foreach>
    </update>

    <update id="deleteOneById">
        update ${table.name}
        set is_deleted = true
        where id = <#noparse>#</#noparse>{id}
        and is_deleted = false
    </update>

    <update id="deleteAllById">
        update ${table.name}
        set is_deleted = true
        where id in
        <foreach collection="list" item="item" open="(" close=")" separator=",">
            <#noparse>#</#noparse>{item}
        </foreach>
        and is_deleted = false
    </update>
</mapper>