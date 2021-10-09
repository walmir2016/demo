package br.com.demo.service;

import br.com.demo.exceptions.PhonebookAlreadyExistsException;
import br.com.demo.exceptions.PhonebookNotFoundException;
import br.com.demo.persistence.PhonebookPersistence;
import br.com.demo.model.Phonebook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * Class that defines the services with the business rules.
 *
 * @author fvilarinho
 */
@Service
public class PhonebookService{
    @Autowired
    private PhonebookPersistence persistence;
    
    public PhonebookService(){
        super();
    }
    
    public PhonebookService(PhonebookPersistence persistence){
        this();
        
        this.persistence = persistence;
    }
    
    // List all data.
    public List<Phonebook> list(){
        return persistence.findAll();
    }
    
    // Find a phonebook by id.
    public Phonebook findById(Integer id) throws PhonebookNotFoundException{
        try{
            Optional<Phonebook> result = persistence.findById(id);
    
            if(result.isPresent())
                return result.get();
    
            throw new PhonebookNotFoundException();
        }
        catch(IllegalArgumentException e){
            throw new PhonebookNotFoundException();
        }
    }
    
    // Find a phonebook by name.
    public List<Phonebook> findByName(String name) { return persistence.findByName(name); }
    
    // Find a phonebook that contains a part of the name.
    public List<Phonebook> findByNameContaining(String name){
        return persistence.findByNameContaining(name);
    }
    
    // Save a phonebook.
    public Phonebook save(Phonebook phonebook) throws PhonebookAlreadyExistsException, PhonebookNotFoundException{
        if(phonebook != null){
            Integer value = (int)(Math.random() * 100);
            Integer id = phonebook.getId();
            String name = phonebook.getName();
            List<Phonebook> list = persistence.findByName(phonebook.getName());
            
            if(id == null || id == 0){
                if(list != null && !list.isEmpty())
                    throw new PhonebookAlreadyExistsException();
            }
            else{
                if(list != null){
                    Optional<Phonebook> result = list.stream().filter(i -> !i.getId().equals(id) && i.getName().equals(name)).findFirst();
    
                    if(!result.isEmpty())
            throw new PhonebookAlreadyExistsException();
        }
            }
    
            return persistence.save(phonebook);
        }
    
        throw new PhonebookNotFoundException();
    }
    
    // Delete a phonebook.
    public void delete(Phonebook phonebook) throws PhonebookNotFoundException{
        if(phonebook != null){
            persistence.delete(phonebook);
            
            return;
        }
        
        throw new PhonebookNotFoundException();
    }
}