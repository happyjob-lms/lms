package kr.happyjob.study.tut.controller;

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

import kr.happyjob.study.tut.model.LectureStdListVO;
import kr.happyjob.study.tut.model.PfsLectureVO;
import kr.happyjob.study.tut.model.SrvyStatisticsVO;
import kr.happyjob.study.tut.service.PfsSurveyService;

@Controller
@RequestMapping("/tut/")
public class PfsSurveyController {
	
	@Autowired
	private PfsSurveyService pfsSurveyService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("surveyControl.do")
	public String surveyControl(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".surveyControl");
		logger.info("   - paramMap : " + paramMap);
		
		int userNo = (int)session.getAttribute("user_no");
		model.addAttribute("userNo", userNo);
		
		logger.info("+ End " + className + ".surveyControl");
		
		return "tut/pfsSurveyPage";
	}
	
	@RequestMapping("pfsLectureList.do")
	public String pfsLectureList(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".pfsLectureList");
		logger.info("   - paramMap : " + paramMap);
		
		int cpage = Integer.valueOf((String)paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String)paramMap.get("pagesize"));
		int startpos = (cpage - 1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		paramMap.put("user_no", session.getAttribute("user_no"));
		
		List<PfsLectureVO> listData = pfsSurveyService.pfsLectureList(paramMap);
		
		model.addAttribute("listData", listData);
		model.addAttribute("listcnt", listData.size());
		
		logger.info("+ End " + className + ".pfsLectureList");
		
		return "tut/pfsSurveyList";
	}
	
	@RequestMapping("lectureStdList.do")
	public String lectureStdList(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureStdList");
		logger.info("   - paramMap : " + paramMap);
		
		int cpage = Integer.valueOf((String)paramMap.get("currentPage"));
		int pagesize = Integer.valueOf((String)paramMap.get("pagesize"));
		int startpos = (cpage - 1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<LectureStdListVO> listData = pfsSurveyService.lectureStdList(paramMap);
		
		model.addAttribute("listData", listData);
		model.addAttribute("listcnt", listData.size());
		
		logger.info("+ End " + className + ".lectureStdList");
		
		return "tut/lectureStdListPage";
	}
	
	@ResponseBody
	@RequestMapping("statisticsList.do")
	public Map<String, Object> statisticsList(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".statisticsList");
		logger.info("   - paramMap : " + paramMap);
		
		List<SrvyStatisticsVO> listData = pfsSurveyService.srvyStatistics(paramMap);
		System.out.println("=====listData=====" + listData);
		
		Map<String, Object> map = new HashMap<>();
		map.put("listData", listData);
		
		logger.info("+ End " + className + ".statisticsList");
		
		return map;
	}

}
