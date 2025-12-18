package controller.account;

import dao.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/ResetPassword"})
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");

        // Nếu chưa qua Forgot Password
        if (email == null) {
            response.sendRedirect("ForgotPassword");
            return;
        }

        request.getRequestDispatcher("WEB-INF/View/account/reset-password.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");

        if (email == null) {
            response.sendRedirect("ForgotPassword");
            return;
        }

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate password
        if (newPassword == null || newPassword.length() < 9) {
            request.setAttribute("error", "Password must be at least 9 characters long.");
            request.getRequestDispatcher("WEB-INF/View/account/reset-password.jsp")
                    .forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("WEB-INF/View/account/reset-password.jsp")
                    .forward(request, response);
            return;
        }

        AccountDAO dao = new AccountDAO();
        String hashedPassword = dao.hashMD5(newPassword);

        boolean updated = dao.updatePassword(email, hashedPassword);

        if (updated) {
            // Clear session
            session.removeAttribute("resetEmail");

            // Thông báo sau login
            session.setAttribute("message",
                    "Password reset successfully. Please login.");

            response.sendRedirect("Login");
        } else {
            request.setAttribute("error",
                    "Failed to reset password. Please try again.");
            request.getRequestDispatcher("WEB-INF/View/account/reset-password.jsp")
                    .forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Reset password without OTP";
    }
}
