package com.biz.shop.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.biz.shop.domain.ProductVO;
import com.biz.shop.persistence.DDL_Dao;
import com.biz.shop.persistence.ProductDao;
import com.biz.shop.persistence.sql.CreateTableSQL;
import com.biz.shop.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {

	private final ProductDao proDao;
	private final DDL_Dao ddl_dao;
	
	public ProductServiceImpl(ProductDao proDao, DDL_Dao ddl_dao) {
		this.proDao = proDao;
		this.ddl_dao = ddl_dao;
		
		ddl_dao.create_table(CreateTableSQL.create_product_table);
		ddl_dao.create_table(CreateTableSQL.create_pro_color_table);
		ddl_dao.create_table(CreateTableSQL.create_pro_size_table);
						
	}
	
	@Override
	public void insert(ProductVO productVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ProductVO> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void findByPCode(String p_code) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ProductVO> findByPName(String p_name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(ProductVO productVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(String p_code) {
		// TODO Auto-generated method stub
		
	}

}
