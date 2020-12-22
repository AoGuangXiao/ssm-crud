package com.agx.crud.test;

import com.agx.crud.pojo.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用Spring测试模块提供的测试请求功能，测试crud请求的正确性
 * Spring4测试的时候，需要Servlet3.0的支持
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springMVC.xml"})
public class MvcTest {
    //传入SpringMVC的IOC
    @Autowired
    WebApplicationContext webApplicationContext;
    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "2"))
                .andReturn();

        PageInfo pageInfo = (PageInfo) result.getRequest().getAttribute("pageInfo");
        //请求成功之后，请求域中会有pageInfo，可以从中取出进行验证
        System.out.println("当前页码："+pageInfo.getPageNum());
        System.out.println("总页码："+pageInfo.getPages());
        System.out.println("总记录数："+pageInfo.getTotal());
        System.out.println("连续显示的页码：");
        int[] pages = pageInfo.getNavigatepageNums();
        for(int i : pages){
            System.out.print(i+" ");
        }

        System.out.println("");

        //获取查询出的员工数据
        List<Employee> list = pageInfo.getList();
        for(Employee employee : list){
            System.out.println(employee);
        }
    }

}
