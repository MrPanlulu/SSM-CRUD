<%--
  Created by IntelliJ IDEA.
  User: 潘璐璐
  Date: 2022/9/25
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>123111111</title>

    <%
      pageContext.setAttribute("APP_PATH" , request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <!-- Bootstrap -->
    <link  href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" >
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" ></script>
    
</head>
<body>

<button class="btn btn-danger">按钮</button>
</body>
</html>
