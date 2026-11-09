<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
    Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3307/bdwebia?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
            "root",
            ""
        );
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
    Connection conexion = getConnection();
    PreparedStatement ps = conexion.prepareStatement("SELECT * FROM tips ORDER BY id_tip");
    ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KUMON | Catálogo de Tips</title>
    <link rel="stylesheet" href="css/clean.css">
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f7f4f5;
            color: #1f1f1f;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }
        .catalogo-box {
            max-width: 1100px;
            margin: 30px auto;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
            padding: 25px;
        }
        h1 {
            text-align: center;
            color: #3a2a2a;
            margin-bottom: 20px;
        }
        .tip-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(220px, 1fr));
            gap: 22px;
        }
        .tip-card {
            background: #fff8f8;
            border: 1px solid #f2d7d8;
            border-radius: 12px;
            padding: 18px;
        }
        .badge {
            display: inline-block;
            background: #f5dfe4;
            color: #6a404a;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: bold;
        }
        .tip-card h3 {
            margin: 14px 0 10px;
            color: #2b1d1f;
            font-size: 22px;
        }
        .meta {
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            color: #66595c;
            margin-bottom: 12px;
        }
        .tip-card p {
            color: #4c4044;
            line-height: 1.7;
            margin-bottom: 12px;
        }
        .link-volver {
            display: inline-block;
            margin-top: 18px;
            color: #d65050;
            font-weight: bold;
            text-decoration: none;
        }
        @media (max-width: 768px) {
            .tip-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header id="header">
        <div class="container">
            <div class="row">
                <div class="col-md-9">
                    <div class="header-logo">
                        <h2>Centro de Educación Continua KUMON</h2>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="header-ctn">
                        <ul class="header-links">
                            <li><a href="index.html">Inicio</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <nav id="navigation">
        <div class="container">
            <ul class="main-nav">
                <li><a href="index.html">Inicio</a></li>
                <li><a href="catalogo.jsp">Catálogo</a></li>
                <li><a href="principal.jsp">Portal</a></li>
            </ul>
        </div>
    </nav>

    <div class="catalogo-box">
        <h1>Catálogo de Tips de IA Generativa</h1>
        <div class="tip-grid">
            <% while (rs.next()) { %>
            <div class="tip-card">
                <span class="badge"><%= rs.getString("categoria") %></span>
                <h3><%= rs.getString("titulo") %></h3>
                <div class="meta">
                    <span>ID: <%= rs.getInt("id_tip") %></span>
                    <span><%= rs.getString("nivel") %></span>
                </div>
                <p><%= rs.getString("descripcion") %></p>
                <div class="meta">
                    <span>Duración: <%= rs.getInt("duracion_min") %> min</span>
                </div>
            </div>
            <% } %>
        </div>
        <a class="link-volver" href="index.html">← Regresar al inicio</a>
    </div>
</body>
</html>
<%
    rs.close();
    ps.close();
    conexion.close();
%>
