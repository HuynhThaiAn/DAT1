
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Product product = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Images</title>

    <style>
        .image-panel {
            background-color: #ffffff;
            padding: 18px;
            border-radius: 16px;
            box-shadow: 0 6px 24px rgba(15, 23, 42, 0.12);
            width: 100%;
            box-sizing: border-box;
        }

        /* Ảnh lớn */
        .main-image-wrapper {
            width: 100%;
            margin-bottom: 14px;
            border-radius: 14px;
            overflow: hidden;
            background: radial-gradient(circle at top, #1f2937, #020617);
        }

        .main-image-wrapper img {
            width: 100%;
            max-height: 380px;
            object-fit: cover;
            display: block;
            border-radius: 14px;
            cursor: pointer;
            transition: transform 0.25s ease, opacity 0.2s ease;
        }

        .main-image-wrapper img:hover {
            transform: scale(1.01);
            opacity: 0.96;
        }

        /* Grid 4 ảnh nhỏ */
        .thumb-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 10px;
            margin-top: 6px;
        }

        .thumb-card {
            width: 23%;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid #e5e7eb;
            background-color: #f9fafb;
            cursor: pointer;
            transition: box-shadow 0.2s ease, border-color 0.2s ease, transform 0.15s ease;
        }

        .thumb-card:hover {
            border-color: #2563eb;
            box-shadow: 0 4px 14px rgba(37, 99, 235, 0.25);
            transform: translateY(-1px);
        }

        .thumb-card img {
            width: 100%;
            max-height: 110px;
            object-fit: cover;
            display: block;
        }

        /* Ẩn input file */
        .file-input-hidden {
            display: none;
        }

        /* Responsive nhẹ */
        @media (max-width: 992px) {
            .thumb-card {
                width: 48%;
            }
        }

        @media (max-width: 576px) {
            .thumb-card {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="image-panel">
        <!-- Ảnh lớn -->
        <div class="main-image-wrapper text-center">
            <label for="fileInputMain">
                <img id="previewMainImage"
                     src="<%= product != null && product.getImageUrl() != null ? product.getImageUrl() : "" %>"
                     alt="Click to change main image"
                     title="Click to change main image">
            </label>
            <input type="file"
                   name="fileMain"
                   id="fileInputMain"
                   accept="image/*"
                   class="file-input-hidden"
                   onchange="previewSelectedImage(this, 'previewMainImage')">
        </div>

        <!-- Ảnh nhỏ -->
        <div class="thumb-grid">
            <!-- Ảnh nhỏ 1 -->
            <div class="thumb-card text-center">
                <label for="fileInput1">
                    <img id="previewImage1"
                         src="https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png"
                         alt="Click to change image 1"
                         title="Click to change image 1">
                </label>
                <input type="file"
                       name="file1"
                       id="fileInput1"
                       accept="image/*"
                       class="file-input-hidden"
                       onchange="previewSelectedImage(this, 'previewImage1')">
            </div>

            <!-- Ảnh nhỏ 2 -->
            <div class="thumb-card text-center">
                <label for="fileInput2">
                    <img id="previewImage2"
                         src="https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png"
                         alt="Click to change image 2"
                         title="Click to change image 2">
                </label>
                <input type="file"
                       name="file2"
                       id="fileInput2"
                       accept="image/*"
                       class="file-input-hidden"
                       onchange="previewSelectedImage(this, 'previewImage2')">
            </div>

            <!-- Ảnh nhỏ 3 -->
            <div class="thumb-card text-center">
                <label for="fileInput3">
                    <img id="previewImage3"
                         src="https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png"
                         alt="Click to change image 3"
                         title="Click to change image 3">
                </label>
                <input type="file"
                       name="file3"
                       id="fileInput3"
                       accept="image/*"
                       class="file-input-hidden"
                       onchange="previewSelectedImage(this, 'previewImage3')">
            </div>

            <!-- Ảnh nhỏ 4 -->
            <div class="thumb-card text-center">
                <label for="fileInput4">
                    <img id="previewImage4"
                         src="https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png"
                         alt="Click to change image 4"
                         title="Click to change image 4">
                </label>
                <input type="file"
                       name="file4"
                       id="fileInput4"
                       accept="image/*"
                       class="file-input-hidden"
                       onchange="previewSelectedImage(this, 'previewImage4')">
            </div>
        </div>
    </div>

    <script>
        function previewSelectedImage(input, imgId) {
            const preview = document.getElementById(imgId);
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>
