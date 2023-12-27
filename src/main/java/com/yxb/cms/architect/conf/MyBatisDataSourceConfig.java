
package com.yxb.cms.architect.conf;

import com.alibaba.druid.pool.DruidDataSource;
import com.yxb.cms.architect.properties.AppCommonMyBatisProperties;
import com.yxb.cms.architect.properties.JdbcProperties;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.aop.framework.autoproxy.BeanNameAutoProxyCreator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.interceptor.TransactionInterceptor;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.Properties;

@Configuration
@EnableTransactionManagement
 //扫描 Mapper 接口并容器管理
@MapperScan(basePackages = "com.yxb.cms.dao")
public class MyBatisDataSourceConfig {


    private static Logger log  = LogManager.getLogger(MyBatisDataSourceConfig.class);


    /**
     * 注册DataSource
     * @return
     */
	@Bean(destroyMethod = "close", initMethod="init")
    @Primary
    public DataSource myBatisDataSource(AppCommonMyBatisProperties appCommonMyBatisProperties,JdbcProperties jdbcProperties) throws SQLException {

        log.info("------------------myBatis DruiDataSource init ---------");
        DruidDataSource dataSource = new DruidDataSource();
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        dataSource.setUrl(jdbcProperties.getUrl());
        dataSource.setUsername(jdbcProperties.getUsername());
        dataSource.setPassword(jdbcProperties.getPassword());
        dataSource.setInitialSize(jdbcProperties.getInitialSize());             //初始化链接大小
        dataSource.setMaxActive(jdbcProperties.getMaxActive());                 //连接池最大使用链接数量
        //dataSource.setMaxIdle(dbProperties.getMaxIdle());                   //连接池最大空闲,过时,暂不使用
        dataSource.setMinIdle(jdbcProperties.getMinIdle());                     //连接池最小空闲
        dataSource.setMaxWait(jdbcProperties.getMaxWait());                     //获取连接最大等待时间
        dataSource.setValidationQuery(jdbcProperties.getValidationQuery());     //验证数据库是否连通

        dataSource.setTestOnBorrow(appCommonMyBatisProperties.isTestOnBorrow());
        dataSource.setTestOnReturn(appCommonMyBatisProperties.isTestOnReturn());
        dataSource.setTestWhileIdle(appCommonMyBatisProperties.isTestWhileIdle());
        //配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒
        dataSource.setTimeBetweenEvictionRunsMillis(appCommonMyBatisProperties.getTimeBetweenEvictionRunsMillis());
        //配置一个连接在池中最小生存的时间，单位是毫秒
        dataSource.setMinEvictableIdleTimeMillis(appCommonMyBatisProperties.getMinEvictableIdleTimeMillis());
        //打开removeAbandoned功能
        dataSource.setRemoveAbandoned(appCommonMyBatisProperties.isRemoveAbandoned());
        // 1800秒，也就是30分
        dataSource.setRemoveAbandonedTimeout(appCommonMyBatisProperties.getRemoveAbandonedTimeout());
        //关闭abanded连接时输出错误日志
        dataSource.setLogAbandoned(appCommonMyBatisProperties.isLogAbandoned());
        //监控数据库
        dataSource.setFilters(appCommonMyBatisProperties.getFilters());
        //开启池的prepared statement 池功能
        dataSource.setPoolPreparedStatements(appCommonMyBatisProperties.isPoolPreparedStatements());

        return dataSource;
    }

    /**
     * 注册数据源事务管理
     * @return
     * @throws SQLException
     */
    @Bean(name="myBatisTransactionManager")
    public DataSourceTransactionManager myBatisTransactionManager(DataSource myBatisDataSource) throws SQLException {
        return new DataSourceTransactionManager(myBatisDataSource);
    }


    /**
     * 声明式事务
     * @param platformTransactionManager
     * @return
     */
    @Bean(name="transactionInterceptor")
    public TransactionInterceptor transactionInterceptor(PlatformTransactionManager platformTransactionManager){
        TransactionInterceptor transactionInterceptor = new TransactionInterceptor();
        transactionInterceptor.setTransactionManager(platformTransactionManager);
        Properties transactionAttributes = new Properties();
        transactionAttributes.setProperty("create*","PROPAGATION_REQUIRED,-Throwable");
        transactionAttributes.setProperty("insert*","PROPAGATION_REQUIRED,-Throwable");
        transactionAttributes.setProperty("save*","PROPAGATION_REQUIRED,-Throwable");
        transactionAttributes.setProperty("update*","PROPAGATION_REQUIRED,-Throwable");
        transactionAttributes.setProperty("delete*","PROPAGATION_REQUIRED,-Throwable");
        transactionAttributes.setProperty("select*","PROPAGATION_REQUIRED,-Throwable,readOnly");
        transactionInterceptor.setTransactionAttributes(transactionAttributes);
        return transactionInterceptor;
    }
    @Bean
    public BeanNameAutoProxyCreator transactionAutoProxy(){
        BeanNameAutoProxyCreator transactionAutoProxy = new BeanNameAutoProxyCreator();
        transactionAutoProxy.setProxyTargetClass(true);
        transactionAutoProxy.setBeanNames("*Service");
        transactionAutoProxy.setInterceptorNames("transactionInterceptor");
        return transactionAutoProxy;
    }

    /**
     * 注册数据源事务管理
     * @param myBatisDataSource
     * @return
     * @throws Exception
     */
    @Bean
    public SqlSessionFactory myBatisSqlSessionFactory(DataSource myBatisDataSource,AppCommonMyBatisProperties appCommonMyBatisProperties) throws Exception {
        final SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        //添加数据源
        sessionFactory.setDataSource(myBatisDataSource);
        //实体类扫描路径
        sessionFactory.setTypeAliasesPackage(appCommonMyBatisProperties.getTypeAliasesPackage());
        //Mapper文件位置
        sessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources(appCommonMyBatisProperties.getMapperLocation()));
        //mybatisConfig 文件
        sessionFactory.setConfigLocation(new DefaultResourceLoader().getResource(appCommonMyBatisProperties.getConfigLocation()));
        return sessionFactory.getObject();
    }
}