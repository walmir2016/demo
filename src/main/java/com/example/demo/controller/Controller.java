package com.example.demo.controller;

import com.example.demo.exceptions.ItemAlreadyExistsException;
import com.example.demo.exceptions.PermissionDeniedException;
import com.example.demo.model.Phonebook;
import com.example.demo.service.PhonebookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.security.SecureRandom;
import java.util.List;

/**
 * Class that defines the HTTP endpoints.
 *
 * @author fvilarinho
 */
@org.springframework.stereotype.Controller
@Validated
public class Controller{
    @Autowired
    private PhonebookService service;
    
    // Endpoint for search data.
    @PostMapping("/search")
    public void search(Model model,
                       @RequestParam(value = "q", required = false) String q){
        model.addAttribute("q", q);
        
        if(q == null)
            q = "";
            
        model.addAttribute("result", service.findByNameContaining(q));
    }
    
    // Endpoint to save (new or existent) data.
    @PostMapping("/save")
    public String save(Model model,
                       HttpServletRequest request,
                     @RequestParam(value = "q", required = false) String q,
                     @RequestParam(value = "id", required = false) Integer id,
                     @RequestParam(value = "name", required = true) @NotNull @NotBlank(message = "Name is mandatory") String name,
                     @RequestParam(value = "phone", required = true) @NotNull @NotBlank(message = "Phone is mandatory") String phone) throws ItemAlreadyExistsException{
        Phonebook phonebook = new Phonebook();
        
        if(id == null){
            List<Phonebook> items = service.findByName(name);
    
            if(items != null && !items.isEmpty())
                throw new ItemAlreadyExistsException();

            phonebook.setId(new SecureRandom().nextInt());
            phonebook.setOwner(request.getRemoteAddr());
        }
        else
            phonebook = service.findById(id);

        phonebook.setName(name);
        phonebook.setPhone(phone);
        
        service.save(phonebook);
    
        search(model, q);
        
        return "search";
    }
   
    // Endpoint to delete data.
    @PostMapping("/delete")
    public String delete(Model model,
                         HttpServletRequest request,
                       @RequestParam(value = "q", required = false) String q,
                       @RequestParam(value = "id", required = true) Integer id) throws PermissionDeniedException{
        Phonebook phonebook = service.findById(id);
    
        if(!phonebook.getOwner().equals(request.getRemoteAddr()))
            throw new PermissionDeniedException();

        service.delete(phonebook);
        
        search(model, q);
        
        return "search";
    }
    
    // Endpoint to add a new data.
    @PostMapping("/add")
    public String add(Model model){
        model.addAttribute("id", null);
        model.addAttribute("name", null);
        model.addAttribute("phone", null);

        return "form";
    }
    
    // Endpoint to edit an existing data.
    @PostMapping("/edit")
    public String edit(Model model,
                       HttpServletRequest request,
                       @RequestParam(value = "q", required = false) String q,
                       @RequestParam(value = "id", required = true) Integer id) throws PermissionDeniedException{
        Phonebook phonebook = service.findById(id);

        if(!phonebook.getOwner().equals(request.getRemoteAddr()))
            throw new PermissionDeniedException();

        model.addAttribute("id", phonebook.getId());
        model.addAttribute("name", phonebook.getName());
        model.addAttribute("phone", phonebook.getPhone());

        return "form";
    }
}
