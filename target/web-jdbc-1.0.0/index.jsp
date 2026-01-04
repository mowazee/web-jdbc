<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// Redirect root requests to /home so HomeController handles initial load
response.sendRedirect(request.getContextPath() + "/home");
%>