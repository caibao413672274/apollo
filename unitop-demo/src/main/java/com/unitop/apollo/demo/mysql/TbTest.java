package com.unitop.apollo.demo.mysql;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name="tb_test")
public class TbTest {
    /**
     * Field: id <br/>
     * Doc: 
     */
    @Column(name = "id")
    private Integer id;

    /**
     * Field: name <br/>
     * Doc: 
     */
    @Column(name = "name")
    private String name;

    /**
     * Field: remark <br/>
     * Doc: 
     */
    @Column(name = "remark")
    private String remark;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    @Override
    public String toString() {
        return "TbTest{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }
}