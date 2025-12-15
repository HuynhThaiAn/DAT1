package controller;

import dao.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.*;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        Customer customer = (Customer) session.getAttribute("cus");

        String action = request.getParameter("action");
        if (action == null) {
            action = "checkout";
        }

        if (user == null || customer == null) {
            response.sendRedirect("Login");
            return;
        }

        // ✅ Chỉ cho phép checkout, bỏ voucher
        if (!action.equalsIgnoreCase("checkout")) {
            response.sendRedirect("CheckoutServlet?action=checkout");
            return;
        }

        String selectedIdsParam = request.getParameter("selectedCartItemIds");
        List<CartItem> selectedItems = new ArrayList<>();

        if (selectedIdsParam != null && !selectedIdsParam.trim().isEmpty()) {
            String[] idArray = selectedIdsParam.split(",");
            CartDAO cartDAO = new CartDAO();

            for (String idStr : idArray) {
                try {
                    int cartItemId = Integer.parseInt(idStr.trim());
                    CartItem item = cartDAO.getCartItemById(cartItemId);
                    if (item != null && item.getProduct() != null) {
                        selectedItems.add(item);
                    }
                } catch (NumberFormatException e) {
                    Logger.getLogger(CheckoutServlet.class.getName())
                            .log(Level.WARNING, "Invalid cartItemId: {0}", idStr);
                }
            }
        }

        if (selectedItems.isEmpty()) {
            session.setAttribute("message", "No product is chosen to pay.");
            request.getRequestDispatcher("/WEB-INF/View/customer/cartManagement/viewCart.jsp")
                    .forward(request, response);
            return;
        }

        AddressDAO addressDAO = new AddressDAO();
        List<Address> addresses = addressDAO.getAddressesByCustomerId(customer.getId());

        if (addresses == null || addresses.isEmpty()) {
            session.setAttribute("message", "No address found. Please add a new address.");
            response.sendRedirect("AddAddress");
            return;
        }

        Address selectedAddress = (Address) session.getAttribute("selectedAddress");
        if (selectedAddress == null) {
            selectedAddress = addressDAO.getDefaultAddressByCustomerId(customer.getId());
            if (selectedAddress != null) {
                session.setAttribute("selectedAddress", selectedAddress);
                Logger.getLogger(CheckoutServlet.class.getName()).log(Level.INFO,
                        "Default address found for CustomerID {0}: {1}",
                        new Object[]{customer.getId(), selectedAddress.getAddressDetails()});
            } else {
                Logger.getLogger(CheckoutServlet.class.getName()).log(Level.WARNING,
                        "No default address found for CustomerID: {0}", customer.getId());
            }
        }

        long totalAmount = calculateTotalAmount(selectedItems);

        session.setAttribute("totalAmount", totalAmount);
        session.setAttribute("selectedItems", selectedItems);
        session.setAttribute("selectedCartItemIds", selectedIdsParam);

        request.setAttribute("selectedItems", selectedItems);
        request.setAttribute("defaultAddress", selectedAddress);

        request.getRequestDispatcher("/WEB-INF/View/customer/cartManagement/checkout.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        Customer customer = (Customer) session.getAttribute("cus");

        CartDAO cartDAO = new CartDAO();
        OrderDAO orderDAO = new OrderDAO();
        OrderDetailDAO orderDetailsDAO = new OrderDetailDAO();
        PaymentsDAO paymentsDAO = new PaymentsDAO();

        if (user == null || customer == null) {
            response.sendRedirect("Login");
            return;
        }

        String selectedIdsParam = request.getParameter("selectedCartItemIds");
        List<CartItem> selectedItems = new ArrayList<>();

        if (selectedIdsParam != null && !selectedIdsParam.trim().isEmpty()) {
            String[] idArray = selectedIdsParam.split(",");
            for (String idStr : idArray) {
                try {
                    int cartItemId = Integer.parseInt(idStr.trim());
                    CartItem item = cartDAO.getCartItemById(cartItemId);
                    if (item != null && item.getProduct() != null) {
                        selectedItems.add(item);
                    }
                } catch (NumberFormatException e) {
                    Logger.getLogger(CheckoutServlet.class.getName())
                            .log(Level.WARNING, "Invalid cartItemId: {0}", idStr);
                }
            }
        }

        if (selectedItems.isEmpty()) {
            session.setAttribute("message", "No product is chosen to pay.");
            response.sendRedirect("CheckoutServlet?selectedCartItemIds=" + (selectedIdsParam != null ? selectedIdsParam : ""));
            return;
        }

        // ✅ Check tồn kho trước khi tạo đơn
        try {
            for (CartItem item : selectedItems) {
                int productId = item.getProductID();
                int requiredQuantity = item.getQuantity();

                if (!cartDAO.getProductQuantityLeft(productId, requiredQuantity)) {
                    String productName = (item.getProduct() != null && item.getProduct().getProductName() != null)
                            ? item.getProduct().getProductName()
                            : String.valueOf(productId);

                    session.setAttribute("message",
                            "Sản phẩm \"" + productName + "\" đã hết hàng hoặc không đủ số lượng để thanh toán.");

                    response.sendRedirect("CartList?accountId=" + user.getAccountID() + "&checkquantity=1");
                    return;
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE,
                    "Error checking stock before checkout: {0}", e.getMessage());
            session.setAttribute("message", "Có lỗi khi kiểm tra tồn kho. Vui lòng thử lại sau.");
            response.sendRedirect("CartList?accountId=" + user.getAccountID());
            return;
        }

        try {
            // Get form data
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String addressIdStr = request.getParameter("addressId");
            String totalAmountStr = request.getParameter("totalAmount");

            // Validate input
            if (fullName == null || fullName.trim().isEmpty()) {
                throw new IllegalArgumentException("Full name is required.");
            }
            if (phone == null || phone.trim().isEmpty()) {
                throw new IllegalArgumentException("Phone number is required.");
            }
            if (addressIdStr == null || addressIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Address ID is required.");
            }
            if (totalAmountStr == null || totalAmountStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Total amount is required.");
            }

            int addressId;
            try {
                addressId = Integer.parseInt(addressIdStr);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Invalid Address ID: " + addressIdStr);
            }

            AddressDAO addressDAO = new AddressDAO();
            Address address = addressDAO.getAddressById(addressId);
            if (address == null) {
                throw new IllegalArgumentException("Invalid Address ID: " + addressIdStr);
            }

            String addressSnapshot = address.getProvinceName() + ", "
                    + address.getDistrictName() + ", "
                    + address.getWardName() + ", "
                    + address.getAddressDetails();

            long totalAmount;
            try {
                totalAmount = Long.parseLong(totalAmountStr);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Invalid total amount: " + totalAmountStr);
            }

            // Validate totalAmount with server calculation
            long calculatedTotal = calculateTotalAmount(selectedItems);
            if (calculatedTotal != totalAmount) {
                session.setAttribute("message",
                        "The total amount does not match the product list. Expected: " + calculatedTotal + ", Received: " + totalAmount);
                response.sendRedirect("CheckoutServlet?selectedCartItemIds=" + (selectedIdsParam != null ? selectedIdsParam : ""));
                return;
            }

            if (customer.getId() <= 0) {
                session.setAttribute("message", "Customer information is invalid.");
                response.sendRedirect("Login");
                return;
            }

            // ✅ VAT 8%
            BigDecimal finalTotalAmount = BigDecimal.valueOf(totalAmount);
            BigDecimal vatRate = new BigDecimal("1.08");
            finalTotalAmount = finalTotalAmount.multiply(vatRate).setScale(0, BigDecimal.ROUND_HALF_UP);

            // Prepare order data
            String orderDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
            String deliveredDate = null;
            int status = 1; // Processing
            int discount = 0; // ✅ bỏ voucher => discount = 0

            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.INFO,
                    "Order data: CustomerID={0}, FullName={1}, Phone={2}, AddressID={3}, AddressSnapshot={4}, OrderDate={5}, TotalAmount={6}, Discount={7}, FinalTotalWithVAT={8}",
                    new Object[]{customer.getId(), fullName, phone, addressId, addressSnapshot, orderDate, totalAmount, discount, finalTotalAmount});

            int orderID = orderDAO.createOrder(customer.getId(), fullName, addressSnapshot, phone,
                    orderDate, deliveredDate, status, finalTotalAmount.longValue(), discount, addressId);

            if (orderID <= 0) {
                session.setAttribute("message", "Unable to create order! Please check the information.");
                response.sendRedirect("CheckoutServlet?selectedCartItemIds=" + (selectedIdsParam != null ? selectedIdsParam : ""));
                return;
            }

            boolean orderDetailsSuccess = orderDetailsDAO.addOrderDetails(orderID, selectedItems);
            if (!orderDetailsSuccess) {
                session.setAttribute("message", "Error adding order details!");
                response.sendRedirect("CheckoutServlet?selectedCartItemIds=" + (selectedIdsParam != null ? selectedIdsParam : ""));
                return;
            }

            boolean paymentSuccess = paymentsDAO.addPayment(orderID, finalTotalAmount.longValue(), "COD", "PENDING");
            if (!paymentSuccess) {
                session.setAttribute("message", "Error adding payment information!");
                response.sendRedirect("CheckoutServlet?selectedCartItemIds=" + (selectedIdsParam != null ? selectedIdsParam : ""));
                return;
            }

            // Delete cart items
            List<Integer> cartItemIds = new ArrayList<>();
            for (CartItem item : selectedItems) {
                cartItemIds.add(item.getCartItemID());
            }

            boolean cartItemsDeleted = cartDAO.deleteMultipleCartItemsByIntegerIds(cartItemIds);
            if (!cartItemsDeleted) {
                session.setAttribute("message", "Error deleting products from cart!");
                response.sendRedirect("CheckoutServlet?selectedCartItemIds=" + (selectedIdsParam != null ? selectedIdsParam : ""));
                return;
            }

            // ✅ Update stock (trừ thẳng stock trong Products)
            for (CartItem item : selectedItems) {
                int productId = item.getProductID();
                int quantity = item.getQuantity();

                int currentStock = 0;
                try ( PreparedStatement ps = cartDAO.conn.prepareStatement(
                        "SELECT Stock FROM Products WHERE ProductID = ?")) {
                    ps.setInt(1, productId);
                    try ( ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            currentStock = rs.getInt("Stock");
                        }
                    }
                }

                int newStock = Math.max(currentStock - quantity, 0);
                cartDAO.updateProductStock(productId, newStock);
            }

            // Clear session attributes (giữ lại những gì cần)
            session.removeAttribute("selectedItems");
            session.removeAttribute("selectedCartItemIds");

            DecimalFormat df = new DecimalFormat("#,###");
            String formattedFinalTotal = df.format(finalTotalAmount);

            session.setAttribute("message", "Order placed successfully! Total with VAT: " + formattedFinalTotal + " VND.");
            response.sendRedirect("ViewOrderOfCustomer");

        } catch (NumberFormatException e) {
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, "Invalid input data: {0}", e.getMessage());
            session.setAttribute("message", "Invalid input data: " + e.getMessage());
            response.sendRedirect("CheckoutServlet?selectedCartItemIds=" + (selectedIdsParam != null ? selectedIdsParam : ""));
        } catch (IllegalArgumentException e) {
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, "Validation error: {0}", e.getMessage());
            session.setAttribute("message", "Validation error: " + e.getMessage());
            response.sendRedirect("CheckoutServlet?selectedCartItemIds=" + (selectedIdsParam != null ? selectedIdsParam : ""));
        } catch (Exception e) {
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, "Error processing order: {0}", e.getMessage());
            session.setAttribute("message", "Error processing order: " + e.getMessage());
            response.sendRedirect("CheckoutServlet?selectedCartItemIds=" + (selectedIdsParam != null ? selectedIdsParam : ""));
        }
    }

    private long calculateTotalAmount(List<CartItem> cartItems) {
        long totalAmount = 0;
        if (cartItems != null && !cartItems.isEmpty()) {
            for (CartItem item : cartItems) {
                Product product = item.getProduct();
                if (product != null) {
                    BigDecimal unitPrice = product.getPrice();
                    BigDecimal discount = BigDecimal.valueOf(product.getDiscount());
                    BigDecimal discountFactor = BigDecimal.ONE.subtract(
                            discount.divide(BigDecimal.valueOf(100), 2, BigDecimal.ROUND_HALF_UP)
                    );
                    BigDecimal discountedPrice = unitPrice.multiply(discountFactor);
                    BigDecimal itemTotal = discountedPrice.multiply(BigDecimal.valueOf(item.getQuantity()));
                    totalAmount += itemTotal.longValue();
                }
            }
        }
        return totalAmount;
    }
}
