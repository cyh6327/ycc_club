package com.youngtvjobs.ycc.rental;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PlaceDaoImpl implements PlaceDao{
	
	@Autowired
	private SqlSession session;
	private static String namespace = "com.youngtvjobs.ycc.rental.placeMapper.";
	
	@Override
	public List<PlaceDto> selectRentalPlace() throws Exception {
		return session.selectList(namespace + "selectRentalPlace");
	}
	
	@Override
	public List<PlaceDto> selectInfo(String croom_id, Date prental_de) throws Exception {
		Map map = new HashMap();
		map.put("croom_id", croom_id);
		map.put("prental_de", prental_de);
		return session.selectList(namespace + "selectInfo", map);
	}
	
	/*
	@Override
	public List<RentalDto> selectTotalInfo() throws Exception {
		return session.selectList(namespace + "selectTotalInfo");
	}
	*/

	@Override
	public int insertInfo(PlaceDto rentalDto) throws Exception {
		return session.insert(namespace + "insertInfo", rentalDto);
	}

	@Override
	public List<PlaceDto> selectPlace(String croom_id) throws Exception {
		Map map = new HashMap();
		map.put("croom_id", croom_id);
		return session.selectList(namespace + "selectPlace", map);
	}



	

}
