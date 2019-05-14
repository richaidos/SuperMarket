<%@ page import="com.supermarket.models.Users" %>
<%@ page import="java.util.List" %>
<%@ page import="com.supermarket.models.Items" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/resources/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath}/resources/assets/img/favicon.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Items</title>

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
    List<Items> itemsList = null;
    if(null != request.getAttribute("itemsList")){
        itemsList = (List<Items>)request.getAttribute("itemsList");
    }
%>


<script>

    function hide1() {
        if($("#edit-item-form").hasClass("is-active")){
            $('#edit-item-form').removeClass('is-active');
        }
    }

    function checkaddItemStatus() {
        if($("#add-item-content").hasClass("is-active")){
            $('#add-item-content').removeClass('is-active');
            $("#statusicon").css({ WebkitTransform: 'rotate(' + 0 + 'deg)'});
        }else{
            $('#add-item-content').addClass('is-active');
            $("#statusicon").css({ WebkitTransform: 'rotate(' + 45 + 'deg)'});
        }
    }


    function doAjax(inputText) {
        $('#edit-item-form').addClass('is-active');
        $.ajax({
            url : 'getItemData',
            type: 'GET',
            dataType: 'json',
            contentType: 'application/json',
            mimeType: 'application/json',
            data : ({
                text: inputText
            }),
            success: function (data) {
                console.log(data);

                $('#itemeditid').val(data.id);
                $('#itemeditname').val(data.name);
                $('#itemeditunicode').val(data.universalProductCode);
                $('#itemeditprice').val(data.price);
                $('#itemeditamount').val(data.amounts);

            }
        });
    }
</script>
<script>
    function max10(d){
        if(window.event)
        {
            if(event.keyCode == 37 || event.keyCode == 39) return;
        }
        d.value = d.value.replace(/\D/g,'');
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
                    <a class="navbar-brand" href="#">Items</a>
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
                                <h4 class="title">Operations</h4>
                                <p>
                                    Push + button for add
                                </p>
                            </div>
                            <div id="add-item-content" class="content add-item-content">
                                <h4 class="title">Add new Item</h4>
                                <form action="addnewitem" method="post">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>Item Name</label>
                                                <input required name="itemname" type="text" class="form-control border-input" placeholder="Name">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Universal Product Code</label>
                                                <input required id="itemncode" type="text" onkeydown="max10(this)"  name="itemncode" maxlength="9" class="form-control border-input" placeholder="Universal Product Code">

                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>Item Price</label>
                                                <input required name="itemprice" step="0.1" type="number"  class="form-control border-input" placeholder="Price">
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>Item Amounts</label>
                                                <input required name="itemamounts" type="number" class="form-control border-input" placeholder="Amounts">
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>Submit</label>
                                                <button type="submit" class="btn btn-info btn-fill btn-wd">Add New Item</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <div id="edit-item-form" class="content edit-item-form">
                                <h4 class="title">Edit Item
                                    <span id="statusicon1" class="pull-right">
                                        <i class="fa fa-times" onclick="hide1()"></i>
                                    </span>
                                </h4>
                                <form action="updateitem" method="post">
                                    <div class="row">
                                        <div class="col-md-1">
                                            <div class="form-group">
                                                <label>ID</label>
                                                <input id="itemeditid" style="pointer-events: none;" name="itemid" type="text" class="form-control border-input" placeholder="ID">
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>Item Name</label>
                                                <input id="itemeditname" name="itemname" type="text" class="form-control border-input" placeholder="Name">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Universal Product Code</label>
                                                <input id="itemeditunicode" disabled name="itemncode" type="number" class="form-control border-input" placeholder="Universal Product Code">
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>Item Price</label>
                                                <input id="itemeditprice" name="itemprice" type="number" step="0.1" class="form-control border-input" placeholder="Price">
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>Item Amounts</label>
                                                <input id="itemeditamount" name="itemamounts" type="number" class="form-control border-input" placeholder="Amounts">
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>Submit</label>
                                                <button type="submit" class="btn btn-info btn-fill btn-wd">Edit Item</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Items List
                                    <span id="statusicon" class="pull-right">
                                        <i class="ti-plus" title="Push + button for add or push x button for close." onclick="checkaddItemStatus()"></i>
                                    </span>
                                </h4>
                                <p class="category">Total items amount: <%out.print(itemsList.size());%></p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table id="myTable" class="table table-striped">
                                    <thead>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Universal Product Code</th>
                                    <th>Price</th>
                                    <th>Amounts</th>
                                    <th>Total Price</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                    </thead>
                                    <tbody>
                                    <%
                                        if(itemsList!=null){
                                            for(Items item: itemsList){
                                    %>
                                    <tr>
                                        <td><%out.print(item.getId());%></td>
                                        <td><%out.print(item.getName());%></td>
                                        <td><%out.print(item.getUniversalProductCode());%></td>
                                        <td><%out.print(item.getPrice());%> Tenge</td>
                                        <td><%out.print(item.getAmounts());%></td>
                                        <td><%out.print(item.getPrice() * item.getAmounts());%> Tenge</td>
                                        <td> <button onclick="doAjax(<%out.print(item.getUniversalProductCode());%>)" class="btn btn-sm btn-success btn-icon"><i class="fa fa-pencil-square-o"></i></button></td>
                                        <td><form class="cashersform" action="deleteitem" method="get" onsubmit="return confirm('Do you really want to submit the form?');">
                                            <input type="hidden" name="deleteid" value="<%out.print(item.getId());%>">
                                            <button type="submit" class="btn btn-sm btn-success btn-icon"><i class="fa fa-times"></i></button>
                                        </form></td>
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

                    <div id="addcashierform" class="col-lg-8 col-md-7 add-cashier-form">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Add New Cashier</h4>
                            </div>
                            <div class="content">
                                <form action="addnewcashier" method="post">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Login</label>
                                                <input required type="text" name="login" class="form-control border-input" placeholder="Login">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>User name</label>
                                                <input required name="username" type="text" class="form-control border-input" placeholder="User name">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Password</label>
                                                <input required name="password" type="password" class="form-control border-input" placeholder="New Password">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-info btn-fill btn-wd">Add Cashier</button>
                                    </div>
                                    <div class="clearfix"></div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div id="add-cashier-form-update" class="col-lg-8 col-md-7 add-cashier-form-update">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Edit Cashier Profile
                                    <span id="cachierstatusicon1" class="pull-right">
                                        <i class="fa fa-times" onclick="hide1()"></i>
                                    </span>
                                </h4>
                            </div>
                            <div class="content">
                                <form action="editprofile2" method="post">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>ID</label>
                                                <input id="idcashier" disabled name="userid" type="text" class="form-control border-input" placeholder="ID">
                                                <input id="idcashier2" name="myuserid" type="hidden" placeholder="ID">
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>Role</label>
                                                <input id="rolecashier" type="text" class="form-control border-input" disabled placeholder="Role">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Login</label>
                                                <input id="logincashier" type="text" name="login" class="form-control border-input" placeholder="Login">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>User name</label>
                                                <input id="usernamecashier" name="username" type="text" class="form-control border-input" placeholder="User name">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>New Password</label>
                                                <input id="newpasswordcashier" onkeyup="doCheck2()" name="newpassword" id="password1" type="password" class="form-control border-input" placeholder="New Password">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Conform Password</label>
                                                <input id="conformpasswordcashier" onkeyup="doCheck2()" name="confirm_password" id="confirm_password1" type="password" class="form-control border-input" placeholder="Conform Password">
                                            </div>
                                            <span id="message1"></span>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <button id="updatebutton1" type="submit" class="btn btn-info btn-fill btn-wd">Update Cashier Profile</button>
                                    </div>
                                    <div class="clearfix"></div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <%--<div class="col-lg-8 col-md-7">--%>
                        <%--<div class="card">--%>
                            <%--<div class="header">--%>
                                <%--<h4 class="title">Actions</h4>--%>
                            <%--</div>--%>
                            <%--<div class="content">--%>
                                <%--<p>Here must be links</p>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
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
