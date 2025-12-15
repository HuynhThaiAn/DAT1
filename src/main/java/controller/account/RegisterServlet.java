package controller.account;

import dao.AccountDAO;
import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import model.Category;
//import utils.EmailService;
//import utils.OTPManager;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/Register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categoryList = categoryDAO.getAllCategory();
        request.setAttribute("categoryList", categoryList);
        request.getRequestDispatcher("WEB-INF/View/account/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // 1. Validate password
        if (password == null || password.length() < 9) {
            request.setAttribute("error", "Password must be at least 9 characters long.");
            forwardBack(request, response, phone, fullName, email);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Password and Confirm Password do not match.");
            forwardBack(request, response, phone, fullName, email);
            return;
        }

        AccountDAO dao = new AccountDAO();

        // 2. Check email tồn tại
        if (dao.checkEmailExisted(email)) {
            request.setAttribute("error", "This email is already registered.");
            forwardBack(request, response, phone, fullName, email);
            return;
        }

//        // 3. Tạo OTP, lưu session + gửi mail
//        HttpSession session = request.getSession();
//
//        // Sinh mã OTP 6 số
//        int code = EmailService.generateVerificationCode();
//
//        // Tạo OTPManager, OTP hết hạn sau 5 phút
//        OTPManager otpManager = new OTPManager(code, 5);
//
//        // Lưu vào session để VerifyOTPServlet dùng
//        session.setAttribute("otpManager", otpManager);
//        session.setAttribute("otpPurpose", "register");
//        session.setAttribute("tempEmail", email);
//        session.setAttribute("tempPassword", password);  // sẽ hash trong Verify
//        session.setAttribute("tempFullName", fullName);
//        session.setAttribute("tempPhone", phone);

//        // Gửi email OTP
//        boolean sent = false;
//        try {
//            sent = EmailService.sendOTPEmail(email, code, "REGISTER");
//        } catch (UnsupportedEncodingException e) {
//            e.printStackTrace();
//        }
//
//        if (!sent) {
//            request.setAttribute("error", "Cannot send OTP email. Please try again later.");
//            forwardBack(request, response, phone, fullName, email);
//            return;
//        }
//
//        // 4. Chuyển sang trang nhập OTP
//        response.sendRedirect("Verify");
}

    // Hàm giữ lại data khi lỗi
    private void forwardBack(HttpServletRequest req, HttpServletResponse res,
                             String phone, String fullName, String email)
            throws ServletException, IOException {

        req.setAttribute("phone", phone);
        req.setAttribute("fullName", fullName);
        req.setAttribute("email", email);
        req.getRequestDispatcher("WEB-INF/View/account/register.jsp").forward(req, res);
    }

//    @Override
//    public String getServletInfo() {
//        return "Register with OTP verification";
//    }
}
