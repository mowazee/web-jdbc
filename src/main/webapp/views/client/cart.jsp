<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Giỏ hàng</title>
</head>
<body>
<div class="container py-4">
    <h4>Giỏ hàng của bạn</h4>
    <c:set var="cart" value="${sessionScope.cart}" />
    <c:if test="${empty cart or empty cart.items}">
        <div class="alert alert-info">Giỏ hàng trống</div>
    </c:if>

    <c:if test="${not empty cart and not empty cart.items}">
        <table class="table">
            <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Giá</th>
                    <th>Tổng</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="it" items="${cart.items}">
                    <tr data-product-id="${it.productId}">
                        <td>${it.productName}</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/cart/update" method="get" class="d-flex align-items-center">
                                <input type="hidden" name="id" value="${it.productId}" />
                                <input type="number" name="qty" value="${it.quantity}" min="1" class="form-control form-control-sm me-2" style="width:80px;" />
                                <button type="submit" class="btn btn-sm btn-primary">Cập nhật</button>
                            </form>
                        </td>
                        <td class="item-price"><fmt:formatNumber value="${it.price}" pattern="#"/> VNĐ</td>
                        <td class="item-subtotal"><fmt:formatNumber value="${it.subtotal}" pattern="#"/> VNĐ</td>
                        <td><a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/cart/remove?id=${it.productId}">Xóa</a></td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="3" class="text-end"><strong>Tổng cộng:</strong></td>
                    <td><strong id="cart-total"><fmt:formatNumber value="${sessionScope.cart.totalPrice}" pattern="#"/> VNĐ</strong></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>

        <div class="d-flex gap-2">
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/cart/clear">Xóa tất cả</a>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/checkout">Thanh toán</a>
        </div>
    </c:if>
</div>
<script>
// define context path for URL building
const ctx = '${pageContext.request.contextPath}';

function sendCartAjax(url, onSuccess, onError){
    fetch(url, {headers: {'X-Requested-With': 'XMLHttpRequest'}})
    .then(res => res.json())
    .then(data => {
        if (data.error) { if(onError) onError(data); else alert(data.error); return; }
        if(onSuccess) onSuccess(data);
    }).catch(err => { console.error(err); if(onError) onError({error:'Lỗi mạng'}); });
}

// helper to parse formatted price text to number
function parsePriceText(priceText){
    const digits = (priceText || '').replace(/[^0-9\,\.]+/g,'');
    let normalized = digits.replace(/\./g, '');
    normalized = normalized.replace(/,/g, '.');
    return parseFloat(normalized) || 0;
}

// helper to format number to VNĐ
function formatVND(amount){
    return new Intl.NumberFormat('vi-VN').format(amount) + ' VNĐ';
}

// helper to recalc all subtotals from DOM and return sum
function recalcAllRows(){
    let sum = 0;
    const rows = document.querySelectorAll('tbody tr');
    rows.forEach(row => {
        const priceCell = row.querySelector('.item-price');
        const subtotalCell = row.querySelector('.item-subtotal');
        // find qty input inside the form in second cell
        const qtyInput = row.querySelector('input[name="qty"]');
        const qty = qtyInput ? parseInt(qtyInput.value, 10) || 0 : 0;
        const price = parsePriceText(priceCell ? priceCell.textContent : '0');
        const subtotal = price * qty;
        if(subtotalCell) subtotalCell.textContent = formatVND(subtotal);
        sum += subtotal;
    });
    return sum;
}

// intercept update forms
document.querySelectorAll('form[action*="/cart/update"]').forEach(function(f){
    f.addEventListener('submit', function(e){
        e.preventDefault();
        const formData = new FormData(f);
        const id = formData.get('id');
        const qty = formData.get('qty');
        const url = ctx + '/cart/update?id=' + encodeURIComponent(id) + '&qty=' + encodeURIComponent(qty) + '&_ajax=1';
        sendCartAjax(url, function(data){
            // update badge
            const badge = document.getElementById('cart-badge'); if(badge) badge.textContent = data.totalQuantity;
            // update subtotal and total price on page
            // try to use server-returned item map to update specific row
            const itemsMap = data.items || {};
            const prodId = id;
            if (itemsMap[String(prodId)]) {
                const it = itemsMap[String(prodId)];
                // update qty input in that row
                const row = document.querySelector('tr[data-product-id="' + prodId + '"]');
                if (row) {
                    const qtyInput = row.querySelector('input[name="qty"]');
                    if (qtyInput) qtyInput.value = it.quantity;
                    const subtotalCell = row.querySelector('.item-subtotal');
                    if (subtotalCell) subtotalCell.textContent = formatVND(it.subtotal);
                }
            } else {
                // fallback: recalc all rows from DOM
                recalcAllRows();
            }
            // update footer total
            const totalElem = document.getElementById('cart-total');
            if(totalElem){ totalElem.textContent = formatVND(data.totalPrice); }
        }, function(err){
            alert(err.error || 'Có lỗi khi cập nhật giỏ hàng');
        });
    });
});

// intercept remove links
document.querySelectorAll('a[href*="/cart/remove"]').forEach(function(a){
    a.addEventListener('click', function(e){
        e.preventDefault();
        // ensure _ajax param appended correctly
        const sep = a.href.indexOf('?') === -1 ? '?' : '&';
        const url = a.href + sep + '_ajax=1';
        sendCartAjax(url, function(data){
            // remove row
            const row = a.closest('tr'); if(row) row.remove();
            // update badge
            const badge = document.getElementById('cart-badge'); if(badge) badge.textContent = data.totalQuantity;
            // try to update footer and recalc rows
            recalcAllRows();
            const totalElem = document.getElementById('cart-total');
            if(totalElem){ totalElem.textContent = formatVND(data.totalPrice); }
            // if cart empty, show message
            const tbody = document.querySelector('tbody'); if(!tbody || tbody.children.length===0){ location.reload(); }
        }, function(err){
            alert(err.error || 'Có lỗi khi xóa sản phẩm');
        });
    });
});
</script>
</body>
</html>