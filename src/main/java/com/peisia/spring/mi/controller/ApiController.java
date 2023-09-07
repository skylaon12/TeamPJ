package com.peisia.spring.mi.controller;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.peisia.spring.mi.vo.KWeatherVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/apik/*")
public class ApiController {
	
	@GetMapping("/w")
	public void w(Model model) {
		String API_KEY = "sJ3ktBzk57TTkKOkaueiQT7IuwaHMUTQKaZu%2BjeC51EvvVmh8pYPd1Ek6YWe45LklKLAK8TRlMsx3O51KnmCJg%3D%3D";				
		String API_URL = "http://apis.data.go.kr/1360000/AsosDalyInfoService/getWthrDataList?numOfRows=10&pageNo=1&dateCd=DAY&startDt=20230813&endDt=20230817&stnIds=108&dataCd=ASOS&dataType=JSON&serviceKey=" + API_KEY;
		
		RestTemplate restTemplate = new RestTemplate();
		
		// **** 중요 **** uri
		URI uri = null; //java.net.URI 임포트 하셈
		try {
			uri = new URI(API_URL);
		}catch(URISyntaxException e) {
			e.printStackTrace();
		}
		String s = restTemplate.getForObject(uri, String.class);
		log.info("======우리나라 날씨 잘 나오냐? " + s);

		KWeatherVO kw = restTemplate.getForObject(uri, KWeatherVO.class);
		log.info("==== json ==== : 우리나라 날씨 잘 나오냐? : "+kw.response.body.dataType);
		String location = kw.response.body.items.item.get(0).stnNm;
		String tMin = kw.response.body.items.item.get(0).minTa;
		String tMax = kw.response.body.items.item.get(0).maxTa;
		String ddara = String.format("==== json ==== : 어제의 날씨입니다~ 어제 %s 의 최저기온은 %s 도 최고 기온은 %s 였습니다. 날씨였습니다.", location, tMin, tMax);
		log.info(ddara);
		model.addAttribute("location",location);
		model.addAttribute("tMin",tMin);
		model.addAttribute("tMax", tMax);
	}
	
	@GetMapping("/address")
	public void address() {
		
	}
//	@RequestMapping("testPage")
//	public void test() {}
//	
	
	@RequestMapping("/login")
	public String home(@RequestParam(value = "code", required = false) String code) throws Exception{
        System.out.println("#########" + code);
        return "api/testPage";
    }
}
