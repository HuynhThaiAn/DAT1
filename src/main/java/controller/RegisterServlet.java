/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import model.Customer;
import utils.PasswordUtil;

/**
 *
 * @author Administrator
 */
public class RegisterServlet extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();

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
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
    }

    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String email = val(request.getParameter("email"));
        String fullName = val(request.getParameter("fullName"));
        String phone = val(request.getParameter("phone"));
        String dobStr = val(request.getParameter("dateOfBirth"));
        String genderStr = val(request.getParameter("gender"));
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");

        // giữ lại input khi lỗi
        request.setAttribute("email", email);
        request.setAttribute("fullName", fullName);
        request.setAttribute("phone", phone);
        request.setAttribute("dateOfBirth", dobStr);
        request.setAttribute("gender", genderStr);

        if (email.isBlank() || fullName.isBlank() || password == null || password.isBlank()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ Email, Họ tên, Mật khẩu.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (confirm == null || !password.equals(confirm)) {
            request.setAttribute("error", "Xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        try {
            CustomerDAO dao = new CustomerDAO();

            if (dao.existsByEmail(email)) {
                request.setAttribute("error", "Email đã tồn tại.");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                return;
            }

            Customer c = new Customer();
            c.setEmail(email);
            c.setFullName(fullName);
            c.setPhone(phone);
            c.setPasswordHash(PasswordUtil.md5(password));

            if (!dobStr.isBlank()) {
                try {
                    c.setDateOfBirth(LocalDate.parse(dobStr));
                } catch (Exception ignored) {
                }
            }

            if (!genderStr.isBlank()) {
                try {
                    c.setGender(Integer.parseInt(genderStr));
                } catch (Exception ignored) {
                }
            }

            int newId = dao.insertAndGetId(c);
            Customer customer = dao.getById(newId);

            HttpSession session = request.getSession(true);
            session.setAttribute("customer", customer);

            response.sendRedirect(request.getContextPath() + "/Home");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private String val(String s) {
        return s == null ? "" : s.trim();
    }

}
