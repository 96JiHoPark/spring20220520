package com.choong.spr.mapper.ex01;

import java.util.List;

import com.choong.spr.domain.ex01.Category;
import com.choong.spr.domain.ex01.Products;

public interface Ex01Mapper {

	List<Products> selectProducts(List<Integer> category);

	List<Category> selectCategory();

}
