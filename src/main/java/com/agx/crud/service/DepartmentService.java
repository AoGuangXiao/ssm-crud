package com.agx.crud.service;

import com.agx.crud.dao.DepartmentMapper;
import com.agx.crud.pojo.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 与部门相关的业务层
 */
@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    /**
     * 查询所有部门
     * @return
     */
    public List<Department> selAllDepartments(){
        return departmentMapper.selectByExample(null);
    }
}
