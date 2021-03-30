<%--
  Created by IntelliJ IDEA.
  User: fvilarinho
  Date: 29/03/21
  Time: 19:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <jsp:include page="header.jsp"/>
</head>
<body>
    <div class="form-control">
        <jsp:include page="title.jsp"/>
        <form action="search" method="POST">
            <jsp:include page="filter.jsp"/>
            <jsp:include page="grid.jsp"/>
            <br/>
            <small id="permissionDeniedHelp" class="form-text text-muted">${permissionDeniedMessage}</small>
        </form>
    </div>
</body>
</html>
