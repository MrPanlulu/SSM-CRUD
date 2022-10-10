<%--
  Created by IntelliJ IDEA.
  User: 潘璐璐
  Date: 2022/9/30
  Time: 16:38
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<html>
<head>
    <title>员工列表</title>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
        <!-- Bootstrap -->
    <link  href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
           rel="stylesheet" >
    <%--总结之前的失误， 1.没有在link添加 rel 这个属性，
                       2.并且路径找错，使用APP_PATH的时候没有引入jsp的依赖--%>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" ></script>

</head>
<body>
<%--开始搭建环境--%>
<div class="container">
    <%--标题显示--%>
    <div class="row">
        <h1 class="col-md-6">SSM-CRUD</h1>
    </div>

    <%--两个按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-9">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger" >删除</button>
        </div>

    </div>

    <%--主要内容显示--%>
    <div class="row">
        <table class="table table-hover">
            <tr>
                <th>#</th>
                <th>empName</th>
                <th>gender</th>
                <th>deptName</th>
                <th>option</th>
            </tr>
            <c:forEach items="${pageInf.list}" var="emp">
                <tr>
                    <td>${emp.empId}</td>
                    <td>${emp.empName}</td>
                    <td>${emp.gender}</td>
                    <td>${emp.department.deptName}</td>
                    <td>
                        <button class="btn btn-primary btn-sm">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            修改
                        </button>
                        <button class="btn btn-danger btn-sm" >
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                            删除
                        </button>
                    </td>
                </tr>
            </c:forEach>

        </table>
    </div>

    <%--底部显示--%>
    <div class="row">
        <div class="row">
            当前第${pageInf.pageNum}页，共有${pageInf.pages}页，共有${pageInf.total}条记录
        </div>
        <div class="row col-md-6 col-md-offset-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/emps?pageNum=1">首页</a></li>
                    <c:if test="${pageInf.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pageNum=${pageInf.pageNum - 1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach items="${pageInf.navigatepageNums}" var="nowPage">
                        <c:if test="${pageInf.pageNum == nowPage}">
                            <li class="active"><a href="${APP_PATH}/emps?pageNum=${nowPage}">${nowPage}</a></li>
                        </c:if>

                        <c:if test="${pageInf.pageNum != nowPage}">
                            <li><a href="${APP_PATH}/emps?pageNum=${nowPage}">${nowPage}</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${pageInf.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pageNum=${pageInf.pageNum + 1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <li><a href="${APP_PATH}/emps?pageNum=${pageInf.pages}">尾页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
