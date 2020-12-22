package com.agx.crud.test;

import com.agx.crud.dao.DepartmentMapper;

import com.agx.crud.dao.EmployeeMapper;
import com.agx.crud.pojo.Department;
import com.agx.crud.pojo.Employee;
import org.apache.ibatis.jdbc.Null;
import org.apache.ibatis.session.SqlSession;
import org.apache.taglibs.standard.lang.jstl.NullLiteral;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Random;
import java.util.UUID;

/**
 * 测试dao层的工作
 * 推荐Spring的项目使用Spring的单元测试，可以自动注入需要的组件
 * 1.导入Spring-test模块
 * 2.@ContextConfiguration指定Spring配置文件位置
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private SqlSession session;

    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCrud(){
        /*//1.获取SpringIOC容器
        ApplicationContext ac = new ClassPathXmlApplicationContext("");
        //2.从容器中获取mapper
        DepartmentMapper mapper = ac.getBean(DepartmentMapper.class);*/
//        System.out.println(departmentMapper);

        //1.插入部门测试
        //departmentMapper.insertSelective(new Department(null,"开发部"));
        //departmentMapper.insertSelective(new Department(null,"测试部"));

        //2.插入员工测试
        //employeeMapper.insertSelective(new Employee(null,"Michael","m","Michael@agx.com",1));

        //3.批量插入员工数据。使用可以批量操作的SqlSession
        /*for(){
            employeeMapper.insertSelective(new Employee(null,"","m","Michael@agx.com",1));
        }*/

        //获取可以批量操作的SqlSession
        EmployeeMapper employeeMapper = session.getMapper(EmployeeMapper.class);
//        for(int i=0; i<1000; i++){
//            String uuid = UUID.randomUUID().toString().substring(0,5) + i;
//            employeeMapper.insertSelective(new Employee(null,uuid,"m",uuid+"@agx.com",1));
//        }
//        System.out.println("批量完成");

        int count = 0;
        //批量修改部门号和性别
        for(int i=0; i<300; i++){
            //获取0-1000的随机数，根据主键进行随机修改
            Random random = new Random();
            int randInt = random.nextInt(1000);
            System.out.println(randInt);
            Employee employee = employeeMapper.selectByPrimaryKey(randInt);
            employee.setGender("w");
            count += employeeMapper.updateByPrimaryKey(employee);
        }
        System.out.println("count"+count);

    }
}
