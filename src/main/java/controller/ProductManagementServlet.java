package controller;

import com.cloudinary.utils.ObjectUtils;
import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.*;

import utils.CloudinaryUtil;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@MultipartConfig(
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 20 * 1024 * 1024
)
public class ProductManagementServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final ProductImageDAO imageDAO = new ProductImageDAO();
    private final ProductVariantDAO variantDAO = new ProductVariantDAO();
    private final VariantAttributeDAO attrDAO = new VariantAttributeDAO();

    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final BrandDAO brandDAO = new BrandDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) action = "list";

        request.setAttribute("currentPage", "AdminProduct");

        try {
            switch (action) {
                case "create": {
                    request.setAttribute("categories", categoryDAO.getAll());
                    request.setAttribute("brands", brandDAO.getAll());
                    request.getRequestDispatcher("/WEB-INF/views/admin/product/create.jsp")
                           .forward(request, response);
                    return;
                }

                case "images": {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    Product p = productDAO.getById(productId);
                    if (p == null) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Product?action=list");
                        return;
                    }
                    request.setAttribute("product", p);
                    request.setAttribute("images", imageDAO.getByProductId(productId));
                    request.getRequestDispatcher("/WEB-INF/views/admin/product/images.jsp")
                           .forward(request, response);
                    return;
                }

                case "setMainImage": {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    int imageId = Integer.parseInt(request.getParameter("imageId"));
                    imageDAO.setMain(productId, imageId);
                    response.sendRedirect(request.getContextPath() + "/Admin/Product?action=images&productId=" + productId);
                    return;
                }

                case "deleteImage": {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    int imageId = Integer.parseInt(request.getParameter("imageId"));
                    imageDAO.delete(imageId);
                    response.sendRedirect(request.getContextPath() + "/Admin/Product?action=images&productId=" + productId);
                    return;
                }

                case "variants": {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    Product p = productDAO.getById(productId);
                    if (p == null) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Product?action=list");
                        return;
                    }
                    request.setAttribute("product", p);
                    request.setAttribute("variants", variantDAO.getByProductId(productId));
                    request.getRequestDispatcher("/WEB-INF/views/admin/product/variants.jsp")
                           .forward(request, response);
                    return;
                }

                case "createVariant": {
                    String productId = request.getParameter("productId");
                    request.setAttribute("productId", productId);
                    request.getRequestDispatcher("/WEB-INF/views/admin/product/variant_create.jsp")
                           .forward(request, response);
                    return;
                }

                case "toggleVariant": {
                    int variantId = Integer.parseInt(request.getParameter("variantId"));
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    boolean active = "1".equals(request.getParameter("active"));
                    variantDAO.setActive(variantId, active);
                    response.sendRedirect(request.getContextPath() + "/Admin/Product?action=variants&productId=" + productId);
                    return;
                }

                case "delete": {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    productDAO.softDelete(productId);
                    response.sendRedirect(request.getContextPath() + "/Admin/Product?action=list");
                    return;
                }

                case "list":
                default: {
                    request.setAttribute("products", productDAO.getAll());
                    request.getRequestDispatcher("/WEB-INF/views/admin/product/list.jsp")
                           .forward(request, response);
                    return;
                }
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

        request.setAttribute("currentPage", "AdminProduct");

        try {
            switch (action) {

                // Step 1: create product + upload main image
                case "create": {
                    String name = trim(request.getParameter("productName"));
                    String des = trim(request.getParameter("description"));
                    String categoryIdStr = trim(request.getParameter("categoryId"));
                    String brandIdStr = trim(request.getParameter("brandId"));

                    if (name == null || categoryIdStr == null || brandIdStr == null) {
                        request.setAttribute("error", "ProductName, Category, Brand are required.");
                        request.setAttribute("categories", categoryDAO.getAll());
                        request.setAttribute("brands", brandDAO.getAll());
                        request.getRequestDispatcher("/WEB-INF/views/admin/product/create.jsp")
                               .forward(request, response);
                        return;
                    }

                    Part mainImage = request.getPart("mainImage");
                    if (mainImage == null || mainImage.getSize() == 0) {
                        request.setAttribute("error", "Main image is required.");
                        request.setAttribute("categories", categoryDAO.getAll());
                        request.setAttribute("brands", brandDAO.getAll());
                        request.getRequestDispatcher("/WEB-INF/views/admin/product/create.jsp")
                               .forward(request, response);
                        return;
                    }

                    Product p = new Product();
                    p.setProductName(name);
                    p.setDescription(des);
                    p.setCategoryID(Integer.parseInt(categoryIdStr));
                    p.setBrandID(Integer.parseInt(brandIdStr));

                    int productId = productDAO.insertAndGetId(p);

                    String mainUrl = uploadToCloudinary(mainImage, "DATShop/products/" + productId);
                    imageDAO.insertMainImage(productId, mainUrl);

                    // next step
                    response.sendRedirect(request.getContextPath() + "/Admin/Product?action=images&productId=" + productId);
                    return;
                }

                // Step 2: upload sub images
                case "addImages": {
                    int productId = Integer.parseInt(request.getParameter("productId"));

                    // multiple files: name="subImages"
                    List<Part> parts = (List<Part>) request.getParts();
                    // request.getParts() có cả field khác => lọc theo name
                    for (Part part : request.getParts()) {
                        if (!"subImages".equals(part.getName())) continue;
                        if (part.getSize() == 0) continue;

                        String url = uploadToCloudinary(part, "DATShop/products/" + productId);
                        imageDAO.insert(productId, url, false);
                    }

                    response.sendRedirect(request.getContextPath() + "/Admin/Product?action=images&productId=" + productId);
                    return;
                }

                // Step 3: create variant + attributes (manual), stock default 0
                case "createVariant": {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    String sku = trim(request.getParameter("sku"));
                    String variantName = trim(request.getParameter("variantName"));
                    String priceStr = trim(request.getParameter("price"));
                    boolean isActive = "1".equals(request.getParameter("isActive"));

                    if (sku == null || variantName == null || priceStr == null) {
                        request.setAttribute("error", "SKU, VariantName, Price are required.");
                        request.setAttribute("productId", String.valueOf(productId));
                        request.getRequestDispatcher("/WEB-INF/views/admin/product/variant_create.jsp")
                               .forward(request, response);
                        return;
                    }

                    BigDecimal price;
                    try {
                        price = new BigDecimal(priceStr);
                        if (price.compareTo(BigDecimal.ZERO) < 0) throw new Exception();
                    } catch (Exception ex) {
                        request.setAttribute("error", "Price must be a number >= 0.");
                        request.setAttribute("productId", String.valueOf(productId));
                        request.getRequestDispatcher("/WEB-INF/views/admin/product/variant_create.jsp")
                               .forward(request, response);
                        return;
                    }

                    ProductVariant v = new ProductVariant();
                    v.setProductID(productId);
                    v.setSKU(sku);
                    v.setVariantName(variantName);
                    v.setPrice(price);

                    // stock default = 0
                    v.setStockQuantity(0);

                    v.setIsActive(isActive);

                    int variantId = variantDAO.insertAndGetId(v);

                    // attributes arrays
                    String[] names = request.getParameterValues("attributeName[]");
                    String[] values = request.getParameterValues("attributeValue[]");
                    String[] units = request.getParameterValues("unit[]");

                    if (names != null && values != null) {
                        for (int i = 0; i < names.length; i++) {
                            String an = (names[i] == null ? "" : names[i].trim());
                            String av = (values[i] == null ? "" : values[i].trim());
                            String un = (units != null && i < units.length && units[i] != null) ? units[i].trim() : null;

                            // bỏ dòng rỗng
                            if (an.isEmpty() && av.isEmpty()) continue;
                            if (an.isEmpty() || av.isEmpty()) continue;

                            VariantAttribute a = new VariantAttribute();
                            a.setProductVariantID(variantId);
                            a.setAttributeName(an);
                            a.setAttributeValue(av);
                            a.setUnit(un);

                            attrDAO.insert(a);
                        }
                    }

                    response.sendRedirect(request.getContextPath() + "/Admin/Product?action=variants&productId=" + productId);
                    return;
                }
            }

            response.sendRedirect(request.getContextPath() + "/Admin/Product?action=list");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private String trim(String s) {
        if (s == null) return null;
        s = s.trim();
        return s.isEmpty() ? null : s;
    }

    private String uploadToCloudinary(Part part, String folder) throws Exception {
        if (part == null || part.getSize() == 0) return null;

        byte[] data;
        try (InputStream is = part.getInputStream()) {
            data = is.readAllBytes();
        }

        Map res = CloudinaryUtil.getInstance().uploader().upload(
                data,
                ObjectUtils.asMap(
                        "folder", folder,
                        "resource_type", "image"
                )
        );

        return (String) res.get("secure_url");
    }
}
