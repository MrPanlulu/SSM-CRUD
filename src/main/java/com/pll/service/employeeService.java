package com.pll.service;

import com.pll.dao.EmployeeMapper;
import com.pll.pojo.Employee;
import com.pll.pojo.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
@Service
public class employeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    //查询所有的员工数据
    public List<Employee> getAll(){
        List<Employee> employees = employeeMapper.selectByExampleWithDepartment(null);
        return employees;
    }

    public void addEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public boolean checkEmpName(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        employeeExample.createCriteria().andEmpNameEqualTo(empName);
        long l = employeeMapper.countByExample(employeeExample);
        return l == 0;
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public Employee getEmpByID(Integer empId) {
        Employee employee = employeeMapper.selectByPrimaryKeyWithDepartment(empId);
        return employee;
    }

    public void delEmpByID(Integer empId) {
        employeeMapper.deleteByPrimaryKey(empId);
    }

    public void delBanch(List<Integer> list) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andDIdIn(list);

        employeeMapper.deleteByExample(employeeExample);
    }
}
