const baseURL = " https://localhost:7146/api";

const txtPageSize = document.getElementById("txtPageSize");
let pageSize = document.getElementById("txtPageSize").value;
let currPage = 1;
let invoiceId, firstRate;
let tableData = [];
const invoiceTBody = document.querySelector("#invoiceTbl tbody");
let totalEntries;
let selectedColumn = 1,
  sortOrder,
  search,
  inputString;

const fromDate = document.getElementById("fromdate");
const toDate = document.getElementById("todate");

Array.prototype.swapFirstTwo = function () {
  if (this.length >= 2) {
    [this[0], this[1]] = [this[1], this[0]];
  }
  return this;
};

// update - showing 1 to 10 of 12 entries msg
const updateEntriesInfo = async function (search) {
  const startEntry = (currPage - 1) * pageSize + 1;
  const endEntry = Math.min(currPage * pageSize, totalEntries);

  const infoElement = document.getElementById("invoiceTbl_info");
  infoElement.innerHTML = `Showing ${startEntry} to ${endEntry} of ${totalEntries} entries`;
};

// populate table data
const fillTable = function (invoices) {
  invoiceTBody.innerHTML = "";
  let html = "";
  invoices.forEach((el, index) => {
    html += `<tr>
    <td>${index + 1}</td>
                <td>${el.invoiceId}</td>
                 <td>${el.manufacturerName}</td>
                 <td>${new Date(el.date)
                   .toLocaleDateString()
                   .split("/")
                   .swapFirstTwo()
                   .join("-")}</td>
                
                <td>${el.grandTotal}</td>
                <td>
                <button class="btn btn-link edit" data-invoice-id="${
                  el.invoiceId
                }" >Edit</button>
                <button class="btn btn-link view" data-invoice-id="${
                  el.invoiceId
                }" >View Details</button>
                <button class="btn btn-link delete" data-invoice-id="${
                  el.invoiceId
                }" >Delete</button>
                </td>
                </tr>`;
  });

  invoiceTBody.insertAdjacentHTML("afterbegin", html);
};

//paginate block -- previous -1-2- next
const paginate = async function () {
  let ulPage = document.getElementById("invoiceTbl_paginate");
  let numOfPages = Math.ceil(totalEntries / pageSize);
  let html = `<a
  class="paginate_button previous disabled" aria-controls="invoiceTbl" aria-disabled="true"
  role="link" data-dt-idx="previous" tabindex="-1"
  id="invoiceTbl_previous">Previous</a>`;
  for (let i = 0; i < numOfPages; i++) {
    html += `<a class="paginate_button ${
      i + 1 == currPage ? "current" : ""
    }" aria-controls="invoiceTbl" role="link" data-dt-idx="${i}" tabindex="${i}">${
      i + 1
    }</a>`;
  }
  html += `<a class="paginate_button next disabled"
  aria-controls="invoiceTbl" aria-disabled="true" role="link" data-dt-idx="next" tabindex="-1"
  id="invoiceTbl_next">Next</a></div>`;

  ulPage.innerHTML = html;
};

$(document).ready(function () {
  const invoiceTable = $("#invoiceTbl");
  $.ajax({
    url: `${baseURL}/products/allProducts`,
    method: "GET",
    headers:{
      "Authorization":"Bearer "+localStorage.getItem("token")
    },
    success: function (data) {
      var ddProduct = $("#selectProducts");
      ddProduct.empty();
      // ddProduct.append('<option disabled value="">Select a product</option>');
      data.forEach(function (product) {
        ddProduct.append(
          '<option value="' + product.id + '">' + product.name + "</option>"
        );
      });

      // $("#selectProducts").select2();
      ddProduct.select2({
        placeholder: "Select products",
        allowClear: true,
      });
    },
    error: function (error) {
      console.error("Error fetching products:", error);
    },
  });

  $("#submit").on("click", function () {
    const startDate = $("#fromdate").val();
    const endDate = $("#todate").val();
    const products = $("#selectProducts").val();
    inputString = startDate ? `&startDate=${startDate}` : "";
    inputString += endDate ? `&endDate=${endDate}` : "";
    inputString +=
      products.length > 0 ? `&productIds=${products.join("&productIds=")}` : "";
    getTableData();
  });

  $("#clear").on("click", function () {
    $("#fromdate").val("");
    $("#todate").val("");
    $("#selectProducts").val(null).trigger("change");
    inputString = "";
    getTableData();
  });

  $("#invoiceTbl_paginate").on("click", ".paginate_button", function () {
    console.log(this);
    $("#invoiceTbl_paginate a.current").removeClass("current");
    $(this).addClass("current");
    currPage = $(this).text();
    getTableData();
  });

  txtPageSize.addEventListener("change", function () {
    pageSize = txtPageSize.value;
    getTableData();
  });

  $("#txtSearch").on("change keyup", function () {
    search = $("#txtSearch").val();
    getTableData();
  });

  $("#paginate").on("click", "a", function () {
    $("#paginate a.active").removeClass("active");
    $(this).addClass("active");
    currPage = $(this).text();

    getTableData();
  });

  const getTableData = function () {
    var list;
    let queryString = `page=${currPage}&pageSize=${pageSize}&sortColumn=${selectedColumn}&sortOrder=${
      sortOrder ? sortOrder : 0
    }&subStr=${search ? search : ""}${inputString ? inputString : ""}`;
    console.log(queryString);
    $.ajax({
      url: `${baseURL}/invoices/search?${queryString}`,
      method: "GET",
      headers:{
        "Authorization":"Bearer "+localStorage.getItem("token")
      },
      async: false,
      success: function (data) {
        // console.log(data);
        totalEntries = data.totalEntries;
        list = data.purchaseHistoryList;
      },
    });
    // console.log(list);
    fillTable(list);
    // totalEntries = list.length;
    updateEntriesInfo(search);
    paginate();
  };
  getTableData();

  $("#invoiceTbl thead").on("click", "th", function () {
    $("#invoiceTbl thead th").removeClass("sorting_asc sorting_desc");
    var columnIndex = $(this).index();
    // console.log(columnIndex);
    if (columnIndex > 0 && columnIndex < 5) selectedColumn = columnIndex;
    // console.log(selectedColumn);
    sortOrder = sortOrder === 0 ? 1 : 0;
    sortOrder === 0
      ? $(`#invoiceTbl thead th:eq(${selectedColumn})`).addClass("sorting_asc")
      : $(`#invoiceTbl thead th:eq(${selectedColumn})`).addClass(
          "sorting_desc"
        );
    getTableData();
  });

  let deleteId, deletebtn;
  invoiceTable.on("click", ".delete", function () {
    deletebtn = $(this);
    deleteId = $(this).attr("data-invoice-id");
    $("#deleteInvoiceModal").modal("show");
  });

  $("#confirmDeleteBtn").on("click", function (e) {
    e.preventDefault();
    $.ajax({
      url: `${baseURL}/invoices/invoiceId/` + deleteId,
      method: "DELETE",
      headers:{
        "Authorization":"Bearer "+localStorage.getItem("token")
      },
      success: function () {
        $("#deleteInvoiceModal").modal("hide");
        $("#deleteSuccessModal").modal("show");
        getTableData();
      },
      error: function () {
        console.log(error);
      },
    });
  });

  invoiceTable.on("click", ".view", function () {
    var button = $(this);
    var btnId = button.attr("data-invoice-id");

    window.location.href = `./ViewPurchaseHistory.html?id=${btnId}`;
  });
  // -------------  Edit Modal ----------------------
  let partyId,
    invId,
    date,
    rateId,
    isAdd = false;
  const fillProducts = function (partyId) {
    $.ajax({
      type: "GET",
      url: `${baseURL}/products/byInvoice/${partyId}`,
      headers:{
        "Authorization":"Bearer "+localStorage.getItem("token")
      },
      success: function (data) {
        // console.log(data);
        $("#ddProduct").empty();
        $.each(data, function (index, item) {
          $("#ddProduct").append(
            '<option value="' + item.id + '">' + item.name + "</option>"
          );
        });
        changeRate(data[0].id);
      },
      error: function (error) {
        console.log(error);
      },
    });
  };
  $("#txtRate").prop("disabled", true);

  const getEditList = function (id) {
    $.ajax({
      type: "GET",
      url: `${baseURL}/invoices/${id}`,
      headers:{
        "Authorization":"Bearer "+localStorage.getItem("token")
      },
      success: function (data) {
        // console.log(data)
        $("#dataTable tbody").empty();
        fillEditTable(data);
        fillProducts(data[0].manufacturerId);
      },
      error: function (error) {
        console.log(error);
      },
    });
  };

  $("#ddProduct").on("change", function () {
    const productId = $("#ddProduct").val();
    changeRate(productId);
  });

  const changeRate = function (productId) {
    $.ajax({
      type: "GET",
      url: `${baseURL}/rates/byProduct/${productId}`,
      headers:{
        "Authorization":"Bearer "+localStorage.getItem("token")
      },
      success: function (result) {
        // console.log(result);
        $("#txtRate").val("");
        $("#txtRate").val(result.amount);
        rateId = result.id;
      },
      error: function (error) {
        console.log(error);
      },
    });
  };

  const fillEditTable = function (invoices) {
    $.each(invoices, function (i, el) {
      const total = el.rateAmount * el.quantity;
      let newRow = $("<tr>");
      newRow.append("<td>" + el.productName + "</td>");
      // newRow.append('<td>' + manufacturer + '</td>');
      newRow.append("<td>" + el.rateAmount + "</td>");
      newRow.append("<td>" + el.quantity + "</td>");
      newRow.append("<td>" + total.toFixed(2) + "</td>");
      newRow.append(
        "<td>" +
          ` <button type="button" id="btnEditRow" class="btn btn-sm text-info row-edit" data-row-id= ${el.id} data-row-product=${el.productId} data-quantity=${el.quantity}>Edit</button>
             <button type="button" class="btn text-danger btn-sm row-delete" data-row-id= ${el.id}>Delete</button>` +
          "</td>"
      );

      $("#dataTable tbody").append(newRow);
      $("#lblInvoice").text(invoices[0].invoiceId);
      invId = invoices[0].invoiceId;
      $("#lblParty").text(invoices[0].manufacturerName);
      partyId = invoices[0].manufacturerId;
      $("#lblDate").text(formatDate(invoices[0].date));
      date = invoices[0].date;
    });
  };

  invoiceTable.on("click", ".edit", function () {
    var button = $(this);
    var btnId = button.attr("data-invoice-id");
    getEditList(btnId);
    $("#editInvoiceModal").modal("show");
    $("#editInvoiceForm").css("display", "none");
    $("#btnSaveEdit").css("display", "none");
  });

  let editInlineId;
  $("#dataTable").on("click", ".row-edit", function () {
    $(".field-validation-error").remove();
    $(".field-validation-success").remove();
    isAdd = false;
    editInlineId = $(this).attr("data-row-id");
    $("#editInvoiceForm").css("display", "inline");
    $("#btnSaveEdit").css("display", "inline");
    const product = $(this).attr("data-row-product");
    // console.log("product" + product);

    $("#ddProduct").val(product);
    changeRate(product);
    $("#txtQuantity").val($(this).attr("data-quantity"));
  });

  $("#btnAddProduct").on("click", function () {
    $(".field-validation-error").remove();
    $(".field-validation-success").remove();
    $("#editInvoiceForm").css("display", "inline");
    $("#btnSaveEdit").css("display", "inline");
    isAdd = true;
  });

  $("#btnSaveEdit").on("click", function () {
    let dataVar = {
      invoiceId: invId,
      manufacturerId: partyId,
      productId: parseInt($("#ddProduct").val()),
      rateId: rateId,
      quantity: parseInt($("#txtQuantity").val()),
      date: date,
    };
    // console.log(dataVar);
    $.ajax({
      url: `${baseURL}/invoices/${isAdd ? "" : editInlineId}`,
      type: `${isAdd ? "POST" : "PUT"}`,
      headers: {
        "Content-Type": "application/json",
        "Authorization":"Bearer "+localStorage.getItem("token")
      },
      data: JSON.stringify(dataVar),
      success: function (response) {
        getEditList(invId);
        if (isAdd) {
          $("#msg").after(
            `<span class="field-validation-success">Product added successfully!!</span>`
          );
          // $("#addEditSuccessModal").modal("show");
        } else {
          // $("#editEditSuccessModal").modal("show");
          $("#msg").after(
            `<span class="field-validation-success">Product edited successfully!!</span>`
          );
        }
        $("#editInvoiceForm").css("display", "none");
        $("#btnSaveEdit").css("display", "none");
        isAdd = false;
      },
      error: function (xhr, textStatus, errorThrown) {
        $("#msg").after(
          `<span class="field-validation-error">Something went wrong !!</span>`
        );
        console.log("An error occurred: " + errorThrown);
      },
    });
  });

  let deleteInlineId, deleteInlinebtn;
  $("#dataTable").on("click", ".row-delete", function () {
    $(".field-validation-error").remove();
    $(".field-validation-success").remove();
    console.log("delete");
    deleteInlinebtn = $(this);
    deleteInlineId = $(this).attr("data-row-id");
    console.log("delete " + deleteInlineId);
    $("#deleteEditInvoiceModal").modal("show");
  });

  $("#confirmEditDeleteBtn").on("click", function (e) {
    e.preventDefault();
    $.ajax({
      url: `${baseURL}/invoices/` + deleteInlineId,
      method: "DELETE",
      headers:{
        "Authorization":"Bearer "+localStorage.getItem("token")
      },
      success: function () {
        $("#deleteEditInvoiceModal").modal("hide");
        $("#deleteEditSuccessModal").modal("show");
        deleteInlinebtn.parents("tr").remove();
      },
      error: function () {
        console.log(error);
      },
    });
  });
});
