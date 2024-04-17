package kr.happyjob.study.adm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.adm.model.AdviceModel;
import kr.happyjob.study.adm.model.LectureAdviceModel;
import kr.happyjob.study.adm.service.LectureAdviceService;

@Controller
@RequestMapping("/adm/")
public class LectureAdviceController {

	@Autowired
	LectureAdviceService lectureAdviceService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 상담 관리 초기화면
	 */

	@RequestMapping("lectureAdvice.do")
	public String tutor_lec_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		paramMap.put("tutor_id", session.getAttribute("loginId"));

		logger.info("   - paramMap : " + paramMap);

		return "adm/advice";
	}

	/* 강의 리스트 */
	@RequestMapping("lecAdList.do")
	public String lecAdList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
																					// 페이지
																					// 번호
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); // 페이지
																			// 사이즈
		int pageIndex = (currentPage - 1) * pageSize;
		String searchWord_lec = (String) paramMap.get("searchWord_lec");
		logger.info("+ Start " + className + ".lecAdList");
		logger.info("   - paramMap : " + paramMap);

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("searchWord_lec", searchWord_lec);

		logger.info("   - putparamMap : " + paramMap);

		// 강의 리스트 가져오기
		List<LectureAdviceModel> lecAdList = lectureAdviceService.lecAdList(paramMap);
		model.addAttribute("lecAdList", lecAdList);
		logger.info("lecAdList:" + lecAdList);

		// 강의 목록 카운트 조회
		int totalCount = lectureAdviceService.lecAdListCount(paramMap);
		model.addAttribute("totalCnt_lec", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage_lec", currentPage);

		logger.info("   - totalCnt : " + totalCount);
		logger.info("   - pageSize : " + pageSize);
		logger.info("   - currentPage : " + currentPage);

		logger.info("+ End " + className + ".lecAdList");

		return "adm/lecAdList";
	}

	/* 상담 리스트 */
	@RequestMapping("AdviceList.do")
	public String Advice_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		String searchKey_adv = (String) paramMap.get("searchKey_adv");
		String searchWord_adv = (String) paramMap.get("searchWord_adv");
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
																					// 페이지
																					// 번호
		int pageSize_adv = Integer.parseInt((String) paramMap.get("pageSize_adv")); // 페이지
		// 사이즈
		int pageIndex = (currentPage - 1) * pageSize_adv;
		logger.info("+ Start " + className + ".Advice_list");
		logger.info("   - paramMap : " + paramMap);

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize_adv", pageSize_adv);
		paramMap.put("searchWord_adv", searchWord_adv);

		// 상담 목록 조회
		List<AdviceModel> list_advice = lectureAdviceService.std_list(paramMap);
		model.addAttribute("list_advice", list_advice);
		logger.info("   - list_advice : " + list_advice);

		// 상담 목록 카운트 조회
		int totalCount = lectureAdviceService.countList_Advice(paramMap);
		model.addAttribute("totalCnt_adv", totalCount);
		model.addAttribute("pageSize_adv", pageSize_adv);
		model.addAttribute("currentPage_adv", currentPage);

		logger.info("   - totalCnt : " + totalCount);
		logger.info("   - pageSize : " + pageSize_adv);
		logger.info("   - currentPage : " + currentPage);

		logger.info("+ End " + className + ".list_advice");

		return "adm/adviceList";
	}

	// 모달창 강의 목록
	@RequestMapping("mlist_lecture.do")
	public String mlec_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		;
		paramMap.put("tutor_id", session.getAttribute("loginId"));

		// 강의 리스트 가져오기
		List<LectureAdviceModel> mlist_lec = lectureAdviceService.lecAdList(paramMap);
		model.addAttribute("mlist_lec", mlist_lec);
		logger.info("lec_list:" + mlist_lec);

		return "adm/mlecList";
	}

	// 모달창 학생 목록
	@RequestMapping("mlist_student.do")
	public String mstd_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		List<AdviceModel> lec_stu_list = lectureAdviceService.lec_stu_list(paramMap);
		model.addAttribute("lec_stu_list", lec_stu_list);
		logger.info("   - paramMap : " + paramMap);
		logger.info("   - lec_stu_list : " + lec_stu_list);

		return "adm/mstdList";
	}

	// 상담 저장
	@RequestMapping("save_adv.do")
	// Map 형태 redirect안할때 씀 즉 값만 바꾸겠다.라는 이야기
	@ResponseBody
	public Map<String, Object> save_advice(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".save_advice");
		logger.info("   - paramMap : " + paramMap);

		String action = (String) paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";

		// 사용자 정보 설정
		paramMap.put("tut_id", session.getAttribute("loginId"));

		if ("I".equals(action)) {
			// 그룹코드 신규 저장
			lectureAdviceService.adv_register(paramMap);
		} else if ("U".equals(action)) {
			// 그룹코드 수정 저장
			lectureAdviceService.adv_update(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		logger.info("+ End " + className + ".save_advice");

		return resultMap;
	}
	//상담 단건 조회
		@RequestMapping("adv_one.do")
		@ResponseBody
		public Map<String, Object> select_adv (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".adv_one");
			logger.info("   - paramMap : " + paramMap);

			String result = "SUCCESS";
			String resultMsg = "조회 되었습니다.";
			
			// 공통 그룹 코드 단건 조회
			AdviceModel adv_model = lectureAdviceService.adv_one(paramMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			resultMap.put("adv_model", adv_model);
			
			logger.info("+ End " + className + ".adv_one");
			
			return resultMap;
		}
		//상담삭제
		@RequestMapping("delete_adv.do")
		@ResponseBody
		public Map<String, Object> deleteComnDtlCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".delete_adv");
			logger.info("   - paramMap : " + paramMap);

			String result = "SUCCESS";
			String resultMsg = "삭제 되었습니다.";
			
			// 상세코드 삭제
			lectureAdviceService.adv_del(paramMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			
			logger.info("+ End " + className + ".delete_adv");
			
			return resultMap;
		}
}
