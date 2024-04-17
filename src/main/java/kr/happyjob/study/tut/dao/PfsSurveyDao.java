package kr.happyjob.study.tut.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.LectureStdListVO;
import kr.happyjob.study.tut.model.PfsLectureVO;
import kr.happyjob.study.tut.model.SrvyStatisticsVO;

public interface PfsSurveyDao {

	// 강사별 강의목록
	public List<PfsLectureVO> pfsLectureList(Map<String, Object> paramMap) throws Exception;
	
	// 강의별 학생목록
	public List<LectureStdListVO> lectureStdList(Map<String, Object> paramMap) throws Exception;
	
	// 설문 통계
	public List<SrvyStatisticsVO> srvyStatistics(Map<String, Object> paramMap) throws Exception;
}
