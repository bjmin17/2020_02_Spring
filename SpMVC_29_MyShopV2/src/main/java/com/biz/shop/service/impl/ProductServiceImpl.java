package com.biz.shop.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.biz.shop.domain.ProductVO;
import com.biz.shop.persistence.DDL_Dao;
import com.biz.shop.persistence.ProductDao;
import com.biz.shop.persistence.sql.CreateTableSQL;
import com.biz.shop.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Slf4j
@Service
public class ProductServiceImpl implements ProductService {

	private final ProFileServiceImpl proFile;
	private final ProductDao proDao;
	private final DDL_Dao ddl_dao;
	
	public ProductServiceImpl(ProductDao proDao, DDL_Dao ddl_dao, ProFileServiceImpl proFile) {
		this.proDao = proDao;
		this.ddl_dao = ddl_dao;
		this.proFile = proFile;
		
		ddl_dao.create_table(CreateTableSQL.create_product_table);
		ddl_dao.create_table(CreateTableSQL.create_pro_color_table);
		ddl_dao.create_table(CreateTableSQL.create_pro_size_table);
						
	}
	
	@Override
	public int insert(ProductVO productVO) {
		return proDao.insert(productVO);
	}
	
	@Override
	public int insert(ProductVO productVO, MultipartFile file) {
		
		String saveName = proFile.fileUpLoad(file);
		log.debug("저장파일이름:"+saveName);
		productVO.setP_file(saveName);
		return proDao.insert(productVO);
	}

	@Override
	public List<ProductVO> selectAll() {
		return proDao.selectAll();
	}

	@Override
	public ProductVO findByPCode(String p_code) {
		return proDao.findByPCode(p_code);
	}

	@Override
	public List<ProductVO> findByPName(String p_name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(ProductVO productVO) {
		return 0;
		// TODO Auto-generated method stub
		
	}

	@Override
	public int delete(String p_code) {
		return 0;
		// TODO Auto-generated method stub
		
	}



}
