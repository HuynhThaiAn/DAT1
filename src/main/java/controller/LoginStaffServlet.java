package controller;

import dao.StaffDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Staff;
import utils.PasswordUtil;

import java.io.IOException;

@WebServlet(name = "LoginStaffServlet", urlPatterns = {"/LoginStaff"})
public class LoginStaffServlet extends HttpServlet {

    private final StaffDAO dao = new StaffDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/login-staff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email == null || !email.matches("^[A-Za-z0-9._%+-]+@datshop\\.com$")) {
                request.setAttribute("error", "Email must end with @datshop.com");
                request.getRequestDispatcher("/WEB-INF/views/auth/login-staff.jsp").forward(request, response);
                return;
            }

            String hash = PasswordUtil.md5(password);
            Staff s = dao.login(email.trim(), hash);

            if (s == null || s.getRole() == null || (s.getRole() != 1 && s.getRole() != 2)) {
                request.setAttribute("error", "Invalid staff account.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login-staff.jsp").forward(request, response);
                return;
            }

            request.getSession().setAttribute("staff", s);

            // staff vào trang staff, admin vẫn có thể login qua staff cũng được
            if (s.getRole() == 2) response.sendRedirect(request.getContextPath() + "/AdminDashboard");
            else response.sendRedirect(request.getContextPath() + "/StaffDashboard");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
