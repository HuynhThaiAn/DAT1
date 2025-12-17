/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import com.cloudinary.utils.ObjectUtils;
import dao.BrandDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.util.Map;
import model.Brand;
import utils.CloudinaryUtil;

@MultipartConfig(
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class BrandManagementServlet extends HttpServlet {
   
    private final BrandDAO dao = new BrandDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) action = "list";

        request.setAttribute("currentPage", "BrandManagement");

        try {
            switch (action) {
                case "create":
                    request.getRequestDispatcher("/WEB-INF/views/admin/brand/create.jsp")
                           .forward(request, response);
                    return;

                case "update": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Brand b = dao.getById(id);
                    if (b == null) {
                        response.sendRedirect(request.getContextPath() + "/Admin/BrandManagement?action=list");
                        return;
                    }
                    request.setAttribute("brand", b);
                    request.getRequestDispatcher("/WEB-INF/views/admin/brand/update.jsp")
                           .forward(request, response);
                    return;
                }

                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    dao.softDelete(id);
                    response.sendRedirect(request.getContextPath() + "/Admin/BrandManagement?action=list");
                    return;
                }

                case "list":
                default:
                    request.setAttribute("brands", dao.getAll());
                    request.getRequestDispatcher("/WEB-INF/views/admin/brand/list.jsp")
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

        request.setAttribute("currentPage", "BrandManagement");

        try {
            switch (action) {
                case "create": {
                    String name = request.getParameter("brandName");
                    String des  = request.getParameter("description");

                    // upload ảnh giống category
                    Part logoPart = request.getPart("logoFile");
                    String logoUrl = uploadToCloudinary(logoPart);

                    Brand b = new Brand();
                    b.setBrandName(name);
                    b.setDescription(des);
                    b.setLogoUrl(logoUrl);

                    dao.insert(b);
                    response.sendRedirect(request.getContextPath() + "/Admin/BrandManagement?action=list");
                    return;
                }

                case "update": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = request.getParameter("brandName");
                    String des  = request.getParameter("description");

                    String oldLogoUrl = request.getParameter("oldLogoUrl");

                    Part logoPart = request.getPart("logoFile");
                    String newLogoUrl = uploadToCloudinary(logoPart);

                    String finalLogoUrl = (newLogoUrl != null) ? newLogoUrl : oldLogoUrl;

                    Brand b = new Brand();
                    b.setBrandID(id);
                    b.setBrandName(name);
                    b.setDescription(des);
                    b.setLogoUrl(finalLogoUrl);

                    dao.update(b);
                    response.sendRedirect(request.getContextPath() + "/Admin/BrandManagement?action=list");
                    return;
                }
            }

            response.sendRedirect(request.getContextPath() + "/Admin/BrandManagement?action=list");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private String uploadToCloudinary(Part part) throws Exception {
        if (part == null || part.getSize() == 0) return null;

        byte[] data;
        try (InputStream is = part.getInputStream()) {
            data = is.readAllBytes();
        }

        Map res = CloudinaryUtil.getInstance().uploader().upload(
                data,
                ObjectUtils.asMap(
                        "folder", "DATShop/brands",
                        "resource_type", "image"
                )
        );

        return (String) res.get("secure_url");
    }
}