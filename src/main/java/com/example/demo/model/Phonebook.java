package com.example.demo.model;

import org.hibernate.validator.constraints.Length;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * Class that defines the data model.
 *
 * @author fvilarinho
 */
@Entity(name = "phonebook")
public class Phonebook{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    
    @Length(max = 1000)
    private String name;
    private String phone;
    private String owner;
    
    public String getOwner(){
        return owner;
    }
    
    public void setOwner(String owner){
        this.owner = owner;
    }
    
    public String getName(){
        return name;
    }
    
    public void setName(String name){
        this.name = name;
    }
    
    public String getPhone(){
        return phone;
    }
    
    public void setPhone(String phone){
        this.phone = phone;
    }
    
    public void setId(Integer id){
        this.id = id;
    }
    
    @Id
    public Integer getId(){
        return id;
    }
}
