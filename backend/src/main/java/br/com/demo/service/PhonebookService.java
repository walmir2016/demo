package br.com.demo.service;

import br.com.demo.exceptions.ItemAlreadyExistsException;
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
    
    public List<Phonebook> list(){
        return persistence.findAll();
    }
    
    public Phonebook findById(Integer id){
        Optional<Phonebook> result = persistence.findById(id);
        
        if(result.isPresent())
            return result.get();
        
        return null;
    }
    
    public List<Phonebook> findByName(String name){
        return persistence.findByName(name);
    }
    
    public List<Phonebook> findByNameContaining(String name){
        return persistence.findByNameContaining(name);
    }
    
    public void save(Phonebook phonebook) throws ItemAlreadyExistsException{
        Integer id = phonebook.getId();
        String name = phonebook.getName();
        
        if(id == null){
            List<Phonebook> items = findByName(name);
        
            if(items != null && !items.isEmpty())
                throw new ItemAlreadyExistsException();
        }
        
        persistence.save(phonebook);
    }
    
    public void deleteById(Integer id){
        persistence.deleteById(id);
    }
    
    public void delete(Phonebook phonebook) { persistence.delete(phonebook);}
}