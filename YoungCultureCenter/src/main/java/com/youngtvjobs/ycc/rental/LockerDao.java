package com.youngtvjobs.ycc.rental;

import java.util.List;

public interface LockerDao {

	List<LockerDto> selectLockerLocation() throws Exception;

	void lockerReservation(LockerDto lockerDto) throws Exception;

	List<LockerDto> selectLockerList(LockerDto lockerDto) throws Exception;

//	List<LockerDto> selecetLockerRsvList(int locker_location_id) throws Exception;
	List<LockerDto> selecetLockerRsvList(LockerDto lockerDto) throws Exception;

	List<LockerDto> selectReservationStat(String user_id) throws Exception;

	int selectReservationCnt(String user_id) throws Exception;

	
}
