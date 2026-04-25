package com.website.seller.servlet;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.website.jdbc.JdbcConnection;
import com.website.pojo.*;
import com.website.seller.repository.SellerProductRepository;

/**
 * Servlet implementation class SignUpServlet
 */
@WebServlet("/Addproduct")
@MultipartConfig
public class SelleraddproductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SelleraddproductServlet() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("complete the process of seller add product");
		request.getRequestDispatcher("addproduct.jsp").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd ");
            SimpleDateFormat formatter1 = new SimpleDateFormat(" | hh:mm a");

            Date date = new Date();
			HttpSession session=request.getSession();		


            Selleruser auth1 = (Selleruser) request.getSession().getAttribute("auth1");
            
            
			if(auth1 != null) {
			String productname=request.getParameter("productname");
			String price=request.getParameter("price");
			String category=request.getParameter("category");
			String description=request.getParameter("description");
			String address=request.getParameter("address");
			String check=request.getParameter("check");
			Part part = request.getPart("image");
			String filename = part.getSubmittedFileName();
			
			String status = request.getParameter("status");
			
			int add_userid = auth1.getId();
			String add_date = (formatter.format(date)+" "+formatter1.format(date));
			
			System.out.println("add product!!!");
			
			
			if(check!=null) {
				SellerProductRepository repo= new SellerProductRepository();
			boolean p = repo.insertIntoaddpro(productname, filename,price,description, category, address,status,add_userid, add_date);
			//response.setContentType("text/html;charset=UTF-8");
			System.out.println("seller product!!!"+" "+p);
			
			String path = getServletContext().getRealPath("")+"images";

			
			File f = new File(path);
			part.write(path + File.separator + filename);
			System.out.println(f);
			
			if(p) {
				response.sendRedirect("addproduct.jsp");
				session.setAttribute("successMsg", "Add successfully...");			
			System.out.println("seller add product!!!");
			}else {
				response.sendRedirect("addproduct.jsp");	
				session.setAttribute("failedMsg", "Something wrong on server...");
				System.out.println("seller not add product!!!");
		//	out.print("Error please try again to register !!!");
		}
			}else {
			response.sendRedirect("addproduct.jsp");
		 session.setAttribute("failedMsg", "please check Agree & terms condition !!!");	
			System.out.println("please check Agree and terms condition !!! ");
			}
			}else {
	        	response.sendRedirect("sellerlogin.jsp");
	       	 session.setAttribute("failedMsg", " Again login !!!");	
	        }
			}catch(Exception e) {
				e.printStackTrace();
				System.out.println("Error Add product!!");
			}
	}
}


