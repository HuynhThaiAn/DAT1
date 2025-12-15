package controller.customer;

import dao.CartDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.CartItem;

@WebServlet(name = "CartListServlet", urlPatterns = {"/CartList"})
public class CartListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CartDAO dao = new CartDAO();
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        if (action == null) {
            action = "list";
        }

        try {
            int accountId = user.getAccountID();

            if (action.equalsIgnoreCase("list")) {
                List<CartItem> cartItems = dao.getCartItemsByAccountId(accountId);
                request.setAttribute("cartItems", cartItems);

                if (cartItems.isEmpty()) {
                    request.setAttribute("message", "No items found in the cart.");
                }

                request.getRequestDispatcher("/WEB-INF/View/customer/cartManagement/viewCart.jsp")
                       .forward(request, response);

            } else if (action.equalsIgnoreCase("shop")) {
                request.getRequestDispatcher("/WEB-INF/View/customer/homePage/homePage.jsp")
                       .forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid Account ID.");
            request.getRequestDispatcher("/WEB-INF/View/customer/cartManagement/viewCart.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        String action = request.getParameter("action");

        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        try {
            if ("saveSelectedItems".equals(action)) {
                String selectedCartItemIds = request.getParameter("selectedCartItemIds");
                session.setAttribute("selectedCartItemIds", selectedCartItemIds);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("Selected items saved");
                return;
            }

            // nếu có action khác POST tới đây (không dùng) thì trả lỗi
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("invalid_action");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("error");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for listing cart items by AccountID";
    }
}
