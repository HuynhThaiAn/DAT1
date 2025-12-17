package controller;

import dao.StaffDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Staff;
import utils.PasswordUtil;

import java.io.IOException;

@WebServlet(name = "LoginAdminServlet", urlPatterns = {"/LoginAdmin"})
public class LoginAdminServlet extends HttpServlet {

    private final StaffDAO dao = new StaffDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/login-admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email == null || !email.matches("^[A-Za-z0-9._%+-]+@datshop\\.com$")) {
                request.setAttribute("error", "Email must end with @datshop.com");
                request.getRequestDispatcher("/WEB-INF/views/auth/login-admin.jsp").forward(request, response);
                return;
            }

            String hash = PasswordUtil.md5(password);
            Staff s = dao.login(email.trim(), hash);

            if (s == null || s.getRole() == null || s.getRole() != 2) {
                request.setAttribute("error", "Invalid admin account.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login-admin.jsp").forward(request, response);
                return;
            }

            request.getSession().setAttribute("staff", s);
            response.sendRedirect(request.getContextPath() + "/Admin/Product");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
