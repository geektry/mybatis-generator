package com.geektry.mg;

import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.DateType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.ArrayList;

@ConfigurationProperties(prefix = "mg")
@Component
public class MG {

    private String author;
    private String parentPackage;
    private String tablePrefix;
    @Value("${spring.datasource.driver-class-name}")
    private String jdbcDriverName;
    @Value("${spring.datasource.url}")
    private String jdbcUrl;
    @Value("${spring.datasource.username}")
    private String jdbcUsername;
    @Value("${spring.datasource.password}")
    private String jdbcPassword;

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setParentPackage(String parentPackage) {
        this.parentPackage = parentPackage;
    }

    public void setTablePrefix(String tablePrefix) {
        this.tablePrefix = tablePrefix;
    }

    public void generate(String... tableNames) {

        String userDir = System.getProperty("user.dir");

        new AutoGenerator() {{
            setDataSource(new DataSourceConfig() {{
                setUrl(jdbcUrl);
                setDriverName(jdbcDriverName);
                setUsername(jdbcUsername);
                setPassword(jdbcPassword);
            }});
            setStrategy(new StrategyConfig() {{
                setNaming(NamingStrategy.underline_to_camel);
                setColumnNaming(NamingStrategy.underline_to_camel);
                setTablePrefix(tablePrefix);
                setInclude(tableNames);
            }});
            setPackageInfo(new PackageConfig() {{
                setParent(parentPackage);
                setEntity("entity");
                setService("service");
                setServiceImpl("service.impl");
                setMapper("mapper");
                setController("controller");
            }});
            setCfg(new InjectionConfig() {
                @Override
                public void initMap() {}
            }.setFileOutConfigList(new ArrayList<FileOutConfig>() {{
                add(new FileOutConfig("templates/mapper.xml.ftl") {
                    @Override
                    public String outputFile(TableInfo tableInfo) {
                        return userDir + "/src/main/resources/mapper/" +
                                "/" + tableInfo.getEntityName() + "Mapper" + StringPool.DOT_XML;
                    }
                });
            }}));
            setTemplate(new TemplateConfig() {{
                setEntity("templates/entity.java");
                setService("templates/service.java");
                setServiceImpl("templates/serviceImpl.java");
                setMapper("templates/mapper.java");
                setXml(null);
                setController("templates/controller.java");
            }});
            setGlobalConfig(new GlobalConfig() {{
                setOutputDir(userDir + "/src/main/java");
                setOpen(false);
                setAuthor(author);
//                setDateType(DateType.ONLY_DATE);
                setServiceName("%sService");
            }});
            setTemplateEngine(new FreemarkerTemplateEngine());
        }}.execute();
    }
}