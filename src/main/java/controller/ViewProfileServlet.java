/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProfileDAO;
import dao.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Customer;

/**
 *
 * @author pc
 */
@WebServlet(name = "ViewProfileServlet", urlPatterns = {"/ViewProfile"})
public class ViewProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet ViewProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewProfileServlet at " + request.getContextPath() + "</h1>");
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
    HttpSession session = request.getSession();
    Account user = (Account) session.getAttribute("user");
    
    // Kiểm tra user đã đăng nhập chưa
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Login");
        return;
    }
    
    // Lấy accountId từ user object
    int accountId = user.getAccountID();
    
    // Lấy customer từ session trước
    Customer customer = (Customer) session.getAttribute("cus");
    
    // Nếu không có trong session, lấy từ database
    if (customer == null) {
        CustomerDAO customerDAO = new CustomerDAO();
        customer = customerDAO.getCustomerByAccountId(accountId);
        
        // Nếu vẫn không tìm thấy, thử dùng ProfileDAO
        if (customer == null) {
            ProfileDAO profileDAO = new ProfileDAO();
            customer = profileDAO.getCustomerbyID(accountId);
        }
        
        // Kiểm tra lần cuối, nếu vẫn null thì xử lý
        if (customer == null) {
            // Log lỗi để debug
            System.out.println("ERROR: Cannot find customer with accountId: " + accountId);
            
            // Redirect về trang tạo profile hoặc hiển thị thông báo lỗi
            request.setAttribute("errorMessage", "Không tìm thấy thông tin profile. Vui lòng liên hệ admin.");
            request.getRequestDispatcher("/WEB-INF/View/error.jsp").forward(request, response);
            return;
        }
        
        // Lưu vào session nếu tìm thấy
        session.setAttribute("cus", customer);
    }
    
    request.setAttribute("cus", customer);
    request.getRequestDispatcher("/WEB-INF/View/customer/profile/view-profile.jsp").forward(request, response);
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