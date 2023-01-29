package com.youngtvjobs.ycc.rental;

import java.util.Date;
import java.util.List;
import java.util.Map;


public interface PlaceService {

	List<PlaceDto> selectInfo(String croom_id, Date prental_de) throws Exception;
	/* List<RentalDto> selectTotalInfo() throws Exception; */
	int insertInfo(PlaceDto rentalDto) throws Exception;
	List<PlaceDto> selectPlace(String croom_id) throws Exception;
	List<PlaceDto> selectRentalPlace() throws Exception;
	
}
