/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.AddressDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Address;
import model.Customer;

/**
 *
 * @author Administrator
 */
public class AddressServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddressServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddressServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        HttpSession session = request.getSession(false);
        Customer customer = (session == null) ? null : (Customer) session.getAttribute("customer");
        if (customer == null) { // fail-safe
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        try {
            AddressDAO dao = new AddressDAO();

            switch (action) {
                case "list": {
                    List<Address> addresses = dao.getByCustomerId(customer.getCustomerID());
                    request.setAttribute("addresses", addresses);
                    request.getRequestDispatcher("/WEB-INF/views/customer/address/ViewShippingAddress.jsp")
                           .forward(request, response);
                    break;
                }

                case "addForm": {
                    request.getRequestDispatcher("/WEB-INF/views/customer/address/AddShippingAddress.jsp")
                           .forward(request, response);
                    break;
                }

                case "editForm": {
                    int addressId = parseInt(request.getParameter("addressId"), 0);
                    if (addressId <= 0) {
                        response.sendRedirect(request.getContextPath() + "/Address?action=list");
                        return;
                    }

                    Address a = dao.getById(addressId);
                    // ownership check
                    if (a == null || a.getCustomerID() == null || !a.getCustomerID().equals(customer.getCustomerID())
                            || (a.getIsActive() != null && !a.getIsActive())) {
                        response.sendRedirect(request.getContextPath() + "/Address?action=list");
                        return;
                    }

                    request.setAttribute("address", a);
                    request.getRequestDispatcher("/WEB-INF/views/customer/address/UpdateShippingAddress.jsp")
                           .forward(request, response);
                    break;
                }

                case "delete": {
                    int addressId = parseInt(request.getParameter("addressId"), 0);
                    if (addressId > 0) {
                        dao.softDelete(addressId, customer.getCustomerID());
                    }
                    response.sendRedirect(request.getContextPath() + "/Address?action=list");
                    break;
                }

                case "setDefault": {
                    int addressId = parseInt(request.getParameter("addressId"), 0);
                    if (addressId > 0) {
                        dao.setDefaultAddress(addressId, customer.getCustomerID());
                    }
                    response.sendRedirect(request.getContextPath() + "/Address?action=list");
                    break;
                }

                default:
                    response.sendRedirect(request.getContextPath() + "/Address?action=list");
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

        HttpSession session = request.getSession(false);
        Customer customer = (session == null) ? null : (Customer) session.getAttribute("customer");
        if (customer == null) { // fail-safe
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        try {
            AddressDAO dao = new AddressDAO();

            switch (action) {
                case "add": {
                    String recipientName = trim(request.getParameter("recipientName"));
                    String phone = trim(request.getParameter("phone"));
                    String province = trim(request.getParameter("province"));
                    String district = trim(request.getParameter("district"));
                    String ward = trim(request.getParameter("ward"));
                    String detailAddress = trim(request.getParameter("detailAddress"));
                    boolean isDefault = request.getParameter("isDefault") != null;

                    String err = validate(recipientName, phone, province, district, ward, detailAddress);
                    if (err != null) {
                        request.setAttribute("err", err);
                        request.getRequestDispatcher("/WEB-INF/views/customer/address/AddShippingAddress.jsp")
                               .forward(request, response);
                        return;
                    }

                    Address a = new Address();
                    a.setCustomerID(customer.getCustomerID());
                    a.setRecipientName(recipientName);
                    a.setPhone(phone);
                    a.setProvince(province);
                    a.setDistrict(district);
                    a.setWard(ward);
                    a.setDetailAddress(detailAddress);
                    a.setIsDefault(isDefault);

                    dao.insert(a);

                    response.sendRedirect(request.getContextPath() + "/Address?action=list");
                    break;
                }

                case "update": {
                    int addressId = parseInt(request.getParameter("addressId"), 0);
                    if (addressId <= 0) {
                        response.sendRedirect(request.getContextPath() + "/Address?action=list");
                        return;
                    }

                    String recipientName = trim(request.getParameter("recipientName"));
                    String phone = trim(request.getParameter("phone"));
                    String province = trim(request.getParameter("province"));
                    String district = trim(request.getParameter("district"));
                    String ward = trim(request.getParameter("ward"));
                    String detailAddress = trim(request.getParameter("detailAddress"));
                    boolean isDefault = request.getParameter("isDefault") != null;

                    String err = validate(recipientName, phone, province, district, ward, detailAddress);
                    if (err != null) {
                        Address exist = dao.getById(addressId);
                        if (exist != null && exist.getCustomerID() != null && exist.getCustomerID().equals(customer.getCustomerID())) {
                            // giữ dữ liệu user vừa nhập
                            exist.setRecipientName(recipientName);
                            exist.setPhone(phone);
                            exist.setProvince(province);
                            exist.setDistrict(district);
                            exist.setWard(ward);
                            exist.setDetailAddress(detailAddress);
                            exist.setIsDefault(isDefault);

                            request.setAttribute("address", exist);
                        }
                        request.setAttribute("err", err);
                        request.getRequestDispatcher("/WEB-INF/views/customer/address/UpdateShippingAddress.jsp")
                               .forward(request, response);
                        return;
                    }

                    // ownership check
                    Address old = dao.getById(addressId);
                    if (old == null || old.getCustomerID() == null || !old.getCustomerID().equals(customer.getCustomerID())
                            || (old.getIsActive() != null && !old.getIsActive())) {
                        response.sendRedirect(request.getContextPath() + "/Address?action=list");
                        return;
                    }

                    Address a = new Address();
                    a.setAddressID(addressId);
                    a.setCustomerID(customer.getCustomerID());
                    a.setRecipientName(recipientName);
                    a.setPhone(phone);
                    a.setProvince(province);
                    a.setDistrict(district);
                    a.setWard(ward);
                    a.setDetailAddress(detailAddress);
                    a.setIsDefault(isDefault);

                    dao.update(a);

                    response.sendRedirect(request.getContextPath() + "/Address?action=list");
                    break;
                }

                default:
                    response.sendRedirect(request.getContextPath() + "/Address?action=list");
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private int parseInt(String raw, int def) {
        try { return Integer.parseInt(raw); } catch (Exception e) { return def; }
    }

    private String trim(String s) {
        return (s == null) ? "" : s.trim();
    }

    private String validate(String recipientName, String phone,
                            String province, String district, String ward,
                            String detailAddress) {

        if (recipientName.isEmpty()) return "RecipientName is required.";
        if (phone.isEmpty()) return "Phone is required.";
        if (province.isEmpty()) return "Province is required.";
        if (district.isEmpty()) return "District is required.";
        if (ward.isEmpty()) return "Ward is required.";
        if (detailAddress.isEmpty()) return "DetailAddress is required.";

        return null;
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
