<%@ page import="com.supermarket.models.Users" %>
<%@ page import="java.util.List" %>
<%@ page import="com.supermarket.models.Items" %>
<%@ page import="java.util.stream.Stream" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="com.supermarket.models.TransactionHistory" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/resources/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath}/resources/assets/img/favicon.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Transaction History</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />

    <!-- Bootstrap core CSS     -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/paper-dashboard.css" rel="stylesheet"/>

    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/demo.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet" />
    <link href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" rel="stylesheet">
    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="${pageContext.request.contextPath}/resources/assets/css/themify-icons.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/assets/js/jquery-1.10.2.js" type="text/javascript"></script>
</head>
<body>
<%
    Users user = (Users)session.getAttribute("userData");
    List<TransactionHistory> historyList = null;
    if(null != request.getAttribute("historyList")){
        historyList = (List<TransactionHistory>)request.getAttribute("historyList");
    }
%>


<script>

</script>

<div class="wrapper">
    <div class="sidebar" data-background-color="white" data-active-color="danger">

        <!--
            Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
            Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
        -->

        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="/profile" class="simple-text">
                    Supermarket
                </a>
            </div>

            <ul class="nav">
                <li>
                    <a href="profile">
                        <i class="ti-user"></i>
                        <p>User Profile</p>
                    </a>
                </li>
                <%if(user.getRole().getName().equals("ADMIN")){%>
                    <li>
                        <a href="loaditems">
                            <i class="ti-view-list-alt"></i>
                            <p>Items</p>
                        </a>
                    </li>
                    <li>
                        <a href="profile">
                            <i class="ti-id-badge"></i>
                            <p>Cashiers</p>
                        </a>
                    </li>
                <%}else{%>
                    <li>
                        <a href="newtransaction">
                            <i class="ti-bag"></i>
                            <p>New Transaction</p>
                        </a>
                    </li>
                <%}%>
                <li class="active">
                    <a href="transactionhistory">
                        <i class="ti-write"></i>
                        <p>Transaction History</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <div class="main-panel">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar bar1"></span>
                        <span class="icon-bar bar2"></span>
                        <span class="icon-bar bar3"></span>
                    </button>
                    <a class="navbar-brand" href="#">Transaction History</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="logout">
                                <i class="ti-settings"></i>
                                <p>Logout</p>
                            </a>
                        </li>
                    </ul>

                </div>
            </div>
        </nav>



        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Transaction History</h4>
                                <p class="category"><%if(user.getRole().getName().equals("CASHIER"))out.print("ID:"+user.getId() +" Name: "+ user.getName());%></p>

                            </div>
                            <div class="content table-responsive table-full-width">
                                <table id="myTable" class="table table-striped">
                                    <thead>
                                    <th>ID</th>
                                    <th>Item ID</th>
                                    <th>Amount</th>
                                    <th title="Sorted by time (ORDER BY desc)">Time</th>
                                    <th>Cashier ID</th>
                                    <th>Total Cost</th>
                                    </thead>
                                    <tbody>
                                    <%
                                        if(historyList!=null){
                                            for(TransactionHistory t: historyList){
                                    %>
                                    <tr>
                                        <td><%out.print(t.getId());%></td>
                                        <td title="<%out.print(t.getItemId().getName());%>"><%out.print(t.getItemId().getId());%></td>
                                        <td><%out.print(t.getAmount());%></td>
                                        <td><%out.print(t.getTransactionTime());%></td>
                                        <td title="<%out.print(t.getUsers().getName());%>"><%out.print(t.getUsers().getId());%></td>
                                        <td><%out.print(t.getItemId().getPrice()*t.getAmount());%> Tenge</td>
                                    </tr>

                                    <%
                                            }
                                        }
                                    %>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <footer class="footer">
            <div class="container-fluid">
                <div class="copyright pull-center">
                    &copy; <script>document.write(new Date().getFullYear())</script>, made by <a href="https://vk.com/richaidos">Baktaev Aidos</a>
                </div>
            </div>
        </footer>

    </div>
</div>

<script>
    $(document).ready(function(){
        $('#myTable').DataTable();

    });
</script>
</body>

<!--   Core JS Files   -->
<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-checkbox-radio.js"></script>

<!--  Charts Plugin -->
<script src="${pageContext.request.contextPath}/resources/assets/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-notify.js"></script>

<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

<!-- Paper Dashboard Core javascript and methods for Demo purpose -->
<script src="${pageContext.request.contextPath}/resources/assets/js/paper-dashboard.js"></script>

<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
<script src="${pageContext.request.contextPath}/resources/assets/js/demo.js"></script>

</html>
