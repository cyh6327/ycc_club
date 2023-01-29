package com.youngtvjobs.ycc.rental;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LockerServiceImpl implements LockerService {
	
	@Autowired
	LockerDao lockerDao;

	@Override
	public List<LockerDto> getLockerLocation() throws Exception {
		// TODO Auto-generated method stub
		return lockerDao.selectLockerLocation();
	}

	@Override
	public void lockerReservation(LockerDto lockerDto) throws Exception {
		// TODO Auto-generated method stub
		lockerDao.lockerReservation(lockerDto);
	}

	@Override
	public List<LockerDto> getLockerList(LockerDto lockerDto) throws Exception {
		// TODO Auto-generated method stub
		return lockerDao.selectLockerList(lockerDto);
	}
	
	@Override
	public List<LockerDto> getLockerRsvList(LockerDto lockerDto) throws Exception {
		// TODO Auto-generated method stub
		return lockerDao.selecetLockerRsvList(lockerDto);
	}

	@Override
	public List<LockerDto> getReservationStat(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return lockerDao.selectReservationStat(user_id);
	}

	@Override
	public int getReservationCnt(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return lockerDao.selectReservationCnt(user_id);
	}

}
