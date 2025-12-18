package controller.account;

import dao.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/ForgotPassword"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/View/account/forgot-password.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        AccountDAO dao = new AccountDAO();
        HttpSession session = request.getSession();

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email is required.");
            request.getRequestDispatcher("WEB-INF/View/account/forgot-password.jsp")
                   .forward(request, response);
            return;
        }

        email = email.trim();

        if (!dao.checkEmailExisted(email)) {
            request.setAttribute("error", "Email does not exist.");
            request.getRequestDispatcher("WEB-INF/View/account/forgot-password.jsp")
                   .forward(request, response);
            return;
        }

        // Lưu email để reset
        session.setAttribute("resetEmail", email);

        response.sendRedirect("ResetPassword");
    }
}
