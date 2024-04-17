package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.tut.dao.PfsSurveyDao;
import kr.happyjob.study.tut.model.LectureStdListVO;
import kr.happyjob.study.tut.model.PfsLectureVO;
import kr.happyjob.study.tut.model.SrvyStatisticsVO;

@Service
public class PfsSurveyServiceImpl implements PfsSurveyService{
	
	@Autowired
	private PfsSurveyDao pfsSurveyDao;
	
	public List<PfsLectureVO> pfsLectureList(Map<String, Object> paramMap) throws Exception {
		return pfsSurveyDao.pfsLectureList(paramMap);
	}
	
	public List<LectureStdListVO> lectureStdList(Map<String, Object> paramMap) throws Exception {
		return pfsSurveyDao.lectureStdList(paramMap);
	}
	
	public List<SrvyStatisticsVO> srvyStatistics(Map<String, Object> paramMap) throws Exception {
		return pfsSurveyDao.srvyStatistics(paramMap);
	}

}
