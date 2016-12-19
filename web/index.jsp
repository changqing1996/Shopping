<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="db.PoolConn" %><%--
  Created by IntelliJ IDEA.
  User: 28713
  Date: 2016/12/9
  Time: 22:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>快乐购物</title>
    <link rel="stylesheet" href="css/good.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/scroll.css">
</head>
<body>
<header>
<%
    session = request.getSession();
    String Email = (String) session.getAttribute("Email");
    if (Email == null) {
%>
<a href="login.html">请登录</a>&nbsp;&nbsp;<a href="register.html">请注册</a>
<%
} else {
%>
欢迎您<a href="user_center.jsp"><%=Email%></a>
<%
    }
%>
</header>
<section id="nav">
    <ul>
        <li><a href="index.html">首页</a></li>
        <li><a href="#">所有商品</a></li>
        <li><a href="#">购物车</a></li>
        <li><a href="#">我的订单</a></li>
        <li><a href="user_center.jsp">个人中心</a></li>
    </ul>
</section>
<div class="box">
    <ul class="list">
        <li><a href="good.html?gid=1"><img class="slide" src="images/s1.jpg" height="450"/></a></li>
        <li><a href="good.html?gid=2"><img class="slide" src="images/s2.jpg" height="450"/></a></li>
        <li><a href="good.html?gid=3"><img class="slide" src="images/s3.jpg" height="450"/></a></li>
        <li><a href="good.html?gid=4"><img class="slide" src="images/s4.jpg" height="450"/></a></li>
    </ul>
    <div class="index">
        <a href="javascript:" class="index_1">1</a>
        <a href="javascript:" class="index_2">2</a>
        <a href="javascript:" class="index_3">3</a>
        <a href="javascript:" class="index_4">4</a>
    </div>
</div>
<section id="good">
    <%
        String sql = "SELECT gid,gname,price FROM good LIMIT 0,5";
        PoolConn poolConn = PoolConn.getPoolConn();
        try (Connection conn = poolConn.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()
        ) {
            for (int i = 0; i < 2; i++) {
    %>
    <ul id="ul<%=i+1%>">
        <%
            for (int j = 0; j < 5; j++) {
                resultSet.next();
                String gid = resultSet.getString(1);
        %>
        <li id="li<%=i*5+j+1%>">
            <div class="dimage"><a href="good.html?gid=<%=gid%>">
                <img class="gimage" src="images/<%=gid%>.jpg" alt="图片">
            </a></div>
            <a class="gname" href="good.html?gid=<%=gid%>"><%=resultSet.getString(2)%></a>
            <p class="price" id="goods<%=i*3+j+1%>">￥<%=resultSet.getFloat(3)%></p>
        </li>
        <%
            }
        %>
    </ul>
<%
            break;
        }
%>
</section>
<footer id="page_footer">
    <p>Copyrights &copy; 2016 AweseomeCo.</p>
    <nav>
        <ul>
            <li><a href="#">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Terms of Service</a></li>
            <li><a href="#">Privacy</a></li>
        </ul>
    </nav>
</footer>
<%
poolConn.returnConnection(conn);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
</body>
</html>
