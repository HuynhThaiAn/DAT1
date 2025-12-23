/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BrandDAO;
import dao.CategoryDAO;
import dao.ProductDAO;
import dao.ProductImageDAO;
import dao.ProductVariantDAO;
import dao.VariantAttributeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Collections;
import java.util.List;
import model.Product;
import model.ProductImage;
import model.ProductVariant;
import model.VariantAttribute;

/**
 *
 * @author Administrator
 */
public class ProductDetailServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ===== Header data (để include header.jsp không bị null) =====
        try {
            CategoryDAO cdao = new CategoryDAO();
            BrandDAO bdao = new BrandDAO();
            request.setAttribute("categoryList", cdao.getAll());
            request.setAttribute("brandList", bdao.getAll());
        } catch (Exception e) {
            request.setAttribute("categoryList", Collections.emptyList());
            request.setAttribute("brandList", Collections.emptyList());
        }

        // ===== Params =====
        int productId;
        try {
            productId = Integer.parseInt(request.getParameter("productId"));
        } catch (Exception ex) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        Integer variantId = null;
        try {
            String v = request.getParameter("variantId");
            if (v != null && !v.trim().isEmpty()) {
                variantId = Integer.parseInt(v);
            }
        } catch (Exception ignore) {
        }

        try {
            ProductDAO pdao = new ProductDAO();
            ProductVariantDAO vdao = new ProductVariantDAO();
            ProductImageDAO idao = new ProductImageDAO();
            VariantAttributeDAO adao = new VariantAttributeDAO();

            Product product = pdao.getById(productId);
            if (product == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            List<ProductVariant> variantList = vdao.getByProductId(productId);
            List<ProductImage> images = idao.getByProductId(productId);

            // chọn variant mặc định
            ProductVariant selectedVariant = null;
            if (variantId != null) {
                for (ProductVariant pv : variantList) {
                    if (pv.getProductVariantID() != null && pv.getProductVariantID().intValue() == variantId.intValue()) {
                        selectedVariant = pv;
                        break;
                    }
                }
            }
            if (selectedVariant == null) {
                // ưu tiên variant active
                for (ProductVariant pv : variantList) {
                    if (Boolean.TRUE.equals(pv.getIsActive())) {
                        selectedVariant = pv;
                        break;
                    }
                }
            }
            if (selectedVariant == null && !variantList.isEmpty()) {
                selectedVariant = variantList.get(0);
            }

            // main image url
            String mainImageUrl = null;
            if (images != null) {
                for (ProductImage img : images) {
                    if (Boolean.TRUE.equals(img.getIsMain())) {
                        mainImageUrl = img.getImageUrl();
                        break;
                    }
                }
                if (mainImageUrl == null && !images.isEmpty()) {
                    mainImageUrl = images.get(0).getImageUrl();
                }
            }

            List<VariantAttribute> attrs = Collections.emptyList();
            if (selectedVariant != null && selectedVariant.getProductVariantID() != null) {
                attrs = adao.getByVariantId(selectedVariant.getProductVariantID());
            }

            request.setAttribute("product", product);
            request.setAttribute("variantList", variantList);
            request.setAttribute("selectedVariant", selectedVariant);
            request.setAttribute("images", images);
            request.setAttribute("mainImageUrl", mainImageUrl);
            request.setAttribute("variantAttributes", attrs);

            request.getRequestDispatcher("/WEB-INF/views/customer/productDetail/productDetail.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Product detail load failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/customer/productDetail/productDetail.jsp")
                    .forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
