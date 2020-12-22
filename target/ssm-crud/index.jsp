<%--
  Created by IntelliJ IDEA.
  User: 敖尼玛112
  Date: 2020/12/18
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>

    <!-- web路径：
     不以/开头的相对路径，找资源时以当前资源的路径为基准，经常由于各种跳转而出现问题。
     以/开头的(相对路径)?找资源时以服务器的路径为基准(http://localhost:8080)，需要加上项目名
                    http://localhost:8080/ssm-crud
     -->
    <!-- 引入前端框架时，type属性和rel属性一定要写对，否则下面的标签会失效！！！！！！！！！ -->
    <!-- 引入jQuery -->
    <script type="text/javascript" src="${APP_PATH}static/js/jquery-1.12.4.min.js"></script>
    <!-- 引入样式 -->
    <link href="${APP_PATH}static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="${APP_PATH}static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>



<body>
<!-- 修改用户的弹窗Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="emp_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="xxxx@agx.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="m" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="w"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                                <!-- 提交部门id即可 -->
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">Update</button>
            </div>
        </div>
    </div>
</div>



<!-- 添加用户的弹窗Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="请输入用户名">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="xxxx@agx.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_add_radio1" value="m" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_add_radio2" value="w"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                                <!-- 提交部门id即可 -->
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">Save changes</button>
            </div>
        </div>
    </div>
</div>

<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-10">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <br/>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>Email</th>
                    <th>部门名称</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <!-- 显示分页信息 -->
    <div class="row">
        <!-- 分页文字信息 -->
        <div class="col-md-6" id="page_info_area"></div>
        <!-- 分页条信息 -->
        <div class="col-md-6 col-md-offset-8" id="page_nav_area"></div>
    </div>
</div>


<script type="text/javascript">
    //定义一个全局属性用于操作之后显示最后一页数据
    var totalRecord,currentPage;

    //1.页面加载完成之后，直接发送ajax请求，获取到分页信息
    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                //console.log(result);
                //1.解析并显示员工数据
                build_emp_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析并显示分页条信息
                build_page_nav(result);
            }
        })
    }

    //1.解析并显示员工数据
    function build_emp_table(result) {
        //每次发送ajax请求先进行清空
        $("#emps_table tbody").empty();
        var emps = result.map.pageInfo.list;
        $.each(emps, function (index,item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='m'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var departmentTd = $("<td></td>").append(item.department.deptName);
            var edit_btn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                            .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" 编辑")
            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            edit_btn.attr("empId",item.empId);
            var delete_btn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                            .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" 删除");
            //为删除按钮添加一个自定义的属性，来表示当前员工id
            delete_btn.attr("empId",item.empId);
            var btnTd = $("<td></td>").append(edit_btn).append(" ").append(delete_btn);
            //append()方法执行完成之后还是返回原来地元素，所以可以进行链式操作
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(departmentTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    //2.解析并显示分页信息
    function build_page_info(result) {
        //每次发送ajax请求先进行清空
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+result.map.pageInfo.pageNum+"页，总共"+
                                result.map.pageInfo.pages+"页，共"+result.map.pageInfo.total+"条记录");
        totalRecord = result.map.pageInfo.total;
        currentPage = result.map.pageInfo.pageNum;
    }

    //3.解析并显示分页条信息
    function build_page_nav(result) {
        //每次发送ajax请求先进行清空
        $("#page_nav_area").empty();
        //构建元素
        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
        if(!result.map.pageInfo.hasPreviousPage){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            //为元素添加点击翻页的事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.map.pageInfo.pageNum -1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(!result.map.pageInfo.hasNextPage){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else {
            nextPageLi.click(function () {
                to_page(result.map.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.map.pageInfo.pages);
            });
        }

        //添加首页和前一页地标签
        ul.append(firstPageLi).append(prePageLi);

        //遍历获取连续地页码并添加到 ul 中
        $.each(result.map.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
            if(result.map.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });

        //添加下一页和末页的标签
        ul.append(nextPageLi).append(lastPageLi);
        //创建nav标签
        var nav = $("<nav></nav>").append(ul).appendTo($("#page_nav_area"));
    }

    //清空表单数据及所有显示样式
    function reset_form(ele){
        //清空表单数据可以使用Dom对象的reset()方法
        $(ele)[0].reset();
        //清空所有样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        /*//查询部门之前先清空下拉列表的数据
        $("#empAddModal select").empty();
        //清空表单数据
        $("#empName_add_input").val("");
        $("#email_add_input").val("");*/

        //清空表单数据
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModal select");

        //弹出模态框
        $("#empAddModal").modal({
                backdrop:"static"
        });
    });

    //查询所有部门信息显示在下拉列表中
    function getDepts(ele) {
        //查询部门之前先清空下拉列表的数据
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success:function (result) {
                //显示部门信息在下拉列表中
                //$("#empAddModal select").append();
                $.each(result.map.depts,function () {
                    var optionElement = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    $(ele).append(optionElement);
                })
            }
        });
    }

    //表单数据格式校验
    function validate_add_form(){
        //1.拿到要校验的数据，使用正则表达式进行校验
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            // alert("用户名必须是4-16位的字母或者2-5位的汉字");
            show_validate_msg("#empName_add_input","error","用户名必须是4-16位的字母或者2-5位的汉字");
            return false;
        }else {
            show_validate_msg("#empName_add_input","success","");
        }

        //2.校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{3,10})$/;
        if(!regEmail.test(email)){
            // alert("邮箱格式不正确！");
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_add_input","success","");
        }
        return true;
    }

    //表单数据内容校验
    //给输入框注册变更事件校验用户名是否可用
    $("#empName_add_input").change(function () {
        //发送Ajax请求判断用户名是否可用
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkUser",
            data: "empName="+empName,
            type: "POST",
            success: function (result) {
                if(result.code==100){
                    show_validate_msg("#empName_add_input","success",result.map.validate_msg);
                    $("#emp_save_btn").attr("ajax-validate","success");
                }else{
                    show_validate_msg("#empName_add_input","error",result.map.validate_msg);
                    $("#emp_save_btn").attr("ajax-validate","error");
                }
            }
        });
    });

    //优化显示校验结果
    function show_validate_msg(ele, status,msg){
        //清楚当前元素的验证状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        //判断验证结果信息进行显示
        if(status == "success"){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if(status == "error"){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //给添加员工模块的新增按钮注册点击事件
    $("#emp_save_btn").click(function () {
        //1.先对填写的数据进行格式校验
        if(!validate_add_form()){
            return false;
        }
        //再对数据进行内容校验
        if($(this).attr("ajax-validate")=="error"){
            return false;
        }
        //3.发送Ajax请求将模态框中填写的数据提交到服务器进行保存
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                if(result.code == 100){
                    //关闭添加员工模块
                    $("#empAddModal").modal("hide");
                    //弹窗显示操作结果
                    alert(result.message);
                    //发送完Ajax请求后显示最后一页数据
                    to_page(totalRecord);
                }else {
                    //显示失败信息
                    if(undefined != result.map.errorFields.email){
                        show_validate_msg("#email_add_input","error",result.map.errorFields.email);
                    }
                    if(undefined != result.map.errorFields.empName){
                        show_validate_msg("#empName_add_input","error",result.map.errorFields.empName);
                    }
                }
            }
        });
    });


    //为删除按钮绑定点击事件
    $(document).on("click",".delete_btn",function () {
        //获取用户姓名
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("empId");
        //弹出确认删除对话框
        if(confirm("确认删除【"+ empName +"】吗？")){
            //确认之后发送Ajax请求进行删除
            $.ajax({
                url: "${APP_PATH}/emp/"+empId,
                type: "DELETE",
                success: function (result) {
                    //显示操作结果
                    alert(result.message);
                    //跳转到当前页
                    to_page(currentPage);
                }
            });
        }
    })


    //点击编辑按钮弹出修改模态框
    //这里是在按钮创建之前就绑定了click，所有绑不上
    //1)可以在按钮创建时绑定，但是耦合太高了。2)绑定点击.live()
    //jQuery新版没有live()方法，用on()代替
    $(document).on("click",".edit_btn",function () {
        //查询员工信息并显示
        getEmp($(this).attr("empId"));
        //将员工id传递给更新按钮
        $("#emp_update_btn").attr("empId", $(this).attr("empId"));
        //查询部门信息并显示
        getDepts("#empUpdateModal select");
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });

    //查询员工信息
    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/"+id,
            type: "GET",
            success: function (result) {
                var emp = result.map.employee;
                $("#emp_update_static").text(emp.empName);
                $("#email_update_input").val(emp.email);
                $("#empUpdateModal input[name=gender]").val([emp.gender]);
                $("#empUpdateModal select").val([emp.dId]);
            }
        });
    }

    //更新员工信息
    $("#emp_update_btn").click(function () {
        //1.验证邮箱格式是否正确
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{3,10})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_update_input","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_update_input","success","");
        }

        //2.发送ajax请求保存更新的员工数据
        $.ajax({
            url: "${APP_PATH}/emp/"+$(this).attr("empId"),
            type: "POST",
            data: $("#empUpdateModal form").serialize()+"&_method=PUT",
            success: function (result) {
                if(result.code == 100){
                    //关闭修改员工模块
                    $("#empUpdateModal").modal("hide");
                    //显示结果信息
                    alert(result.map.message);
                    //跳转到当前页面
                    to_page(currentPage);
                }
            }
        });
    });

    //完成全选/全不选
    $("#check_all").click(function () {
        //attr()获取checked是undefined，所有一般用attr()获取自定义的属性
        //可以使用prop()获取dom原生属性的值
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //check_item
    $(document).on("click",".check_item",function () {
        //判断当前选中的元素是否为5个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        //将上方的判断值赋给check_all复选框即可
        $("#check_all").prop("checked",flag);
    })

    //点击全部删除，批量删除用户
    $("#emp_delete_all_btn").click(function () {
        //保存选中的用户名
        var empNames = "";
        //保存选中的用户ID
        var empIDs = "";
        $.each($(".check_item:checked"),function () {
           empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
           empIDs += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除多余的逗号和"-"
        empNames = empNames.substring(0,empNames.length-1);
        empIDs = empIDs.substring(0,empNames.length-1);
        if(confirm("确认删除["+ empNames +"]吗？")){
            $.ajax({
                url: "${APP_PATH}/emp/"+empIDs,
                type: "DELETE",
                success: function (result) {
                    //显示结果信息
                    alert(result.message);
                    //跳转到当前页
                    to_page(currentPage);
                }
            });
        }
    });

</script>

</body>
</html>
