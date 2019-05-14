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

    <title>New Transaction</title>

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
    function doAjax(inputText) {
        $.ajax({
            url : 'getItemData',
            type: 'GET',
            dataType: 'json',
            contentType: 'application/json',
            mimeType: 'application/json',
            data : ({
                text: inputText
            }),
            error: function() {
                $('#itemid').text(" ");
                $('#itemname').text(" ");
                $('#itemunicode1').text(" ");
                $('#itemprice').text(" ");
                $('#itemamount1').text(" ");
            },
            success: function (data) {
                console.log(data);
                if(data) {
                    $('#itemid').text(data.id);
                    $('#itemname').text(data.name);
                    $('#itemunicode1').text(data.universalProductCode);
                    $('#itemprice').text(data.price);
                    $('#itemamount1').text(data.amounts);
                    $("#itemamount").attr({
                        "max" : data.amounts,
                        "min" : 1
                    });

                }

            }
        });
    }
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
                <li class="active">
                    <a href="newtransaction">
                        <i class="ti-bag"></i>
                        <p>New Transaction</p>
                    </a>
                </li>
                <li>
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
                    <a class="navbar-brand" href="#">New Transaction</a>
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
                                <h4 class="title">New Transaction</h4>
                                <p class="category"><%out.print(user.getRole().getName() + ": " + user.getName());%></p>
                            </div>
                            <div class="content">
                                <form action="sellnewproduct" method="post">
                                <table class="table table-striped">
                                    <thead>
                                        <th>Amount</th>
                                        <th>Universal Product Code</th>
                                        <th>Submit</th>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td><input required value="1" id ="itemamount" name="itemamount" type="number" class="form-control border-input" placeholder="User name"></td>
                                        <td><input required id="itemunicode" onkeyup="doAjax(this.value)" name="unicode" type="number" max="9999999999" class="form-control border-input" placeholder="User name"></td>
                                        <td><button id="addtransaction" type="submit" class="btn btn-info btn-fill btn-wd">Add Transaction</button></td>
                                    </tr>
                                    </tbody>
                                </table>
                                </form>

                                <table class="table table-striped">
                                    <thead>
                                    <th>Item ID</th>
                                    <th>Name</th>
                                    <th>Universal Product Code</th>
                                    <th>Price</th>
                                    <th>Aviable Amount</th>
                                    </thead>
                                    <tr>
                                        <td><span id="itemid"></span></td>
                                        <td><span id="itemname"></span></td>
                                        <td><span id="itemunicode1"></span></td>
                                        <td><span id="itemprice"></span></td>
                                        <td><span id="itemamount1"></span></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>



                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Transaction History</h4>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table id ="myTable" class="table table-striped">
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

</body>

<!--   Core JS Files   -->

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
