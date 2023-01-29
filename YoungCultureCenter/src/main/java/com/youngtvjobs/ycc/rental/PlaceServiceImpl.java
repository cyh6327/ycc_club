package com.youngtvjobs.ycc.rental;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PlaceServiceImpl implements PlaceService{
	
	@Autowired
	PlaceDao placeDao;
	
	@Override // selectBox에서 장소 고를때 장소를 불러옴
	public List<PlaceDto> selectRentalPlace() throws Exception {
		return placeDao.selectRentalPlace();
	}
	
	@Override	// 기존 예약 데이터들을 불러옴
	public List<PlaceDto> selectInfo(String croom_id, Date prental_de) throws Exception {
		List<PlaceDto> infoList = null;
		infoList = placeDao.selectInfo(croom_id, prental_de);
		return infoList;
	}
	
	/*
	@Override
	public List<RentalDto> selectTotalInfo() throws Exception {
		return rentalDao.selectTotalInfo();
	}
	*/
	
	@Override	// 선택한 예약 정보들을 insert
	public int insertInfo(PlaceDto rentalDto) throws Exception {
		return placeDao.insertInfo(rentalDto);
	}

	@Override
	public List<PlaceDto> selectPlace(String croom_id) throws Exception {
		return placeDao.selectPlace(croom_id);
	}

}
	