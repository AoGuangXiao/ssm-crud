package com.agx.crud.controller;

import com.agx.crud.pojo.Department;
import com.agx.crud.pojo.Msg;
import com.agx.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理所有与部门相关的请求
 */
@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    /**
     * 获取所有部门信息
     * @return
     */
    @RequestMapping("depts")
    @ResponseBody
    public Msg getAllDepts(){
        //调用业务层方法获取所有部门
        List<Department> depts = departmentService.selAllDepartments();
        //封装Msg对象并返回
        return Msg.success().add("depts",depts);
    }

}
