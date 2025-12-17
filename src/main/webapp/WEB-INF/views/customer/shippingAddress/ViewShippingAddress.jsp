<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Address" %>
<%
    List<Address> addressList = (List<Address>) request.getAttribute("addressList");
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Addresses</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/profile.css">

<style>
    :root {
        --primary-500: #2563eb;
        --primary-400: #3b82f6;
        --primary-100: #dbeafe;
        --slate-900: #0f172a;
        --slate-700: #334155;
        --slate-500: #64748b;
        --slate-100: #f1f5f9;
    }

    /* TĂNG KÍCH THƯỚC TOÀN DIỆN - NỘI DUNG RÕ HƠN */
    body {
        font-size: 17px;
    }
    .profile-card {
        min-height: 75vh; /* 🔥 Đẩy nội dung dài hơn */
        padding: 30px 35px;
    }

    /* Giữ layout không bị hẹp */
    .profile-body {
        margin-top: 10px;
    }

    /* ====== Address Item ======= */
    .address-row {
        padding: 18px 10px;
        border-bottom: 1px solid rgba(226, 232, 240, 0.9);
        font-size: 1rem;                        /* chữ to hơn */
        display: flex;
        justify-content: space-between;
        gap: 18px;
        align-items: flex-start;
        transition: .2s;
    }
    .address-row:hover {
        background: rgba(37, 99, 235, 0.05);
        transform: translateY(-2px);
    }
    .address-main strong { font-size: 1.05rem; }

    /* Badge Default */
    .default-label {
        padding: 5px 12px;
        border-radius: 30px;
        font-weight: 600;
        background: rgba(22,163,74,.15);
        color:#15803d;
        border:1px solid rgba(22,163,74,.25);
        font-size: .85rem;
    }

    /* Action buttons */
    .address-actions {
        display:flex;
        flex-wrap:wrap;
        gap:10px;
    }

    .address-actions .btn-update,
    .address-actions .btn-cancel {
        padding: 7px 18px;
        font-size: .9rem;
        border-radius: 10px;
    }

    .set-default-link {
        border:1px solid #90a4bf;
        padding:7px 16px;
        font-size:.9rem;
        border-radius:999px;
        display:flex;
        align-items:center;
        gap:6px;
        transition:.2s;
    }
    .set-default-link:hover {
        background:var(--primary-100);
        color:var(--primary-500);
        border-color:var(--primary-400);
    }

    /* Header đẹp + nổi bật hơn */
    .address-header-title {
        font-size:1.45rem;
        font-weight:700;
    }
    .address-subtitle {
        color:var(--slate-500);
        font-size:1rem;
        margin-bottom:20px;
    }

    /* Nút Add Address */
    .btn-add-address {
        padding:10px 22px;
        font-size:.95rem;
        border-radius:999px;
        background:linear-gradient(135deg,var(--primary-500),var(--primary-400));
        color:white;
        font-weight:600;
        box-shadow:0 4px 18px rgba(37,99,235,.4);
        transition:.2s;
        text-decoration:none;
    }
    .btn-add-address:hover {
        transform:translateY(-2px);
        box-shadow:0 6px 28px rgba(37,99,235,.55);
    }

    /* Không có address */
    .no-address-found {
        margin-top:35px;
        font-size:1.05rem;
        color:#777;
        display:flex;
        align-items:center;
        gap:8px;
    }

    /* MOBILE tối ưu */
    @media(max-width:768px){
        .address-row{flex-direction:column;}
        .profile-card{min-height:68vh;}
    }
</style>

</head>
<body>
<jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

<div class="main-account container-fluid">
    <jsp:include page="/WEB-INF/View/customer/sideBar.jsp" />

    <div class="profile-card">
        <div class="profile-header d-flex justify-content-between align-items-center">
            <h4 class="address-header-title">
                <i class="bi bi-geo-alt-fill"></i>
                My Addresses
            </h4>
            <a href="AddAddress" class="btn-add-address">
                <i class="bi bi-plus-lg"></i>
                Add Address
            </a>
        </div>

        <div class="profile-body">
            <div class="address-subtitle">
                Your saved shipping addresses
            </div>

            <div>
                <% if (addressList != null && addressList.size() > 0) {
                    for (Address addr : addressList) { %>
                    <div class="address-row">
                        <div class="address-main">
                            <div>
                                <strong><%= addr.getAddressDetails()%></strong>,
                                <span><%= addr.getWardName()%>, <%= addr.getDistrictName()%>, <%= addr.getProvinceName()%></span>
                            </div>

                            <div class="address-meta">
                                <% if (addr.isDefault()) { %>
                                    <span class="default-label">
                                        <i class="bi bi-star-fill"></i>
                                        Default
                                    </span>
                                <% } %>
                            </div>
                        </div>

                        <div class="address-actions">
                            <a class="btn-update" href="UpdateAddress?id=<%=addr.getAddressId()%>">
                                <i class="bi bi-pencil-square"></i> Update
                            </a>

                            <% if (!addr.isDefault()) { %>
                                <button type="button"
                                        class="btn-cancel delete-btn"
                                        data-address-id="<%=addr.getAddressId()%>"
                                        data-address-detail="<%=addr.getAddressDetails()%>">
                                    <i class="bi bi-trash"></i> Delete
                                </button>

                                <button type="button"
                                        class="set-default-link"
                                        onclick="window.location = 'SetDefaultAddress?id=<%=addr.getAddressId()%>'">
                                    <i class="bi bi-star"></i> Set as default
                                </button>
                            <% } %>
                        </div>
                    </div>
                <% }
                } else { %>
                    <div class="no-address-found">
                        <i class="bi bi-emoji-frown"></i>
                        <span>No address found. Please add your address!</span>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
window.onload = function () {
    document.querySelectorAll('.delete-btn').forEach(function(btn) {
        btn.onclick = function(e) {
            e.preventDefault();
            const addressId = btn.getAttribute('data-address-id');
            const detail = btn.getAttribute('data-address-detail');
            Swal.fire({
                title: 'Delete Address?',
                html: `<b>${detail}</b><br>Are you sure to delete this address?`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    fetch('DeleteAddress?id=' + addressId, { method: 'POST' })
                        .then(res => {
                            if (res.ok) {
                                btn.closest('.address-row').remove();
                                Swal.fire('Deleted!', 'Address has been deleted.', 'success');
                            } else {
                                Swal.fire('Error', 'Failed to delete address.', 'error');
                            }
                        }).catch(() => {
                            Swal.fire('Error', 'Something went wrong.', 'error');
                        });
                }
            });
        };
    });
};
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
