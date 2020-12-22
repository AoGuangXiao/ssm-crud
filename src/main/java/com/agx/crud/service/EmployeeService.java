package com.agx.crud.service;

import com.agx.crud.dao.EmployeeMapper;
import com.agx.crud.pojo.Employee;
import com.agx.crud.pojo.EmployeeExample;
import com.agx.crud.pojo.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 保存员工
     * @param employee
     */
    public Msg saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
        return Msg.success();
    }

    /**
     * 判断用户名是否已存在
     * @param empName
     * @return count等于0说明数据库中不存在该用户名，可用使用，返回true
     *         count不等于0说明该用户名已存在，不可用，返回false
     */
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        Long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    /**
     * 根据ID查询用户
     * @param id
     * @return
     */
    public Employee getEmpWithID(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     * 根据id修改用户数据
     * @param employee
     */
    public void updateEmpByID(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 根据ID删除用户
     * @param id
     */
    public void deleteEmpByID(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除用户
     * @param list
     */
    public void batchDeleteEmps(List<Integer> list) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(list);
        employeeMapper.deleteByExample(example);
    }
}
