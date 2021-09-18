package br.com.demo.helpers;

import br.com.demo.model.Phonebook;
import br.com.demo.persistence.PhonebookPersistence;
import org.mockito.Mockito;

import java.util.Arrays;
import java.util.List;

public abstract class Mocks{
    public static PhonebookPersistence getPersistence(){
        return Mockito.mock(PhonebookPersistence.class);
    }
    
    public static List<Phonebook> getList(){
        return Arrays.asList(getItem());
    }
    
    public static Phonebook getItem(){
        Phonebook item = new Phonebook();
        
        item.setId(1);
        item.setName("Luke Skywalker");
        item.setPhone("366-117891");
        
        return item;
    }
    
    public static Phonebook getNewItem(){
        Phonebook item = new Phonebook();
        
        item.setName("Yoda");
        item.setPhone("1-877-7-MICKEY");
        
        return item;
    }
    
    public static Phonebook getExistingItem(){
        Phonebook item = new Phonebook();
        
        item.setName("Luke Skywalker");
        item.setPhone("366-117891");
        
        return item;
    }
}
