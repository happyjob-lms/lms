package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.LectureAdviceDao;
import kr.happyjob.study.adm.model.AdviceModel;
import kr.happyjob.study.adm.model.LectureAdviceModel;

@Service
public class LectureAdviceServiceImpl implements LectureAdviceService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	LectureAdviceDao lectureAdviceDao;

	@Override
	public List<LectureAdviceModel> lecAdList(Map<String, Object> paramMap) throws Exception {

		List<LectureAdviceModel> lecAdList = lectureAdviceDao.lecAdList(paramMap);

		return lecAdList;
	}

	@Override
	public int lecAdListCount(Map<String, Object> paramMap) throws Exception {

		int totalCount = lectureAdviceDao.lecAdListCount(paramMap);

		return totalCount;
	}

	@Override
	public List<AdviceModel> std_list(Map<String, Object> paramMap) {
		List<AdviceModel> std_list = lectureAdviceDao.std_list(paramMap);

		return std_list;
	}

	@Override
	public int countList_Advice(Map<String, Object> paramMap) {
		return lectureAdviceDao.countList_Advice(paramMap);
	}

	@Override
	public List<AdviceModel> lec_stu_list(Map<String, Object> paramMap) {
		logger.info("   - 서비스 : " + paramMap);
		return lectureAdviceDao.lec_stu_list(paramMap);
	}

	@Override
	public int adv_del(Map<String, Object> paramMap) {
		return lectureAdviceDao.adv_del(paramMap);
	}

	@Override
	public AdviceModel adv_one(Map<String, Object> paramMap) {
		return lectureAdviceDao.adv_one(paramMap);
	}

	@Override
	public int adv_register(Map<String, Object> paramMap) {
		return lectureAdviceDao.adv_register(paramMap);
	}

	@Override
	public int adv_update(Map<String, Object> paramMap) {
		return lectureAdviceDao.adv_update(paramMap);
	}

}
