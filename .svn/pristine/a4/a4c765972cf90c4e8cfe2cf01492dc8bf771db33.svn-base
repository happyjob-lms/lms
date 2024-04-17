package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.AdviceModel;
import kr.happyjob.study.adm.model.LectureAdviceModel;

public interface LectureAdviceService {

	/* 강사의 강의목록 */
	public List<LectureAdviceModel> lecAdList(Map<String, Object> paramMap) throws Exception;

	/* 강사 강의목록 카운트 */
	public int lecAdListCount(Map<String, Object> paramMap) throws Exception;
	
	public List<AdviceModel> std_list(Map<String, Object> paramMap);

	public int countList_Advice(Map<String, Object> paramMap);
	
	/*상담 상세정보 */
	public AdviceModel adv_one(Map<String,Object> paramMap);
	
	/*상담 등록 */
	public int adv_register(Map<String,Object> paramMap);
	
	/* 상담 수정 */
	public int adv_update(Map<String,Object> paramMap);
	
	/* 강의 수강 학생 목록 */
	public List<AdviceModel> lec_stu_list(Map<String,Object> paramMap);
	
	/* 상담 삭제 */
	public int adv_del(Map<String,Object> paramMap);
}
