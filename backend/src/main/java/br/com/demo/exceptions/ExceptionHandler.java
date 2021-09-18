package br.com.demo.exceptions;

import br.com.demo.service.PhonebookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Set;

/**
 * Class that handles the exceptions and violations from the controller.
 *
 * @author fvilarinho
 */
@ControllerAdvice
public class ExceptionHandler{
    @Autowired
    private PhonebookService service;
    
    // Populate the request attributes.
    private void populateAttributes(Model model, HttpServletRequest request){
        Enumeration<String> enumeration = request.getParameterNames();
    
        while(enumeration.hasMoreElements()){
            String parameterId = enumeration.nextElement();
        
            model.addAttribute(parameterId, request.getParameter(parameterId));
        }
    }
    
    // Handles violations of the form.
    @org.springframework.web.bind.annotation.ExceptionHandler(ConstraintViolationException.class)
    public String handleViolations(Model model, HttpServletRequest request, ConstraintViolationException ex){
        Set<ConstraintViolation<?>> violations = ex.getConstraintViolations();
        
        for(ConstraintViolation<?> violation: violations){
            String messageId = violation.getPropertyPath().toString().replaceAll("save.", "").concat("Message");
            String messageValue = violation.getMessage();
            
            model.addAttribute(messageId, messageValue);
        }
        
        populateAttributes(model, request);
        
        return "form";
    }
    
    // When the data already exists.
    @org.springframework.web.bind.annotation.ExceptionHandler(PhonebookAlreadyExistsException.class)
    public String handlePhonebookAlreadyExists(Model model, HttpServletRequest request, PhonebookAlreadyExistsException ex){
        model.addAttribute("nameMessage", "This phonebook already exists!");
        
        populateAttributes(model, request);
        
        return "form";
    }
    
    // When the data was not found.
    @org.springframework.web.bind.annotation.ExceptionHandler(PhonebookNotFoundException.class)
    public String handlePhonebookNotFound(Model model, HttpServletRequest request, PhonebookNotFoundException ex){
        model.addAttribute("message", "This phonebook was not found!");
        
        populateAttributes(model, request);
        
        return "search";
    }
    
    // When the log data is invalid.
    @org.springframework.web.bind.annotation.ExceptionHandler(IllegalArgumentException.class)
    public void handleInvalidLogData(HttpServletRequest request, HttpServletResponse response, IllegalArgumentException ex) throws IOException{
        response.sendError(HttpStatus.INTERNAL_SERVER_ERROR.value(), ex.getMessage());
    }
}
