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
    
    public List<Phonebook> list(){
        return persistence.findAll();
    }
    
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
    
    public List<Phonebook> findByName(String name){
        return persistence.findByName(name);
    }
    
    public List<Phonebook> findByNameContaining(String name){
        return persistence.findByNameContaining(name);
    }
    
    public Phonebook save(Phonebook phonebook) throws PhonebookAlreadyExistsException, PhonebookNotFoundException{
        if(phonebook != null){
            List<Phonebook> list = persistence.findByName(phonebook.getName());
            
            if(list == null || list.isEmpty())
                return persistence.save(phonebook);
            
            throw new PhonebookAlreadyExistsException();
        }
    
        throw new PhonebookNotFoundException();
    }
    
    public void delete(Phonebook phonebook) throws PhonebookNotFoundException{
        if(phonebook != null){
            persistence.delete(phonebook);
            
            return;
        }
        
        throw new PhonebookNotFoundException();
    }
}