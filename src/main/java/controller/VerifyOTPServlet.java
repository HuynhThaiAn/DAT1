//package controller;
//
//import dao.AccountDAO;
//import java.io.IOException;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import utils.EmailService;
//import utils.OTPManager;
//
//@WebServlet(name = "VerifyOTPServlet", urlPatterns = {"/Verify"})
//public class VerifyOTPServlet extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        request.getRequestDispatcher("WEB-INF/View/account/verify.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession();
//        OTPManager otpManager = (OTPManager) session.getAttribute("otpManager");
//        String otpPurpose = (String) session.getAttribute("otpPurpose");
//
//        if (otpManager == null || otpPurpose == null) {
//            request.setAttribute("error", "OTP session not found. Please start again.");
//            request.getRequestDispatcher("WEB-INF/View/account/register.jsp").forward(request, response);
//            return;
//        }
//
//        String email = null;
//        String password = null;
//
//        // Xác định dữ liệu theo mục đích OTP
//        if ("register".equals(otpPurpose)) {
//            email = (String) session.getAttribute("tempEmail");
//            password = (String) session.getAttribute("tempPassword");
//        } else if ("forgot".equals(otpPurpose)) {
//            email = (String) session.getAttribute("resetEmail");
//        }
//
//        // Kiểm tra email null
//        if (email == null) {
//            request.setAttribute("error", "Không tìm thấy thông tin email. Vui lòng đăng ký lại.");
//            request.getRequestDispatcher("WEB-INF/View/account/register.jsp").forward(request, response);
//            return;
//        }
//
//        // Kiểm tra OTP nhập
//        int enteredOtp;
//        try {
//            enteredOtp = Integer.parseInt(request.getParameter("otp"));
//        } catch (Exception e) {
//            request.setAttribute("error", "Invalid OTP format.");
//            request.getRequestDispatcher("WEB-INF/View/account/verify.jsp").forward(request, response);
//            return;
//        }
//
//        // Hết hạn OTP?
//        if (otpManager.isExpired()) {
//            request.setAttribute("error", "Your OTP has expired. Please request a new one.");
//            request.getRequestDispatcher("WEB-INF/View/account/verify.jsp").forward(request, response);
//            return;
//        }
//
//        // Sai OTP?
//        if (enteredOtp != otpManager.getOtpCode()) {
//            request.setAttribute("error", "Incorrect OTP.");
//            request.getRequestDispatcher("WEB-INF/View/account/verify.jsp").forward(request, response);
//            return;
//        }
//
//        // Debug log
//        System.out.println("=================================");
//        System.out.println("Email: " + email);
//        System.out.println("OTP nhập: " + enteredOtp);
//        System.out.println("OTP đúng: " + otpManager.getOtpCode());
//        System.out.println("Purpose: " + otpPurpose);
//        System.out.println("=================================");
//
//        // Nếu verify thành công → Reset resendCount
//        otpManager.setResendCount(0);
//
//        AccountDAO dao = new AccountDAO();
//
//        if ("register".equals(otpPurpose)) {
//            String fullName = (String) session.getAttribute("tempFullName");
//            String phone = (String) session.getAttribute("tempPhone");
//
//            boolean success = dao.addNewAccount(
//                    email,
//                    dao.hashMD5(password),
//                    fullName,
//                    phone
//            );
//
//            if (!success) {
//                request.setAttribute("error", "Account creation failed.");
//                request.getRequestDispatcher("WEB-INF/View/account/verify.jsp").forward(request, response);
//                return;
//            }
//
//            // Xoá session tạm
//            session.removeAttribute("otpManager");
//            session.removeAttribute("tempEmail");
//            session.removeAttribute("tempPassword");
//            session.removeAttribute("tempPhone");
//            session.removeAttribute("tempFullName");
//            session.removeAttribute("otpPurpose");
//
//            EmailService.sendSuccessEmail(email);
//            response.sendRedirect("Login");
//        } else if ("forgot".equals(otpPurpose)) {
//            // Đánh dấu verify OTP thành công và chuyển sang Reset Password
//            session.setAttribute("otpVerified", true);
//            session.removeAttribute("otpManager");
//            session.removeAttribute("otpPurpose");
//
//            response.sendRedirect("ResetPassword");
//        }
//    }
//}
