package com.eShoppingCart.controller.admin;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.eShoppingCart.model.Product;
import com.eShoppingCart.model.RestResponse;
import com.eShoppingCart.service.ProductService;

@RestController
@RequestMapping("/RestApi")
public class AdminProductRESTController {
	
	@Autowired
	private ProductService productService;
	
	@RequestMapping(value="/viewAllProducts", method=RequestMethod.GET)
	@ResponseBody
	public List<Product> getAllProducts() {
	    return productService.getProductList();
	}
	
	@RequestMapping(value="/viewProduct/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Product viewProduct(@Valid @PathVariable(value="id") int id, Model model){
		return productService.getProductById(id);
	}
	
	@RequestMapping(value="/addProduct/{id}", method=RequestMethod.POST)
	@ResponseBody
	public RestResponse addProduct(@Valid @PathVariable(value="id") int id,
										  @RequestParam(value="name") String name,
										  @RequestParam(value="category") String category, 
										  @RequestParam(value="description") String description, 
										  @RequestParam(value="price") int price,
										  @RequestParam(value="condition") String condition, 
										  @RequestParam(value="status") String status, 
										  @RequestParam(value="units") int units, 
										  @RequestParam(value="manufacturer") String manufacturer){
		RestResponse response = new RestResponse(false, "Problem occured while adding this product.");
		Product product = new Product();
		product.setId(id);
		product.setName(name);
		product.setCategory(category);
		product.setDescription(description);
		product.setPrice(price);
		product.setCondition(condition);
		product.setStatus(status);
		product.setUnits(units);
		product.setManufacturer(manufacturer);
		System.out.println("addProduct: " + product.toString());
		productService.addRestProduct(product);
		response.setSuccess(true);
		response.setMessage("Product added successfully.");
		return response;
	}
	
	@RequestMapping(value="/editProduct/{id}", method=RequestMethod.POST)
	@ResponseBody
	public RestResponse editProduct(@Valid @PathVariable(value="id") int id, 
										   @RequestParam(value="name") String name,
										   @RequestParam(value="category") String category, 
										   @RequestParam(value="description") String description, 
										   @RequestParam(value="price") int price,
										   @RequestParam(value="condition") String condition, 
										   @RequestParam(value="status") String status, 
										   @RequestParam(value="units") int units, 
										   @RequestParam(value="manufacturer") String manufacturer){
		RestResponse response = new RestResponse(false, "Problem occured while editing this product.");
		Product product = new Product();
		product.setId(id);
		product.setName(name);
		product.setCategory(category);
		product.setDescription(description);
		product.setPrice(price);
		product.setCondition(condition);
		product.setStatus(status);
		product.setUnits(units);
		product.setManufacturer(manufacturer);
		System.out.println("editProduct: " + product.toString());
		productService.editProduct(product);
		response.setSuccess(true);
		response.setMessage("Product edited successfully.");
		return response;
	}
	
	@RequestMapping(value="/deleteProduct/{id}", method=RequestMethod.DELETE)
	@ResponseBody
	public RestResponse deleteProduct(@Valid @PathVariable(value="id") int id, Model model) {
		RestResponse response = new RestResponse(false, "Problem occured while deleting this product.");
		Product product = productService.getProductById(id);
		System.out.println("deleteProduct: " + product.toString());
		if(product != null){
			productService.deleteProduct(productService.getProductById(id));
			response.setSuccess(true);
			response.setMessage("Product deleted successfully.");
		}
		return response;
	}
	
}
