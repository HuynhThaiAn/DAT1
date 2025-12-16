package controller.customer;

import dao.ProfileDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Account;
import model.Customer;

@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/UpdateProfile"})
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        // Lấy customer từ session
        Customer cus = (Customer) session.getAttribute("cus");

        // Nếu session chưa có cus thì load lại từ DB theo accountId
        if (cus == null) {
            ProfileDAO profileDAO = new ProfileDAO();
            cus = profileDAO.getCustomerbyID(user.getAccountID()); // hàm này đang query theo AccountID
            if (cus == null) {
                request.setAttribute("errorMessage", "Customer information not found.");
                request.getRequestDispatcher("/WEB-INF/View/error.jsp").forward(request, response);
                return;
            }
            session.setAttribute("cus", cus);
        }

        request.setAttribute("cus", cus);
        request.getRequestDispatcher("/WEB-INF/View/customer/profile/update-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        // id hidden trong form của anh đang là CustomerID
        int customerId = Integer.parseInt(request.getParameter("id"));
        String fullName = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");       // yyyy-MM-dd hoặc rỗng
        String gender = request.getParameter("gender"); // male/female hoặc null

        // normalize rỗng -> null để update không bị lỗi
        if (phone != null && phone.trim().isEmpty()) phone = null;
        if (dob != null && dob.trim().isEmpty()) dob = null;
        if (gender != null && gender.trim().isEmpty()) gender = null;

        ProfileDAO dao = new ProfileDAO();
        boolean ok = dao.updateProfileCustomer(customerId, fullName, phone, dob, gender);

        if (!ok) {
            // load lại cus để hiển thị form không bị null
            Customer cus = dao.getCustomerbyCustomerID(customerId);
            request.setAttribute("cus", cus);
            request.setAttribute("errorMessage", "Update failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/View/customer/profile/update-profile.jsp").forward(request, response);
            return;
        }

        // Update thành công -> refresh session cus
        Customer updated = dao.getCustomerbyCustomerID(customerId);
        session.setAttribute("cus", updated);

        response.sendRedirect(request.getContextPath() + "/ViewProfile?updateSuccess=1");
    }
}