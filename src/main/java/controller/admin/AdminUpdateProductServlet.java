/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import dao.BrandDAO;
import dao.CategoryDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Brand;
import model.Category;
import model.CategoryDetail;
import model.CategoryDetailGroup;
import model.Product;
import model.ProductDetail;

@MultipartConfig
@WebServlet(name = "AdminUpdateProductServlet", urlPatterns = {"/AdminUpdateProduct"})
public class AdminUpdateProductServlet extends HttpServlet {

    private Cloudinary cloudinary;

    @Override
    public void init() {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dgnyskpc3",
                "api_key", "398517693378845",
                "api_secret", "ho0bvkCgpHDBFoUW3M9bG8apAKk",
                "secure", true
        ));
    }

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
            out.println("<title>Servlet StaffUpdateInfoServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffUpdateInfoServlet at " + request.getContextPath() + "</h1>");
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

        String productIdString = request.getParameter("productId");

        int productId = ((productIdString != null) ? Integer.parseInt(productIdString) : -1);

        if (productId != -1) {

            ProductDAO proDao = new ProductDAO();
            CategoryDAO cateDao = new CategoryDAO();
            BrandDAO brandDao = new BrandDAO();

            List<Category> categoryList = cateDao.getAllCategory();
            List<Brand> brandList = brandDao.getAllBrand();
            Product product = proDao.getProductById(productId);

            List<ProductDetail> productDetailList = proDao.getProductDetailById(productId);
            List<CategoryDetailGroup> categoryGroupList = cateDao.getCategoryDetailGroupById(product.getCategoryId());
            List<CategoryDetail> categporyDetailList = cateDao.getCategoryDetailById(product.getCategoryId());

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("brandList", brandList);
            request.setAttribute("product", product);
            request.setAttribute("productDetailList", productDetailList);
            request.setAttribute("categoryGroupList", categoryGroupList);
            request.setAttribute("categoryDetailList", categporyDetailList);
            request.setAttribute("productId", productId);

            request.getRequestDispatcher("/WEB-INF/View/admin/productManagement/updateProduct/updateProduct.jsp").forward(request, response);
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

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        ProductDAO proDAO = new ProductDAO();

        // ===== 1) Read + validate basic fields =====
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            response.sendRedirect("AdminProductList?error=missing_id");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect("AdminProductList?error=invalid_id");
            return;
        }

        String productName = request.getParameter("productName");
        if (productName == null) {
            productName = "";
        }
        productName = productName.trim();

        String priceFormatted = request.getParameter("price");
        if (priceFormatted == null || priceFormatted.isBlank()) {
            response.sendRedirect("AdminUpdateProduct?productId=" + id + "&error=missing_price");
            return;
        }

        priceFormatted = priceFormatted.replace(".", "")
                .replace("₫", "")
                .replace(",", "")
                .trim();

        BigDecimal price;
        try {
            price = new BigDecimal(priceFormatted);
        } catch (NumberFormatException e) {
            response.sendRedirect("AdminUpdateProduct?productId=" + id + "&error=invalid_price");
            return;
        }

        String catStr = request.getParameter("category");
        String brandStr = request.getParameter("brand");

        if (catStr == null || catStr.isBlank() || brandStr == null || brandStr.isBlank()) {

            response.sendRedirect("AdminUpdateProduct?productId=" + id + "&error=missing_category_brand");
            return;
        }

        int categoryId, brandId;
        try {
            categoryId = Integer.parseInt(catStr.trim());
            brandId = Integer.parseInt(brandStr.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect("AdminUpdateProduct?productId=" + id + "&error=invalid_category_brand");
            return;
        }

        boolean isFeatured = request.getParameter("isFeatured") != null;
        boolean isBestSeller = request.getParameter("isBestSeller") != null;
        boolean isNew = request.getParameter("isNew") != null;
        boolean isActive = request.getParameter("isActive") != null;

        Product current = proDAO.getProductByID(id);
        if (current == null) {
            response.sendRedirect("AdminProductList?error=product_not_found");
            return;
        }
        int supplierId = current.getSupplierId();

        // ===== 3) Image handling  =====
        ProductDetail productDetail = proDAO.getOneProductDetailById(id);

        Map<String, String> imageUrlMap = new LinkedHashMap<>();
        imageUrlMap.put("fileMain", current.getImageUrl());
        imageUrlMap.put("file1", (productDetail != null ? productDetail.getImageUrl1() : null));
        imageUrlMap.put("file2", (productDetail != null ? productDetail.getImageUrl2() : null));
        imageUrlMap.put("file3", (productDetail != null ? productDetail.getImageUrl3() : null));
        imageUrlMap.put("file4", (productDetail != null ? productDetail.getImageUrl4() : null));

        for (String key : imageUrlMap.keySet()) {
            Part part = request.getPart(key);
            if (part != null && part.getSize() > 0) {
                try ( InputStream is = part.getInputStream();  ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {

                    byte[] data = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = is.read(data)) != -1) {
                        buffer.write(data, 0, bytesRead);
                    }

                    Map uploadResult = cloudinary.uploader().upload(
                            buffer.toByteArray(),
                            ObjectUtils.asMap("resource_type", "auto")
                    );

                    String url = (String) uploadResult.get("secure_url");
                    if (url != null && !url.isBlank()) {
                        imageUrlMap.put(key, url);
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    response.sendRedirect("AdminUpdateProduct?productId=" + id + "&error=upload_failed");
                    return;
                }
            }
        }

        // ===== 4) Update product info =====
        boolean res = proDAO.updateProductInfo(
                id,
                productName,
                price,
                supplierId,
                categoryId,
                brandId,
                isFeatured,
                isBestSeller,
                isNew,
                isActive,
                imageUrlMap.get("fileMain")
        );

        // ===== 5) Update product details=====
        List<ProductDetail> productDetailList = proDAO.getProductDetailById(id);
        if (productDetailList != null) {
            for (ProductDetail proDetail : productDetailList) {
                String paramName = "attribute_" + proDetail.getCategoryDetailID();
                String value = request.getParameter(paramName);

                if (value != null && !value.trim().isEmpty()) {
                    boolean ok = proDAO.updateProductDetail(
                            id,
                            proDetail.getCategoryDetailID(),
                            value.trim(),
                            imageUrlMap.get("file1"),
                            imageUrlMap.get("file2"),
                            imageUrlMap.get("file3"),
                            imageUrlMap.get("file4"),
                            imageUrlMap.get("fileMain")
                    );
                    res = res && ok;
                }
            }
        }

        // ===== 6) Redirect =====
        if (res) {
            response.sendRedirect(request.getContextPath() + "/AdminProductList?success=update_ok");
        } else {
            response.sendRedirect(request.getContextPath() + "/AdminUpdateProduct?productId=" + id + "&error=update_failed");
        }
        return;

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
