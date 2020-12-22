package com.agx.crud.controller;

import com.agx.crud.pojo.Employee;
import com.agx.crud.pojo.Msg;
import com.agx.crud.service.EmployeeService;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工crud请求
 */
@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;


    /**
     * 删除用户
     * 单个批量二合一
     * 单个删除：1
     * 批量删除：1-2-3
     * @param ids
     * @return
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids") String ids){
        //参数中包含"-"的为批量删除
        if(ids.contains("-")){
            //用于保存用户id的集合
            List<Integer> del_ids = new ArrayList<Integer>();
            //将请求参数以"-"分割
            String[] str_ids = ids.split("-");
            //遍历字符串数组，依次将用户ID添加到List集合中
            for(String emp:str_ids){
                del_ids.add(Integer.parseInt(emp));
            }
            //调用业务层方法
            employeeService.batchDeleteEmps(del_ids);
        }else {
            //单个删除直接将参数转换类型后进行删除
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmpByID(id);
        }
        return Msg.success();
    }



    /**
     * 对于ajax请求直接发送post请求服务器不允许的问题：
     * 解决方案：我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
     * 1.在web.xml中配置HttpPutFormContentFilter, url-pattern设为/*;
     * 2.他的作用：将请求体中的数据解析包装成一个map
     * 3.request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
     *
     * 修改用户数据
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){
        employeeService.updateEmpByID(employee);
        return Msg.success().add("message","修改成功");
    }



    /**
     * 根据id查询用户
     * @return
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmpWithID(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmpWithID(id);
        return Msg.success().add("employee",employee);
    }



    /**
     * 校验用户名是否可用
     * @param empName
     * @return
     */
    @RequestMapping("checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
        //先进行格式校验
        String regx = "(^[a-zA-Z0-9_-]{4,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("validate_msg","用户名必须是4-16位的字母数字或者2-5位的汉字");
        }

        //再进行内容校验，判断用户名是否重复
        boolean isUseful = employeeService.checkUser(empName);
        if(isUseful){
            return Msg.success().add("validate_msg","用户名可用");
        }else {
            return Msg.fail().add("validate_msg","用户名已存在");
        }
    }



    /**
     * 保存员工
     * 1.支持JSR303校验
     * 2.导入Hibernate-Validator
     *
     * @return
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的提示信息
            Map<String,Object> map = new HashMap<String, Object>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError:errors){
//                System.out.println("错误的字段名："+fieldError.getField());
//                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            return employeeService.saveEmp(employee);
        }
    }



    /**
     * 查询所有员工数据(分页查询)
     * 用于返回json类型的控制器，要导入jackson的包
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //引入pageHelper插件
        //在查询之前只需要调用，传入页码以及每页显示的数量
        PageHelper.startPage(pn,5);
        //startPage后紧跟这个查询就是一个分页查询了
        List<Employee> list = employeeService.getAll();
        //使用pageInfo包装查询结果，只需要将pageInfo交给页面就可以了
        //传入连续显示的页数
        PageInfo pageInfo = new PageInfo(list,5); //封装了详细的分页信息，包括查询出来的数据
        return Msg.success().add("pageInfo",pageInfo);
    }
    /**
     * 查询所有员工数据(分页查询)
     * @return
     */
//    @RequestMapping("/emps")
    /*public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        //引入pageHelper插件
        //在查询之前只需要调用，传入页码以及每页显示的数量
        PageHelper.startPage(pn,5);
        //startPage后紧跟这个查询就是一个分页查询了
        List<Employee> list = employeeService.getAll();
        //使用pageInfo包装查询结果，只需要将pageInfo交给页面就可以了
        //传入连续显示的页数
        PageInfo pageInfo = new PageInfo(list,5); //封装了详细的分页信息，包括查询出来的数据
        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }*/

}
