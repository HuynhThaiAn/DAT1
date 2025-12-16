<%@page import="model.CategoryDetail"%>
<%@page import="model.CategoryDetailGroup"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<CategoryDetailGroup> categoryDetailGroupList =
            (List<CategoryDetailGroup>) request.getAttribute("categoryGroupList");
    List<CategoryDetail> categoryDetailList =
            (List<CategoryDetail>) request.getAttribute("categoryDetailList");
%>

<table class="category-table">
    <%
        if (categoryDetailGroupList != null && !categoryDetailGroupList.isEmpty()) {
            int groupIndex = 0;
            for (CategoryDetailGroup cateGroup : categoryDetailGroupList) {
    %>
    <tr class="group-header" onclick="toggleDetails(<%= groupIndex %>)">
        <td colspan="2" class="group-cell">
            <div class="group-header-content">
                <h2><%= cateGroup.getNameCategoryDetailsGroup() %></h2>
                <span class="arrow-icon" id="arrow<%= groupIndex %>">▼</span>
            </div>
        </td>
    </tr>

    <tbody id="detailGroup<%= groupIndex %>" class="group-details hidden">
        <%
            if (categoryDetailList != null) {
                for (CategoryDetail cateList : categoryDetailList) {
                    if (cateList.getCategoryDetailsGroupID() == cateGroup.getCategoryDetailsGroupID()) {
        %>
        <tr>
            <td class="category-name"><%= cateList.getCategoryDatailName() %></td>
            <td class="attribute-values">
                <input type="text"
                       class="attribute-input"
                       name="attribute_<%= cateList.getCategoryDetailID() %>"
                       style="max-width:190px;">
            </td>
        </tr>
        <%
                    }
                }
            }
        %>
    </tbody>
    <%
                groupIndex++;
            }
        } else {
    %>
    <tr><td colspan="2" class="no-data-message">No data</td></tr>
    <%
        }
    %>
</table>

<script>
    function toggleDetails(index) {
        const detailGroup = document.getElementById("detailGroup" + index);
        const arrowIcon = document.getElementById("arrow" + index);

        if (detailGroup.classList.contains("hidden")) {
            detailGroup.classList.remove("hidden");
            arrowIcon.innerText = "▲";
        } else {
            detailGroup.classList.add("hidden");
            arrowIcon.innerText = "▼";
        }
    }
</script>
