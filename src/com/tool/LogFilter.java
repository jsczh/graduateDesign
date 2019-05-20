package com.tool;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.User;

public class LogFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain arg2)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
        HttpServletResponse resp =(HttpServletResponse) response;
        HttpSession session = req.getSession();
        // 获得用户请求的URI
        String path = req.getRequestURI();
        String params = req.getQueryString();
        
/*        System.out.println("-------------------------------");
        System.out.println("Info:"+params);
        System.out.println("-------------------------------");*/
        
        
        User user = (User) session.getAttribute("user");
        
/*        System.out.println("-------------------------------");
        System.out.println(path);
        System.out.println("-------------------------------");*/
        
        // login.jsp页面无需过滤(根据自己项目的要求来)
        //也可以path.contains("login.jsp")  反正怎么精确怎么来就不多说了
        if(path.contains("login.jsp") ||  
        		path.contains(".css") || path.contains(".js") || 
        		path.contains(".jpg") || path.contains(".png")|| 
        		path.indexOf("/user_reg.jsp") > -1 || path.contains("commodity.action")) {
            	
        		arg2.doFilter(req, resp);
            return;
        } 
        else {//如果不是login.jsp进行过滤
        	if (params != null){
        		if(params.contains("login") || params.contains("checkNicknameExist")
        			|| params.contains("checkEmailExist") || params.contains("checkEmailExist") 
        			|| params.contains("checkUsernameExist") || params.contains("selectCommodityByShopname"))
        		{
        			arg2.doFilter(req, resp);
        			return ;
        		}	
        	}
        	if (user == null) {
        		// 未登录，跳转到首页
                resp.sendRedirect("/graduateDesign/commodity.action?showCommodityRandom4");
            } else {
                // 已经登陆,继续此次请求
                arg2.doFilter(req, resp);
            }
        }

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
