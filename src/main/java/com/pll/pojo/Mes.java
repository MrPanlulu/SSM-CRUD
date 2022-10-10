package com.pll.pojo;

import java.util.HashMap;
import java.util.Map;

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
public class Mes {
    //状态提示码： 100-表示成功 200-表示失败
    private int code;

    //信息提示
    private String mes;


    //数据存放源
    Map<String , Object> content = new HashMap<String, Object>();


    //数据发送成功的方法，内部代理
    public static Mes success(){
        Mes mes = new Mes();
        mes.setCode(100);
        mes.setMes("发送成功!");
        return mes;
    }

    //失败的返回方法
    //数据发送成功的方法，内部代理
    public static Mes fail(){
        Mes mes = new Mes();
        mes.setCode(200);
        mes.setMes("发送失败!");
        return mes;
    }


    public Mes add(String key , Object value){
        this.getContent().put(key, value);
        return this;
    }

    public Mes() {
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMes() {
        return mes;
    }

    public void setMes(String mes) {
        this.mes = mes;
    }

    public Map<String, Object> getContent() {
        return content;
    }

    public void setContent(Map<String, Object> content) {
        this.content = content;
    }
}
