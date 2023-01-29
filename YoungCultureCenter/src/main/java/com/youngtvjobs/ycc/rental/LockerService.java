package com.youngtvjobs.ycc.rental;

import java.util.List;

public interface LockerService {

	List<LockerDto> getLockerLocation() throws Exception;

	void lockerReservation(LockerDto lockerDto) throws Exception;

	List<LockerDto> getLockerList(LockerDto lockerDto) throws Exception;

	List<LockerDto> getLockerRsvList(LockerDto lockerDto) throws Exception;

	List<LockerDto> getReservationStat(String user_id) throws Exception;

	int getReservationCnt(String user_id) throws Exception;


}
