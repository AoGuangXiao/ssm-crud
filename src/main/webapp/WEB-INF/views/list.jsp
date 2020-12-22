<%--
  Created by IntelliJ IDEA.
  User: 敖尼玛112
  Date: 2020/12/17
  Time: 20:26
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
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
        <br/>
        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>Email</th>
                        <th>部门名称</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <td>${emp.empId}</td>
                            <td>${emp.empName}</td>
                            <td>${emp.gender=="m"?"男":"女"}</td>
                            <td>${emp.email}</td>
                            <td>${emp.department.deptName}</td>
                            <td>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 编辑
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>

        <!-- 显示分页信息 -->
        <div class="row">
            <!-- 分页文字信息 -->
            <div class="col-md-6">
                当前${pageInfo.pageNum}页，总共${pageInfo.pages}页，共${pageInfo.total}条记录
            </div>
            <!-- 分页条信息 -->
            <div class="col-md-6 col-md-offset-8">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li>
                            <a href="${APP_PATH}/emps?pn=1" aria-label="Previous">首页</a>
                        </li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                            <c:if test="${page_num == pageInfo.pageNum}">
                                <li class="active"><a href="#">${page_num}</a></li>
                            </c:if>
                            <c:if test="${page_num != pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?pn=${page_num}">${page_num}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pages}" aria-label="Previous">末页</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
