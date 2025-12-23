/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AddressDAO;
import dao.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import model.Address;
import model.Customer;
import utils.PasswordUtil;

/**
 *
 * @author Administrator
 */
public class ProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet ProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileServlet at " + request.getContextPath() + "</h1>");
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

        HttpSession session = request.getSession(false);
        Customer customer = (session == null) ? null : (Customer) session.getAttribute("customer");

        // fail-safe
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        try {
            switch (action) {

                case "edit": {
                    // chỉ forward, JSP tự lấy customer từ session
                    request.getRequestDispatcher(
                            "/WEB-INF/views/customer/profile/update-profile.jsp"
                    ).forward(request, response);
                    break;
                }

                case "changePasswordForm": {
                    request.getRequestDispatcher(
                            "/WEB-INF/views/customer/profile/change-password.jsp"
                    ).forward(request, response);
                    break;
                }

                case "view":
                default: {
                    // load default address
                    AddressDAO addressDAO = new AddressDAO();
                    Address defaultAddress
                            = addressDAO.getDefaultAddressByCustomerId(customer.getCustomerID());

                    request.setAttribute("defaultAddress", defaultAddress);

                    request.getRequestDispatcher(
                            "/WEB-INF/views/customer/profile/view-profile.jsp"
                    ).forward(request, response);
                    break;
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        HttpSession session = request.getSession(false);
        Customer customer = (session == null) ? null : (Customer) session.getAttribute("customer");

        // fail-safe
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        try {
            switch (action) {

                // ===== UPDATE PROFILE =====
                case "update": {
                    String fullName = request.getParameter("fullName");
                    String phone = request.getParameter("phone");
                    String dobStr = request.getParameter("dateOfBirth");
                    String genderStr = request.getParameter("gender");

                    LocalDate dob = null;
                    if (dobStr != null && !dobStr.isEmpty()) {
                        dob = LocalDate.parse(dobStr);
                    }

                    Integer gender = null;
                    if (genderStr != null && !genderStr.equals("0")) {
                        gender = Integer.parseInt(genderStr);
                    }

                    CustomerDAO customerDAO = new CustomerDAO();
                    boolean ok = customerDAO.updateProfile(
                            customer.getCustomerID(),
                            fullName,
                            phone,
                            dob,
                            gender
                    );

                    if (!ok) {
                        request.setAttribute("error", "Update profile failed");
                        request.getRequestDispatcher(
                                "/WEB-INF/views/customer/profile/update-profile.jsp"
                        ).forward(request, response);
                        return;
                    }

                    // refresh session customer
                    Customer fresh
                            = customerDAO.getById(customer.getCustomerID());
                    session.setAttribute("customer", fresh);

                    response.sendRedirect(
                            request.getContextPath() + "/Profile?action=view"
                    );
                    break;
                }

                // ===== CHANGE PASSWORD =====
                case "changePassword": {
                    String currentPw = request.getParameter("currentPassword");
                    String newPw = request.getParameter("newPassword");
                    String confirmPw = request.getParameter("confirmPassword");

                    if (currentPw == null || newPw == null || confirmPw == null
                            || currentPw.isEmpty() || newPw.isEmpty()) {

                        request.setAttribute("error", "Password fields are required");
                        request.getRequestDispatcher(
                                "/WEB-INF/views/customer/profile/change-password.jsp"
                        ).forward(request, response);
                        return;
                    }

                    if (!newPw.equals(confirmPw)) {
                        request.setAttribute("error", "Confirm password does not match");
                        request.getRequestDispatcher(
                                "/WEB-INF/views/customer/profile/change-password.jsp"
                        ).forward(request, response);
                        return;
                    }

                    CustomerDAO customerDAO = new CustomerDAO();
                    String dbHash
                            = customerDAO.getPasswordHashById(customer.getCustomerID());

                    String currentHash = PasswordUtil.md5(currentPw);

                    if (dbHash == null || !dbHash.equals(currentHash)) {
                        request.setAttribute("error", "Current password is incorrect");
                        request.getRequestDispatcher(
                                "/WEB-INF/views/customer/profile/change-password.jsp"
                        ).forward(request, response);
                        return;
                    }

                    String newHash = PasswordUtil.md5(newPw);
                    customerDAO.changePassword(customer.getCustomerID(), newHash);

                    // logout sau khi đổi mật khẩu
                    session.invalidate();
                    response.sendRedirect(request.getContextPath() + "/Login");
                    break;
                }

                default:
                    response.sendRedirect(request.getContextPath() + "/Profile?action=view");
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
