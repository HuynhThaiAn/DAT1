package controller;

import dao.CartDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.CartItem;

@WebServlet(name = "UpdateCartServlet", urlPatterns = {"/UpdateCart"})
public class UpdateCartServlet extends HttpServlet {

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/plain;charset=UTF-8");

        try {
            String action = req.getParameter("action");
            String idRaw  = req.getParameter("cartItemId");
            String qtyRaw = req.getParameter("quantity");

            if (action == null || !"update".equals(action) || idRaw == null || qtyRaw == null) {
                resp.getWriter().write("error");
                return;
            }

            int id  = Integer.parseInt(idRaw);
            int qty = Math.max(1, Integer.parseInt(qtyRaw)); // không cho < 1

            CartDAO dao = new CartDAO();
            CartItem item = dao.getCartItemById(id);

            if (item == null) {
                resp.getWriter().write("error");
                return;
            }

            // ✅ check tồn kho theo nhập-xuất
            boolean enough = dao.getProductQuantityLeft(item.getProductID(), qty);
            if (!enough) {
                resp.getWriter().write("out_of_stock");
                return;
            }

            boolean updated = dao.updateCartItemQuantity(id, qty);
            resp.getWriter().write(updated ? "success" : "error");

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        processRequest(req, resp);
    }
}
