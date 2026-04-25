package com.website.buyer.servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.website.pojo.Cart;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddToCartServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Cart cm = new Cart();
        cm.setId(id);
        cm.setQuantity(1);

        HttpSession session = request.getSession();
        ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

        if (cart_list == null) {
            // First item in cart
            ArrayList<Cart> cartList = new ArrayList<>();
            cartList.add(cm);
            session.setAttribute("cart-list", cartList);
            session.setAttribute("cart_msg", "✅ Product added to cart!");
        } else {
            boolean exist = false;
            for (Cart c : cart_list) {
                if (c.getId() == id) {
                    exist = true;
                    break;
                }
            }
            if (!exist) {
                cart_list.add(cm);
                session.setAttribute("cart-list", cart_list);
                session.setAttribute("cart_msg", "✅ Product added to cart!");
            } else {
                session.setAttribute("cart_msg", "⚠️ Item already in cart!");
            }
        }

        // Stay on same page
        String referer = request.getHeader("Referer");
        if (referer != null) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}