package controller;

import com.cloudinary.utils.ObjectUtils;
import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;

import model.Category;
import utils.CloudinaryUtil;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

@MultipartConfig(
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class CategoryManagementServlet extends HttpServlet {

    private final CategoryDAO dao = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        request.setAttribute("currentPage", "CategoryManagement");

        try {
            switch (action) {
                case "create":
                    request.getRequestDispatcher("/WEB-INF/views/admin/category/create.jsp")
                           .forward(request, response);
                    return;

                case "update": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Category c = dao.getById(id);
                    if (c == null) {
                        response.sendRedirect(request.getContextPath() + "/Admin/CategoryManagement?action=list");
                        return;
                    }
                    request.setAttribute("category", c);
                    request.getRequestDispatcher("/WEB-INF/views/admin/category/update.jsp")
                           .forward(request, response);
                    return;
                }

                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    dao.softDelete(id);
                    response.sendRedirect(request.getContextPath() + "/Admin/CategoryManagement?action=list");
                    return;
                }

                case "list":
                default:
                    request.setAttribute("categories", dao.getAll());
                    request.getRequestDispatcher("/WEB-INF/views/admin/category/list.jsp")
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

        request.setAttribute("currentPage", "CategoryManagement");

        try {
            switch (action) {
                case "create": {
                    String name = request.getParameter("categoryName");
                    String des  = request.getParameter("description");

                    if (dao.existsByName(name)) {
                        request.setAttribute("error", "CategoryName đã tồn tại.");
                        request.getRequestDispatcher("/WEB-INF/views/admin/category/create.jsp")
                               .forward(request, response);
                        return;
                    }

                    String logoUrl = uploadToCloudinary(request.getPart("logoFile"));

                    Category c = new Category();
                    c.setCategoryName(name);
                    c.setDescription(des);
                    c.setImgUrlLogo(logoUrl);

                    dao.insert(c);
                    response.sendRedirect(request.getContextPath() + "/Admin/CategoryManagement?action=list");
                    return;
                }

                case "update": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = request.getParameter("categoryName");
                    String des  = request.getParameter("description");

                    if (dao.existsByNameExceptId(name, id)) {
                        Category old = dao.getById(id);
                        request.setAttribute("category", old);
                        request.setAttribute("error", "CategoryName đã tồn tại.");
                        request.getRequestDispatcher("/WEB-INF/views/admin/category/update.jsp")
                               .forward(request, response);
                        return;
                    }

                    String oldLogo = request.getParameter("oldLogoUrl");
                    String newLogo = uploadToCloudinary(request.getPart("logoFile"));
                    String finalLogo = (newLogo != null) ? newLogo : oldLogo;

                    Category c = new Category();
                    c.setCategoryID(id);
                    c.setCategoryName(name);
                    c.setDescription(des);
                    c.setImgUrlLogo(finalLogo);

                    dao.update(c);
                    response.sendRedirect(request.getContextPath() + "/Admin/CategoryManagement?action=list");
                    return;
                }

                default:
                    response.sendRedirect(request.getContextPath() + "/Admin/CategoryManagement?action=list");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private String uploadToCloudinary(Part part) throws Exception {
    if (part == null || part.getSize() <= 0) return null;

    byte[] data;
    try (InputStream is = part.getInputStream()) {
        data = is.readAllBytes(); // Java 11+
    }

    Map res = CloudinaryUtil.getInstance().uploader().upload(
        data,
        ObjectUtils.asMap(
            "folder", "DATShop/categories",
            "resource_type", "image"
        )
    );
    return (String) res.get("secure_url");
}

}
