package com.example.demo.service;

import com.example.demo.model.Phonebook;
import com.example.demo.persistence.PhonebookPersistence;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PhonebookService{
    @Autowired
    private PhonebookPersistence persistence;
    
    public Phonebook findById(Integer id){
        return persistence.findById(id).get();
    }
    
    public List<Phonebook> findByName(String name){
        return persistence.findByName(name);
    }
    
    public List<Phonebook> findByNameContaining(String name){
        return persistence.findByNameContaining(name);
    }
    
    public void save(Phonebook phonebook){
        persistence.save(phonebook);
    }
    
    public void deleteById(Integer id){
        persistence.deleteById(id);
    }
    
    public void delete(Phonebook phonebook) { persistence.delete(phonebook);}
}