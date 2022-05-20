package com.choong.spr.controller.ex01;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.choong.spr.domain.ex01.Category;
import com.choong.spr.domain.ex01.Products;
import com.choong.spr.mapper.ex01.Ex01Mapper;

@Controller
@RequestMapping("ex01")
public class Ex01Controller {
	
	@Autowired
	private Ex01Mapper mapper;
	
	@RequestMapping("sub01")
	public void listProducts(@RequestParam(name = "category", required = false) List<Integer> category, Model model) {
		
		List<Category> categoryList = mapper.selectCategory();
		List<Products> list = mapper.selectProducts(category);
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("list", list);
	}
	
	@RequestMapping("sub02")
	public void method02(String price, Model model) {
		
		List<Products> list = mapper.selectProductsThan(price);
		
		model.addAttribute("list", list);
		
	}
}
