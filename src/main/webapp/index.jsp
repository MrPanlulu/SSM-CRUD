<%--
  Created by IntelliJ IDEA.
  User: 潘璐璐
  Date: 2022/9/30
  Time: 16:38
  目前存在的无法解决的问题
  1. 数据库没有即使更新
  2. 页面展示，员工ID不连续的时候，无法正确判断是否有下一页

  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <html>
    <head>
        <title>员工列表</title>
        <%
            pageContext.setAttribute("APP_PATH", request.getContextPath());
        %>

        <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
        <!-- Bootstrap -->
        <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
              rel="stylesheet">
        <%--总结之前的失误， 1.没有在link添加 rel 这个属性，
                           2.并且路径找错，使用APP_PATH的时候没有引入jsp的依赖--%>
        <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    </head>
<body>

<!-- 动态模组框，跟点击修改按钮绑定 -->
<div id="emps_modify_model" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>

                <h4 class="modal-title" >员工信息</h4>
            </div>
            <div class="modal-body">
                <form  class="form-horizontal">
                    <input type="hidden" name="_method" value="PUT">
                    <input type="hidden" id="update_empId" name="empId" >

                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p id="empName_update" class="form-control-static" value="email@example.com"></p>
                        </div>
                    </div>


                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="modify_email" name="email" >
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">gender</label>
                            <label class="radio-inline ">
                                <input type="radio"   name="gender" value="男"  id="gender_M"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio"  name="gender" value="女" id="gender_W"  > 女
                            </label>
                        </div>


                    </div>
                    <div class="form-group" >
                        <select class="form-control" name="dId" id="emps_modify_depts">
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="modify_emp_bt" type="button" class="btn btn-primary">修改</button>
            </div>
        </div>
    </div>
</div>

<!-- 动态模组框，跟点击添加按钮绑定 -->
<div id="emps_add_model" class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加的员工信息</h4>
            </div>
            <div class="modal-body">

                <form  class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName" name="empName" placeholder="empName">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email" name="email" placeholder="email">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">gender</label>
                            <label class="radio-inline ">
                                <input type="radio"   name="gender" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio"  name="gender" value="女"   > 女
                            </label>
                        </div>


                    </div>
                    <div class="form-group" >
                        <select class="form-control" name="dId" id="emps_add_depts">

                        </select>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="add_emp_bt" type="button" class="btn btn-primary">添加</button>
            </div>
        </div>
    </div>
</div>

<%--开始搭建环境--%>
<div class="container">
    <%--标题显示--%>
    <div class="row">
        <h1 class="col-md-6">SSM-CRUD</h1>
    </div>

    <%--两个按钮--%>
    <div class="row">
        <div class="row col-md-4 col-md-offset-6">
            <button class="btn btn-primary" id="emps_add_button">新增</button>
            <button id="delAll_emp_btn" class="btn btn-danger">删除</button>
        </div>

    </div>

    <%--主要内容显示--%>
    <div class="row">
        <table class="table table-hover" id="emps_table">
            <thead>
            <tr>
                <th><input type="checkbox" id="del_all_emps_btn"/></th>
                <th>#</th>
                <th>empName</th>
                <th>gender</th>
                <th>email</th>
                <th>deptName</th>
                <th>option</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
    </table>
    </div>

    <%--底部显示--%>
    <div class="row">
        <div class="col-md-6" id="inf_area">

        </div>
        <div class="col-md-6" id="nav_area">

        </div>
    </div>
</div>

<script type="text/javascript">
   var allInfNums , currentPageNum;

    $(function () {
        to_page(1);
    });
    function to_page(pageNum) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pageNum=" + pageNum,
            type: "GET",
            success: function (result) {
                allInfNums = result.content.pageInf.total;
                currentPageNum = result.content.pageInf.pageNum;

                //加载员工详细信息
                build_emps_table(result);

                //加载导航页信息
                build_emps_inf(result);

                //加载导航分页信息
                build_emps_nav(result);
            }

        });
    }

   //自动查询部门信息,若放在函数内，则会随着每次查询，多出很多选项
   $(
       getDeptInf("#emps_modify_depts"),
       getDeptInf("#emps_add_depts")
   );

    //构建员工信息表格
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.content.pageInf.list;
        $.each(
            emps, function (index, emp) {
                // alert(emp.empName);
                //基本信息
                var checkbox = $("<td><input class = 'del_emps_checkbox' type='checkbox' /></td>");
                var empIdTB = $("<td></td>").append(emp.empId);
                var empNameTB = $("<td></td>").append(emp.empName);
                var genderTB = $("<td></td>").append(emp.gender);
                var emailTB = $("<td></td>").append(emp.email);
                var deptNameTB = $("<td></td>").append(emp.department.deptName);
                //按钮
                var modifyBT = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("修改");


                var delBT = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

                var btnTB = $("<td></td>").append(modifyBT).append(" ").append(delBT);

                //使以上添加在一起
                $("<tr></tr>")
                    .append(checkbox)
                    .append(empIdTB)
                    .append(empNameTB)
                    .append(genderTB)
                    .append(emailTB)
                    .append(deptNameTB)
                    .append(btnTB)
                    .appendTo("#emps_table tbody");
                //绑定，点击修改按钮弹出修改模组的对话框
                modifyBT.click(function (){
                    modify_emp(emp , result.content.pageInf.pageNum);
                });

                delBT.click(function () {
                    del_empById(emp.empId, emp.empName);
                });
            }
        );
    }

    //写一下点击头部的按钮所有选中或者不选中的逻辑
   $("#del_all_emps_btn").click(function (){
       //注意获取标签自带的内部属性可以使用 prop
       //先根据选中所有来选中所有
       var flage = $(this).prop("checked");
       $(".del_emps_checkbox").prop("checked",flage);

   });

    //绑定依次点击所有的之后，头部所有按钮选中
   $(document).on("click",".del_emps_checkbox",function () {
       //当选中所有元素之后，头部选中所有按钮选中
       //特别注意  $( : )这个冒号是筛选的意思
       var flage = $(".del_emps_checkbox:checked").length == $(".del_emps_checkbox").length ;
       $("#del_all_emps_btn").prop("checked",flage);

   })

   $("#delAll_emp_btn").click(function () {
       //具体的删除逻辑
       var delName = "";
       var delId = "";
       var checkedBtn = $(".del_emps_checkbox:checked");
       $.each(checkedBtn , function () {
           //名字用，拼接，id用-拼接
           delId   += $(this).parents("tr").find("td:eq(1)").text() + "-";
           delName += $(this).parents("tr").find("td:eq(2)").text() + ",";
       })
       delId = delId.substring(0,delId.length - 1);
       delName = delName.substring(0,delName.length - 1);
       // alert(delId);
       // alert(delName);
       if (confirm(delName)){
           $.ajax({
               url:"${APP_PATH}/emp/"+delId,
               type:"DELETE",
               success:function (result) {
                   alert("del success");
                   to_page(currentPageNum);


               }
           })
       }
   });

    // $(document).on("click",".edit_btn",function () {
    // 备选方案
    // });

    //点击修改按钮
    function del_empById(empId ,empName){
        if(confirm("确定要删除"+empName+"吗？点击确认删除")){
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function () {

                    to_page(currentPageNum);
                }
            });
        }else {
            to_page(currentPageNum);
        }





   }

    //点击修改员工信息框
    function modify_emp(emp , pageNum) {


        //绑定点击弹出模态框
        $("#emps_modify_model").modal({backdrop:"static"});
        $("#update_empId").attr("value",emp.empId);
        //给定表格默认值
        $("#empName_update").empty();
        $("#empName_update").append(emp.empName);
        $("#modify_email").val(emp.email);
        if (emp.gender == "男"){
            $("#gender_M").attr("checked","checked");
        }else {
            $("#gender_W").attr("checked","checked");
        }
        var ops = $("#emps_modify_depts option");
        $.each(ops , function () {
            this.removeAttribute("selected");
        });
        $("#"+emp.dId).attr("selected","selected");


    }

   //点击修改之后，去后端查询跳转
   $("#modify_emp_bt").click(function (){
       var email = $("#modify_email").val();
       var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;


           if (!regEmail.test(email)){
               checkOut("#modify_email" , "fail" , "邮箱格式不正确！");
               return false;

           }else {
               checkOut("#modify_email" , "success" , "");
               $.ajax({
                   url:"${APP_PATH}/emp",
                   type:"POST",
                   data:$("#emps_modify_model form").serialize(),
                   success:function (result) {
                       $("#emps_modify_model").modal('hide');
                       to_page(currentPageNum);
                   }
               });


           }




       }

   );

    //构建 inf_area 员工详细 的显示信息
    function build_emps_inf(result) {
        $("#inf_area").empty();
        $("#inf_area").append("当前第" +
            result.content.pageInf.pageNum + "页，共有" +
            result.content.pageInf.pages
            + "页，共有" +
            result.content.pageInf.total
            + "条记录");

    }

    //构建导航页码
    function build_emps_nav(result) {
        $("#nav_area").empty();
        //构建基本的导航页数
        var ULs = $("<ul></ul>").addClass("pagination");
         //首尾
        var firstNum = $("<li></li>").append($("<a></a>").attr("href", "#").append("首页"));
        var prePage = $("<li></li>").append($("<a></a>").attr("href", "#").append("&laquo;"));
        if (result.content.pageInf.hasPreviousPage == false) {
            firstNum.addClass("disabled");
            prePage.addClass("disabled");
        } else {
            firstNum.click(function () {
                to_page(1);
            });
            prePage.click(function () {
                to_page(result.content.pageInf.pageNum - 1);
            });
        }
        ULs.append(firstNum).append(prePage);
        $.each(
            result.content.pageInf.navigatepageNums, function (index, page_num) {
                var nowPage = $("<li></li>").append($("<a></a>").attr("href", "#").append(page_num));
                if (result.content.pageInf.pageNum == page_num) {
                    nowPage.addClass("active");
                }else {
                    nowPage.click(function () {
                        to_page(page_num);
                    });
                }
                ULs.append(nowPage);
            }
        );
        //最后两个
        var lastNum = $("<li></li>").append($("<a></a>").attr("href", "#").append("尾页"));
        var nextPage = $("<li></li>").append($("<a></a>").attr("href", "#").append("&raquo;"));
        if (result.content.pageInf.hasNextPage == false) {
            lastNum.addClass("disabled");
            nextPage.addClass("disabled");
        } else {
            lastNum.click(function () {
                to_page(result.content.pageInf.pages);
            });
            nextPage.click(function () {
                to_page(result.content.pageInf.pageNum + 1);
            });
        }
        ULs.append(nextPage).append(lastNum);
        //合并在一起
        $("<nav></nav>").append(ULs).appendTo("#nav_area");
    }


    //清除模组上的样式
   function deleteModal (){
       $("#emps_add_model form").get(0).reset();
       $("#emps_add_model form").find("*").removeClass("has-error has-success");
       $("#emps_add_model form").find(".help-block").text("");

   }

    //绑定打开模组事件
    $("#emps_add_button").click(function () {
        //0.清除之前预留的样式
        deleteModal ();
        //1.发送ajax请求，获取部门的信息
        //getDeptInf("#emps_add_depts");
        //2.绑定弹窗
        $("#emps_add_model").modal({backdrop:"static"});

        }
    )

    //发送异步请求获取部门信息（主要是部门ID）的函数
    function getDeptInf(element) {
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                //console(result);
                //{"code":100,"mes":"发送成功!","content":{"depts":[{"deptId":1,"deptName":"研发部"},{"deptId":2,"deptName":"行政部"},{"deptId":3,"deptName":"财务部"}]}}
                $.each(result.content.deptInf ,function () {
                    var opt = $("<option></option>").attr("value",this.deptId).attr("id",this.deptId).append(this.deptName);
                    $(element).append(opt);
                })
            }
        })

    }

    //绑定点击保存按钮，后台保存
    $("#add_emp_bt").click(
        function () {
            //1.检验名字，邮箱是否合理
            if (!check_Name_Email()){
                return false;
            }
            //2.发送异步请求，保存,在此需要判断按钮是否可点,
            //因为在此涉及到了，前后端同时检验。
            if ($("#add_emp_bt").attr("checkOut") == "fail"){
                return false;
            }
            $.ajax({
                url:"${APP_PATH}/emp",
                data:$("#emps_add_model form").serialize(),
                type:"POST",
                success:function (result) {
                    alert($("#emps_add_model form").serialize());
                    //3.关闭模组框
                    $("#emps_add_model").modal('hide');
                    //4.跳转到最后一页
                    to_page(allInfNums);
                }
            });

        }
    )

    //名称检查
    function check_Name_Email() {
        var empName =  $("#empName").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;

        var email = $("#email").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(regName.test(empName)){//成功
            checkOut("#empName" , "success" , "");
            //成功后继续检查邮箱,也成功则成功
            if (regEmail.test(email)){
                checkOut("#email" , "success" , "");
                return  true;
            }else {//失败则提示信息
                checkOut("#email" , "fail" , "邮箱格式不正确！");
                return false;
            }

        }else if (!regName.test(empName)) {//失败
            checkOut("#empName" , "fail" , "姓名输入有误！");
            return false;
        }
    }

    //根据检查结果改变样式
    function checkOut(element , sta , mes) {
        $(element).parent().removeClass("has-success  has-error");
        $(element).next("span").text("");
        if (sta == "success"){
            $(element).parent().addClass("has-success");
            $(element).next("span").append("");
        } else if (sta == "fail"){
            $(element).parent().addClass("has-error");
            $(element).next("span").append(mes);
        }


    }

    //当员工姓名 输入文本框发生改变的时候，发生Ajax请求，去数据库查询是否重名
   $("#empName").change(function () {
       $.ajax({
           url:"${APP_PATH}/checkEmpName",
           data:"empName="+this.value,
           type:"POST",
           success:function (rseult) {
               if (rseult.code == 100){
                   checkOut("#empName" , "success" , "");
                   $("#add_emp_bt").attr("checkOut","success");
               }else {
                   checkOut("#empName" , "fail" , rseult.content.fail_Mes);
                   $("#add_emp_bt").attr("checkOut","fail");
               }
           }
       })

   })

</script>
</body>
</html>
