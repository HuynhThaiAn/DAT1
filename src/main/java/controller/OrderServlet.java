/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.AddressDAO;
import dao.OrderDAO;
import dao.PaymentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Address;
import model.Customer;
import model.Order;
import model.OrderDetail;
import model.Payment;

/**
 *
 * @author Administrator
 */
public class OrderServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrderServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        HttpSession session = request.getSession(false);
        Customer customer = (session == null) ? null : (Customer) session.getAttribute("customer");

        // fail-safe
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        try {
            switch (action) {

                // ===== ORDER HISTORY =====
                case "list": {
//                    remindedHeaderData(request); // optional: nếu bạn muốn set categoryList/brandList từ servlet khác thì bỏ dòng này
                    OrderDAO orderDAO = new OrderDAO();

                    List<Order> orders = orderDAO.getOrdersByCustomerId(customer.getCustomerID());
                    request.setAttribute("orders", orders);

                    request.getRequestDispatcher("/WEB-INF/views/customer/order/viewOrder.jsp")
                           .forward(request, response);
                    break;
                }

                // ===== ORDER DETAIL =====
                case "detail": {
                    String raw = request.getParameter("orderId");
                    int orderId;

                    try {
                        orderId = Integer.parseInt(raw);
                    } catch (Exception e) {
                        response.sendRedirect(request.getContextPath() + "/Order?action=list");
                        return;
                    }

                    OrderDAO orderDAO = new OrderDAO();
                    PaymentDAO paymentDAO = new PaymentDAO();
                    AddressDAO addressDAO = new AddressDAO();

                    // Quan trọng: check thuộc customer
                    Order order = orderDAO.getOrderByIdAndCustomerId(orderId, customer.getCustomerID());
                    if (order == null) {
                        response.sendRedirect(request.getContextPath() + "/Order?action=list");
                        return;
                    }

                    List<OrderDetail> details = orderDAO.getOrderDetailsByOrderId(orderId);
                    Payment payment = paymentDAO.getByOrderId(orderId);

                    // load address theo AddressID trong Order
                    Address address = null;
                    if (order.getAddressID() != null) {
                        // bạn chưa có method getById trong AddressDAO, nên tạm lấy list rồi tìm
                        List<Address> addrs = addressDAO.getByCustomerId(customer.getCustomerID());
                        for (Address a : addrs) {
                            if (a.getAddressID() != null && a.getAddressID().equals(order.getAddressID())) {
                                address = a;
                                break;
                            }
                        }
                    }

                    request.setAttribute("order", order);
                    request.setAttribute("details", details);
                    request.setAttribute("payment", payment);
                    request.setAttribute("address", address);

                    request.getRequestDispatcher("/WEB-INF/views/customer/order/viewOrderDetail.jsp")
                           .forward(request, response);
                    break;
                }

                default:
                    response.sendRedirect(request.getContextPath() + "/Order?action=list");
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
