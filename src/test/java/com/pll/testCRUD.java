package com.pll;

import com.pll.dao.DepartmentMapper;
import com.pll.dao.EmployeeMapper;
import com.pll.pojo.Department;
import com.pll.pojo.Employee;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

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
//此注解可以指定为 springmvc的测试，具有自动注入的功能
// 1.引入依赖
// 2.指定配置文件的位置
// 3.在开头加入，RunWith注解，指定Test以SpringJunit的测试运行
// 4.在属性中添加需要的类或者接口，使用@AutoWrite注解使其自动注入
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class testCRUD {
    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Test
    public void testAdd(){
        //对部门的测试
        //System.out.println(departmentMapper);
        //departmentMapper.insertSelective(new Department(null,"研发部"));
        //departmentMapper.insert(new Department(null,"财务部"));


    }
    @Test
    public void testEmp(){
        //employeeMapper.insert(new Employee(null,"大潘","男","7878@qq.com",1));
        Employee employee = employeeMapper.selectByPrimaryKeyWithDepartment(1);
        System.out.println(employee);
//        for (int i = 0; i < 1000; i++) {
//            String uuid = UUID.randomUUID().toString().substring(0, 5) + i;
//            employeeMapper.insert(new Employee(null,uuid,"男",uuid+"@qq.com",1));
//        }
    }
}
