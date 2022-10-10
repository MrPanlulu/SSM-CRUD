package com.pll.service;

import com.pll.dao.DepartmentMapper;
import com.pll.pojo.Department;
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
public class deptService {
    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getAllDepts(){
        return departmentMapper.selectByExample(null);
    }

}
