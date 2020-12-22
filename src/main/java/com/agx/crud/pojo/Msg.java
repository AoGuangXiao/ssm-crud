package com.agx.crud.pojo;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回的类：由于需要使用Ajax访问服务器并返回json，所以创建该类用于封装返回信息
 */
public class Msg {
    //状态码，自定义为：100-success，200-fail
    private Integer code;

    //返回信息
    private String message;

    //返回的数据
    private Map<String, Object> map = new HashMap<String,Object>();

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getMap() {
        return map;
    }

    public void setMap(Map<String, Object> map) {
        this.map = map;
    }


    //操作成功
    public static Msg success(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMessage("操作成功");
        return result;
    }

    //操作失败
    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMessage("操作失败");
        return result;
    }

    //定义该方法可以进行链式操作(例如：Msg.success().add("1",2).add("3",4).add("5",6);链式地往Map中添加数据)
    public Msg add(String key, Object value){
        this.getMap().put(key, value);
        return this;
    }

}
