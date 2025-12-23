<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Product"%>
<%@page import="model.ProductVariant"%>
<%@page import="model.ProductImage"%>
<%@page import="model.VariantAttribute"%>

<%
    String ctx = request.getContextPath();

    Product product = (Product) request.getAttribute("product");
    List<ProductVariant> variantList = (List<ProductVariant>) request.getAttribute("variantList");
    ProductVariant selectedVariant = (ProductVariant) request.getAttribute("selectedVariant");
    List<ProductImage> images = (List<ProductImage>) request.getAttribute("images");
    List<VariantAttribute> attrs = (List<VariantAttribute>) request.getAttribute("variantAttributes");
    String mainImageUrl = (String) request.getAttribute("mainImageUrl");

    if (variantList == null) variantList = Collections.emptyList();
    if (images == null) images = Collections.emptyList();
    if (attrs == null) attrs = Collections.emptyList();

    if (mainImageUrl == null && !images.isEmpty()) mainImageUrl = images.get(0).getImageUrl();

    Locale vn = new Locale("vi", "VN");
    NumberFormat nf = NumberFormat.getInstance(vn);

    String error = (String) request.getAttribute("error");

    // Build a small highlights list from VariantAttribute (take first 4 rows)
    List<VariantAttribute> highlights = new ArrayList<>();
    for (int i = 0; i < attrs.size() && i < 4; i++) highlights.add(attrs.get(i));
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= (product != null ? product.getProductName() : "Product Detail") %></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root{
            --bg:#f4f6fb;
            --card:#fff;
            --text:#111827;
            --muted:#6b7280;
            --border:rgba(15, 23, 42, 0.10);
            --shadow:0 12px 28px rgba(0,0,0,.08);
            --primary:#2563eb;
        }
        body{ background:var(--bg); }
        .wrap{ max-width:1200px; margin:20px auto; padding:0 12px; }

        .cardx{
            background:var(--card);
            border:1px solid var(--border);
            border-radius:18px;
            box-shadow:var(--shadow);
            overflow:hidden;
        }

        .img-main{
            width:100%;
            height:420px;
            object-fit:contain;
            background:#f8fafc;
        }

        .thumbs{
            display:flex;
            gap:10px;
            overflow:auto;
            padding:10px 12px 14px;
            border-top:1px solid var(--border);
            background:#fff;
        }
        .thumb{
            width:74px; height:74px;
            object-fit:contain;
            background:#fff;
            border:1px solid rgba(15,23,42,.12);
            border-radius:14px;
            cursor:pointer;
            flex: 0 0 auto;
        }

        .title{
            font-weight: 900;
            color: var(--text);
            margin:0;
        }
        .muted{ color:var(--muted); }

        /* Variant pills like the screenshot */
        .variant-row{
            display:flex;
            gap:10px;
            flex-wrap:wrap;
            margin-top:10px;
        }
        .variant-pill{
            text-decoration:none;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            min-width: 120px;
            padding: 12px 14px;
            border-radius: 14px;
            font-weight: 900;
            border:1px solid rgba(15,23,42,.12);
            background:#fff;
            color:#0f172a;
            box-shadow: 0 10px 20px rgba(0,0,0,.05);
        }
        .variant-pill.active{
            border-color: rgba(37,99,235,.55);
            background: rgba(37,99,235,.08);
            color: var(--primary);
        }
        .variant-pill.disabled{
            opacity:.55;
            pointer-events:none;
        }

        .price{
            font-size: 28px;
            font-weight: 900;
            color:#d92d20;
            margin: 8px 0 0;
        }
        .stock{
            font-weight: 900;
        }

        .btn-solid{
            border:none;
            border-radius: 14px;
            padding: 12px 14px;
            font-weight: 900;
            color:#fff;
            background: linear-gradient(135deg,#1d4ed8,#2563eb);
            box-shadow: 0 12px 22px rgba(37,99,235,.18);
            text-decoration:none;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:8px;
        }
        .btn-outline{
            border:1px solid rgba(15,23,42,.18);
            border-radius: 14px;
            padding: 12px 14px;
            font-weight: 900;
            background:#fff;
            color:#0f172a;
            text-decoration:none;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:8px;
        }

        .feature-box{
            background:#0b1220;
            color:#fff;
            border-radius: 16px;
            padding: 14px;
        }
        .feature-item{
            display:flex;
            gap:10px;
            align-items:flex-start;
            padding: 10px 0;
            border-top: 1px solid rgba(255,255,255,.12);
        }
        .feature-item:first-child{ border-top:none; }
        .feature-ic{
            width:34px; height:34px;
            border-radius: 12px;
            background: rgba(255,255,255,.12);
            display:flex;
            align-items:center;
            justify-content:center;
            flex: 0 0 auto;
        }
        .feature-text{ font-weight:800; }

        .spec-table td{ vertical-align: top; }
    </style>
</head>

<body>
    <!-- Keep your existing header include -->
    <jsp:include page="/WEB-INF/views/customer/homePage/header.jsp" />

    <div class="wrap">
        <% if (error != null && !error.isBlank()) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <% if (product == null) { %>
            <div class="alert alert-warning">Product not found.</div>
        <% } else { %>

        <div class="row g-3">
            <!-- LEFT: Images -->
            <div class="col-lg-7">
                <div class="cardx">
                    <img id="mainImage" class="img-main"
                         src="<%= (mainImageUrl != null ? mainImageUrl : "") %>"
                         onerror="this.style.display='none'">

                    <div class="thumbs">
                        <% for (ProductImage img : images) { %>
                            <img class="thumb" src="<%= img.getImageUrl() %>"
                                 onclick="document.getElementById('mainImage').src=this.src;">
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- RIGHT: Variant + Price + Highlights -->
            <div class="col-lg-5">
                <div class="cardx p-3">
                    <h3 class="title"><%= product.getProductName() %></h3>
                    <% if (product.getDescription() != null && !product.getDescription().isBlank()) { %>
                        <div class="muted mt-1"><%= product.getDescription() %></div>
                    <% } %>

                    <!-- Variant pills (VariantName) -->
                    <div class="mt-3">
                        <div class="fw-bold mb-2">Choose version</div>
                        <div class="variant-row">
                            <% for (ProductVariant v : variantList) {
                                   boolean isSelected = (selectedVariant != null
                                           && selectedVariant.getProductVariantID() != null
                                           && selectedVariant.getProductVariantID().equals(v.getProductVariantID()));
                                   boolean disabled = Boolean.FALSE.equals(v.getIsActive());
                                   String cls = "variant-pill" + (isSelected ? " active" : "") + (disabled ? " disabled" : "");
                            %>
                                <a class="<%=cls%>"
                                   href="<%=ctx%>/ProductDetail?productId=<%=product.getProductID()%>&variantId=<%=v.getProductVariantID()%>">
                                    <%= v.getVariantName() %>
                                </a>
                            <% } %>
                        </div>
                    </div>

                    <% if (selectedVariant != null) { %>
                        <div class="mt-3 d-flex justify-content-between align-items-end">
                            <div>
                                <div class="muted" style="font-size:13px;">Price</div>
                                <div class="price"><%= nf.format(selectedVariant.getPrice()) %> đ</div>
                            </div>
                            <div class="text-end">
                                <div class="muted" style="font-size:13px;">In stock</div>
                                <div class="stock"><%= selectedVariant.getStockQuantity() %></div>
                            </div>
                        </div>

                        <div class="mt-3 d-grid gap-2">
                            <!-- You will wire Cart later (Cart table: CustomerID + ProductVariantID) -->
                            <a class="btn-solid"
                               href="<%=ctx%>/Cart?action=add&variantId=<%=selectedVariant.getProductVariantID()%>&qty=1">
                                <i class="fa-solid fa-cart-plus"></i> Add to cart
                            </a>
                            <a class="btn-outline"
                               href="<%=ctx%>/Checkout?variantId=<%=selectedVariant.getProductVariantID()%>&qty=1">
                                <i class="fa-solid fa-bolt"></i> Buy now
                            </a>
                        </div>

                        <!-- Highlights (from VariantAttribute) -->
                        <div class="mt-3 feature-box">
                            <div class="fw-bold mb-1">Highlights</div>
                            <% if (highlights.isEmpty()) { %>
                                <div class="muted" style="color:rgba(255,255,255,.75);">No highlights for this version.</div>
                            <% } else { %>
                                <% for (VariantAttribute a : highlights) { %>
                                    <div class="feature-item">
                                        <div class="feature-ic"><i class="fa-solid fa-circle-check"></i></div>
                                        <div class="feature-text">
                                            <%= a.getAttributeName() %>: <%= a.getAttributeValue() %>
                                            <% if (a.getUnit() != null && !a.getUnit().trim().isEmpty()) { %>
                                                <span style="opacity:.85;">(<%= a.getUnit() %>)</span>
                                            <% } %>
                                        </div>
                                    </div>
                                <% } %>
                            <% } %>
                        </div>

                    <% } else { %>
                        <div class="alert alert-warning mt-3">No version available for this product.</div>
                    <% } %>
                </div>
            </div>

            <!-- Specs: VariantAttribute changes with selected variant -->
            <div class="col-12">
                <div class="cardx p-3">
                    <div class="d-flex justify-content-between align-items-end mb-2">
                        <div>
                            <h5 class="mb-0 fw-bold">Specifications</h5>
                            <div class="muted" style="font-size:13px;">Specifications are shown by selected version.</div>
                        </div>
                        <% if (selectedVariant != null) { %>
                            <div class="fw-bold"><%= selectedVariant.getVariantName() %></div>
                        <% } %>
                    </div>

                    <% if (attrs.isEmpty()) { %>
                        <div class="muted">No specifications for this version.</div>
                    <% } else { %>
                        <div class="table-responsive">
                            <table class="table table-sm spec-table mb-0">
                                <tbody>
                                <% for (VariantAttribute a : attrs) { %>
                                    <tr>
                                        <td style="width:35%;" class="fw-bold"><%= a.getAttributeName() %></td>
                                        <td>
                                            <%= a.getAttributeValue() %>
                                            <% if (a.getUnit() != null && !a.getUnit().trim().isEmpty()) { %>
                                                <span class="muted">(<%= a.getUnit() %>)</span>
                                            <% } %>
                                        </td>
                                    </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } %>
                </div>
            </div>

        </div>
        <% } %>
    </div>

    <jsp:include page="/WEB-INF/views/customer/homePage/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
