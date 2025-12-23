/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.CartViewItem;
import model.Customer;

/**
 *
 * @author Administrator
 */
public class CartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        Customer customer = (Customer) request.getSession().getAttribute("customer");
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        int customerId = customer.getCustomerID();

        try {
            if ("add".equals(action)) {
                int variantId = Integer.parseInt(request.getParameter("variantId"));
                int qty = Integer.parseInt(request.getParameter("qty"));
                cartDAO.addOrIncrease(customerId, variantId, qty);
                response.sendRedirect(request.getContextPath() + "/Cart?action=view");
                return;
            }

            if ("remove".equals(action)) {
                int variantId = Integer.parseInt(request.getParameter("variantId"));
                cartDAO.removeItem(customerId, variantId);
                response.sendRedirect(request.getContextPath() + "/Cart?action=view");
                return;
            }

            // view
            List<CartViewItem> items = cartDAO.getCartViewItems(customerId);
            request.setAttribute("cartItems", items);
            request.getRequestDispatcher("/WEB-INF/views/customer/cart/cart.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        Customer customer = (Customer) request.getSession().getAttribute("customer");

        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        int customerId = customer.getCustomerID();

        try {
            if ("update".equals(action)) {
                int variantId = Integer.parseInt(request.getParameter("variantId"));
                int qty = Integer.parseInt(request.getParameter("qty"));
                cartDAO.updateQuantity(customerId, variantId, qty);
                response.sendRedirect(request.getContextPath() + "/Cart?action=view");

            } else if ("add".equals(action)) {
                int variantId = Integer.parseInt(request.getParameter("variantId"));
                int qty = Integer.parseInt(request.getParameter("qty"));
                cartDAO.addOrIncrease(customerId, variantId, qty);
                response.sendRedirect(request.getContextPath() + "/Cart?action=view");
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
