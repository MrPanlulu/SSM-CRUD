package com.pll.controll;

import com.pll.pojo.Department;
import com.pll.pojo.Mes;
import com.pll.service.deptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
public class deptControll {
    @Autowired
    private deptService deptService;


    @ResponseBody
    @RequestMapping("/depts")
    public Mes getDeptInf(){
        List<Department> list = deptService.getAllDepts();
        return Mes.success().add("deptInf",list);
    }
}
