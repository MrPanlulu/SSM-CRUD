package com.pll.controll;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pll.pojo.Employee;
import com.pll.pojo.Mes;
import com.pll.service.employeeService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 潘璐璐
 * @version 1.0
 * Questoion1
 * Questoion2
 * Questoion3
 * Questoion4
 * summary1
 * summary2
 * summary3
 * summary4
 * summary5
 */
@Controller
public class employeeControll {
    @Autowired
    private employeeService  employeeService;


    @RequestMapping("/checkEmpName")
    @ResponseBody
    public Mes checkEmpName(@Param("empName") String empName){
        //先使用正则表达式判断
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";



        if (!empName.matches(regx)){
            return Mes.fail().add("fail_Mes","用户名不合法！");
        }


        boolean b = employeeService.checkEmpName(empName);
        if (b){
            return Mes.success();
        }else {
            return Mes.fail().add("fail_Mes","用户名已存在！");
        }
    }

    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Mes addNewEmp(Employee employee){
        System.out.println(employee);
        employeeService.addEmp(employee);
        return Mes.success();
    }


    //修改员工信息
    @RequestMapping(value = "/emp",method = RequestMethod.PUT)
    @ResponseBody
    public Mes updateNewEmp(Employee employee){

        employeeService.updateEmp(employee);
        return Mes.success();
    }


    @RequestMapping(value = "/emp/{empId}" , method = RequestMethod.GET)
    @ResponseBody
    public Mes getEmpByID(@PathVariable("empId") Integer empId){
        Employee employee = employeeService.getEmpByID(empId);
        return Mes.success().add("emp",employee);
    }


    @RequestMapping(value = "/emp/{empIds}" , method = RequestMethod.DELETE)
    @ResponseBody
    public Mes delEmpByID(@PathVariable("empIds") String empIds){
        if (empIds.contains("-")){
            List<Integer> list = new ArrayList<Integer>();
            String[] split = empIds.split("-");
            for (String id :split) {
                list.add(Integer.parseInt(id));
            }
            employeeService.delBanch(list);
        }else {
            Integer empId = Integer.parseInt(empIds);
            employeeService.delEmpByID(empId);
        }



        return Mes.success();
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Mes getAllEmpWithJASON(@RequestParam(value = "pageNum" ,defaultValue="1"  )  Integer pageNum ){
        //引入分页查询的功能
        PageHelper.startPage(pageNum,5);
        List<Employee> list = employeeService.getAll();
        //这个类，维护了查询数据的所有详细信息，注意构造器中可以传入一你想要显示的导航页数
        PageInfo<Object> objectPageInfo = new PageInfo(list , 5);
        return Mes.success().add("pageInf",objectPageInfo);

    }


    //@RequestMapping("/emps")
    public String getAllEmp(@RequestParam(value = "pageNum" ,defaultValue="1"  )  Integer pageNum , Model model){
        //引入分页查询的功能
        PageHelper.startPage(pageNum,5);
        List<Employee> list = employeeService.getAll();
        //这个类，维护了查询数据的所有详细信息，注意构造器中可以传入一你想要显示的导航页数
        PageInfo<Object> objectPageInfo = new PageInfo(list , 5);
        model.addAttribute("pageInf",objectPageInfo);

        System.out.println(objectPageInfo.getSize());
        return "list";
    }
}
