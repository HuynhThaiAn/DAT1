
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dao.CategoryDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminDeleteProductServlet", urlPatterns = {"/AdminDeleteProduct"})
public class AdminDeleteProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            ProductDAO proDAO = new ProductDAO();
            boolean isSuccess = proDAO.deleteProduct(productId);

            if (isSuccess) {
                response.sendRedirect("AdminProduct?success=1");
            } else {
                response.sendRedirect("AdminProduct?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminProduct?error=1");
        }
    }
}
