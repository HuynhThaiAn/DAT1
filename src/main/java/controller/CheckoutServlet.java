package controller;

import dao.AddressDAO;
import dao.CartDAO;
import dao.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import model.Address;
import model.CartViewItem;
import model.Customer;

public class CheckoutServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final AddressDAO addressDAO = new AddressDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Customer customer = (Customer) request.getSession().getAttribute("customer");
            if (customer == null) {
                response.sendRedirect(request.getContextPath() + "/Login");
                return;
            }

            int customerId = customer.getCustomerID();

            List<CartViewItem> cartItems = cartDAO.getCartViewItems(customerId);
            if (cartItems == null) cartItems = new ArrayList<>();

            BigDecimal total = BigDecimal.ZERO;
            for (CartViewItem it : cartItems) {
                if (it.getPrice() != null && it.getQuantity() != null) {
                    total = total.add(it.getPrice().multiply(BigDecimal.valueOf(it.getQuantity())));
                }
            }

            List<Address> addresses = addressDAO.getByCustomerId(customerId);

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", total);
            request.setAttribute("addresses", addresses);

            request.getRequestDispatcher("/WEB-INF/views/customer/checkout/checkout.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "placeOrder";

        if (!"placeOrder".equals(action)) {
            response.sendRedirect(request.getContextPath() + "/Checkout");
            return;
        }

        try {
            Customer customer = (Customer) request.getSession().getAttribute("customer");
            if (customer == null) {
                response.sendRedirect(request.getContextPath() + "/Login");
                return;
            }

            int customerId = customer.getCustomerID();

            int addressId = parseInt(request.getParameter("addressId"), -1);
            String receiverName = request.getParameter("receiverName");
            String phone = request.getParameter("phone");
            String note = request.getParameter("note");

            // NEW: payment method
            // 1=COD, 2=Bank, 3=Online (bạn có thể đổi quy ước, nhưng JSP phải gửi đúng)
            int paymentMethod = parseInt(request.getParameter("paymentMethod"), 1);

            if (addressId <= 0
                    || receiverName == null || receiverName.trim().isEmpty()
                    || phone == null || phone.trim().isEmpty()) {

                request.setAttribute("error", "Vui lòng chọn địa chỉ và nhập ReceiverName/Phone.");
                doGet(request, response);
                return;
            }

            List<CartViewItem> cartItems = cartDAO.getCartViewItems(customerId);
            if (cartItems == null || cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/Cart?action=view");
                return;
            }

            // NEW: create order + payment in transaction
            int orderId = orderDAO.createOrderFromCart(
                    customerId,
                    addressId,
                    receiverName.trim(),
                    phone.trim(),
                    note,
                    paymentMethod,
                    cartItems
            );

            // YÊU CẦU BẠN: placeOrder xong quay về Home
            response.sendRedirect(request.getContextPath() + "/Home");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private int parseInt(String s, int def) {
        try {
            if (s == null) return def;
            return Integer.parseInt(s.trim());
        } catch (Exception e) {
            return def;
        }
    }

    @Override
    public String getServletInfo() {
        return "Checkout servlet";
    }
}

