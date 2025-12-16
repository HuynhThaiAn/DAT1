<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Product product = (Product) request.getAttribute("product");
%>

<div class="image-panel">
    <div class="main-image-wrapper text-center">
        <label for="fileInputMain">
            <img id="previewMainImage"
                 src="<%= (product != null && product.getImageUrl() != null) ? product.getImageUrl() : "https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png" %>"
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

    <div class="thumb-grid">
        <div class="thumb-card text-center">
            <label for="fileInput1"><img id="previewImage1" src="https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png"></label>
            <input type="file" name="file1" id="fileInput1" accept="image/*" class="file-input-hidden"
                   onchange="previewSelectedImage(this, 'previewImage1')">
        </div>

        <div class="thumb-card text-center">
            <label for="fileInput2"><img id="previewImage2" src="https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png"></label>
            <input type="file" name="file2" id="fileInput2" accept="image/*" class="file-input-hidden"
                   onchange="previewSelectedImage(this, 'previewImage2')">
        </div>

        <div class="thumb-card text-center">
            <label for="fileInput3"><img id="previewImage3" src="https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png"></label>
            <input type="file" name="file3" id="fileInput3" accept="image/*" class="file-input-hidden"
                   onchange="previewSelectedImage(this, 'previewImage3')">
        </div>

        <div class="thumb-card text-center">
            <label for="fileInput4"><img id="previewImage4" src="https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png"></label>
            <input type="file" name="file4" id="fileInput4" accept="image/*" class="file-input-hidden"
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
