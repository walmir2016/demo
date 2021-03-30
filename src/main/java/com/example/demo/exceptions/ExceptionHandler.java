package com.example.demo.exceptions;

import antlr.StringUtils;
import com.example.demo.exceptions.ItemAlreadyExistsException;
import com.example.demo.exceptions.PermissionDeniedException;
import com.example.demo.service.PhonebookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.util.Enumeration;
import java.util.Set;

@ControllerAdvice
public class ExceptionHandler{
    @Autowired
    private PhonebookService service;
    
    private void populateAttributes(Model model, HttpServletRequest request){
        Enumeration<String> enumeration = request.getParameterNames();
    
        while(enumeration.hasMoreElements()){
            String parameterId = enumeration.nextElement();
        
            model.addAttribute(parameterId, request.getParameter(parameterId));
        }
    }
    
    @org.springframework.web.bind.annotation.ExceptionHandler(ConstraintViolationException.class)
    public String handleViolations(Model model, HttpServletRequest request, ConstraintViolationException ex){
        Set<ConstraintViolation<?>> violations = ex.getConstraintViolations();
        
        for(ConstraintViolation violation: violations){
            String messageId = violation.getPropertyPath().toString().replaceAll("save.", "").concat("Message");
            String messageValue = violation.getMessage();
            
            model.addAttribute(messageId, messageValue);
        }
        
        populateAttributes(model, request);
        
        return "form";
    }
    
    @org.springframework.web.bind.annotation.ExceptionHandler(PermissionDeniedException.class)
    public String handlePermissionDenied(Model model, HttpServletRequest request, PermissionDeniedException ex){
        model.addAttribute("permissionDeniedMessage", "You can't edit or delete this data!");
    
        populateAttributes(model, request);
        
        model.addAttribute("result", service.findByNameContaining(request.getParameter("q")));
        
        return "search";
    }
    
    @org.springframework.web.bind.annotation.ExceptionHandler(ItemAlreadyExistsException.class)
    public String handleItemAlreadyExists(Model model, HttpServletRequest request, ItemAlreadyExistsException ex){
        model.addAttribute("nameMessage", "This item already exists!");
        
        populateAttributes(model, request);
        
        return "form";
    }
}
