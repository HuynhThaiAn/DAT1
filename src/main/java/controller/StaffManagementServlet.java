package controller;

import dao.StaffDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.Staff;
import utils.PasswordUtil;

import java.io.IOException;
import java.time.LocalDate;

public class StaffManagementServlet extends HttpServlet {

    private final StaffDAO dao = new StaffDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) action = "list";

        request.setAttribute("currentPage", "StaffManagement");

        try {
            switch (action) {
                case "create":
                    request.getRequestDispatcher("/WEB-INF/views/admin/staff/create.jsp")
                           .forward(request, response);
                    return;

                case "update": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Staff s = dao.getById(id);
                    if (s == null) {
                        response.sendRedirect(request.getContextPath() + "/Admin/StaffManagement?action=list");
                        return;
                    }
                    request.setAttribute("staff", s);
                    request.getRequestDispatcher("/WEB-INF/views/admin/staff/update.jsp")
                           .forward(request, response);
                    return;
                }

                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    dao.softDelete(id);
                    response.sendRedirect(request.getContextPath() + "/Admin/StaffManagement?action=list");
                    return;
                }

                case "list":
                default:
                    request.setAttribute("staffs", dao.getAll());
                    request.getRequestDispatcher("/WEB-INF/views/admin/staff/list.jsp")
                           .forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "";

        request.setAttribute("currentPage", "StaffManagement");

        try {
            switch (action) {
                case "create": {
                    String email = trim(request.getParameter("email"));
                    String password = request.getParameter("password");
                    String fullName = trim(request.getParameter("fullName"));
                    String phone = trim(request.getParameter("phone"));
                    String dobStr = trim(request.getParameter("dateOfBirth"));
                    String genderStr = trim(request.getParameter("gender"));

                    String err = validateStaffInput(email, password, fullName, phone, dobStr, genderStr, true);
                    if (err != null) {
                        request.setAttribute("error", err);
                        request.getRequestDispatcher("/WEB-INF/views/admin/staff/create.jsp")
                               .forward(request, response);
                        return;
                    }

                    if (dao.existsByEmail(email)) {
                        request.setAttribute("error", "Email already exists.");
                        request.getRequestDispatcher("/WEB-INF/views/admin/staff/create.jsp")
                               .forward(request, response);
                        return;
                    }

                    Staff s = new Staff();
                    s.setEmail(email);
                    s.setPasswordHash(PasswordUtil.md5(password));
                    s.setFullName(fullName);
                    s.setPhone(phone);

                    if (dobStr != null && !dobStr.isEmpty()) s.setDateOfBirth(LocalDate.parse(dobStr));
                    if (genderStr != null && !genderStr.isEmpty()) s.setGender(Integer.parseInt(genderStr));

                    s.setRole(1); // default staff

                    dao.insert(s);
                    response.sendRedirect(request.getContextPath() + "/Admin/StaffManagement?action=list");
                    return;
                }

                case "update": {
                    int id = Integer.parseInt(request.getParameter("id"));

                    String email = trim(request.getParameter("email"));
                    String password = request.getParameter("password"); // optional
                    String fullName = trim(request.getParameter("fullName"));
                    String phone = trim(request.getParameter("phone"));
                    String dobStr = trim(request.getParameter("dateOfBirth"));
                    String genderStr = trim(request.getParameter("gender"));

                    String err = validateStaffInput(email, password, fullName, phone, dobStr, genderStr, false);
                    if (err != null) {
                        Staff old = dao.getById(id);
                        request.setAttribute("staff", old);
                        request.setAttribute("error", err);
                        request.getRequestDispatcher("/WEB-INF/views/admin/staff/update.jsp")
                               .forward(request, response);
                        return;
                    }

                    if (dao.existsByEmailExceptId(email, id)) {
                        Staff old = dao.getById(id);
                        request.setAttribute("staff", old);
                        request.setAttribute("error", "Email already exists.");
                        request.getRequestDispatcher("/WEB-INF/views/admin/staff/update.jsp")
                               .forward(request, response);
                        return;
                    }

                    Staff old = dao.getById(id);
                    if (old == null) {
                        response.sendRedirect(request.getContextPath() + "/Admin/StaffManagement?action=list");
                        return;
                    }

                    Staff s = new Staff();
                    s.setStaffID(id);
                    s.setEmail(email);
                    s.setFullName(fullName);
                    s.setPhone(phone);

                    if (dobStr != null && !dobStr.isEmpty()) s.setDateOfBirth(LocalDate.parse(dobStr));
                    else s.setDateOfBirth(null);

                    if (genderStr != null && !genderStr.isEmpty()) s.setGender(Integer.parseInt(genderStr));
                    else s.setGender(null);

                    s.setRole(1); // fixed staff

                    if (password != null && !password.isBlank()) s.setPasswordHash(PasswordUtil.md5(password));
                    else s.setPasswordHash(old.getPasswordHash());

                    dao.update(s);
                    response.sendRedirect(request.getContextPath() + "/Admin/StaffManagement?action=list");
                    return;
                }
            }

            response.sendRedirect(request.getContextPath() + "/Admin/StaffManagement?action=list");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private String validateStaffInput(String email, String password, String fullName,
                                      String phone, String dobStr, String genderStr,
                                      boolean isCreate) {
        if (email == null || email.isEmpty()) return "Email is required.";
        if (!email.matches("^[A-Za-z0-9._%+-]+@datshop\\.com$")) return "Email must end with @datshop.com.";
        if (fullName == null || fullName.isEmpty()) return "Full name is required.";

        if (isCreate) {
            if (password == null || password.isBlank()) return "Password is required.";
            if (password.length() < 6) return "Password must be at least 6 characters.";
        } else {
            if (password != null && !password.isBlank() && password.length() < 6)
                return "Password must be at least 6 characters (if entered).";
        }

        if (phone != null && !phone.isEmpty()) {
            if (!phone.matches("^[0-9+\\-\\s]{8,15}$")) return "Phone format is invalid.";
        }

        if (dobStr != null && !dobStr.isEmpty()) {
            try { LocalDate.parse(dobStr); }
            catch (Exception e) { return "Date of birth is invalid."; }
        }

        if (genderStr != null && !genderStr.isEmpty()) {
            try {
                int g = Integer.parseInt(genderStr);
                if (!(g == 0 || g == 1 || g == 2)) return "Gender is invalid.";
            } catch (Exception e) {
                return "Gender is invalid.";
            }
        }

        return null;
    }

    private String trim(String s) {
        if (s == null) return null;
        s = s.trim();
        return s.isEmpty() ? null : s;
    }
}
