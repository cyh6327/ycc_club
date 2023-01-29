package com.youngtvjobs.ycc.rental;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LockerDaoImpl implements LockerDao{
	
	@Autowired
	private SqlSession session;
	private static String namespace = "com.youngtvjobs.ycc.rental.lockerMapper.";

	@Override
	public List<LockerDto> selectLockerLocation() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + "selectLockerLocation");
	}

	@Override
	public void lockerReservation(LockerDto lockerDto) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + "insertLockerReservation", lockerDto);
	}

	@Override
	public List<LockerDto> selectLockerList(LockerDto lockerDto) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + "selectLocker", lockerDto);
	}

//	@Override
//	public List<LockerDto> selecetLockerRsvList(int locker_location_id) throws Exception {
//		// TODO Auto-generated method stub
//		return session.selectList(namespace + "selectReservation", locker_location_id);
//	}
	@Override
	public List<LockerDto> selecetLockerRsvList(LockerDto lockerDto) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + "selectReservation", lockerDto);
	}
	
	@Override
	public List<LockerDto> selectReservationStat(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + "selectMyReservationStat", user_id);
	}

	@Override
	public int selectReservationCnt(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + "selectMyReservationCnt", user_id);
	}

	

}
