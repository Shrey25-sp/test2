<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Template to match the root element and generate HTML -->
    <xsl:template match="/">
        <html>
            <head>
                <title>CD Catalog</title>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        margin: 20px;
                        color: #333;
                    }
                    table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-bottom: 20px;
                    }
                    th, td {
                        border: 1px solid #ddd;
                        padding: 8px;
                        text-align: left;
                    }
                    th {
                        background-color: #f4f4f4;
                        cursor: pointer;
                    }
                    th:hover {
                        background-color: #ddd;
                    }
                    .search-bar {
                        margin-bottom: 20px;
                    }
                    .search-bar input {
                        padding: 8px;
                        font-size: 16px;
                        width: 100%;
                        box-sizing: border-box;
                    }
                </style>
                <script>
                    function searchTable() {
                        var input, filter, table, tr, td, i, j, txtValue;
                        input = document.getElementById("searchInput");
                        filter = input.value.toUpperCase();
                        table = document.getElementById("cdTable");
                        tr = table.getElementsByTagName("tr");

                        for (i = 1; i < tr.length; i++) {
                            tr[i].style.display = "none";
                            td = tr[i].getElementsByTagName("td");
                            for (j = 0; j < td.length; j++) {
                                if (td[j]) {
                                    txtValue = td[j].textContent || td[j].innerText;
                                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                                        tr[i].style.display = "";
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    function sortTable(n) {
                        var table, rows, switching, i, x, y, shouldSwitch, dir, switchCount = 0;
                        table = document.getElementById("cdTable");
                        switching = true;
                        dir = "asc";
                        while (switching) {
                            switching = false;
                            rows = table.rows;
                            for (i = 1; i < (rows.length - 1); i++) {
                                shouldSwitch = false;
                                x = rows[i].getElementsByTagName("TD")[n];
                                y = rows[i + 1].getElementsByTagName("TD")[n];
                                if (dir === "asc") {
                                    if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                                        shouldSwitch = true;
                                        break;
                                    }
                                } else if (dir === "desc") {
                                    if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                                        shouldSwitch = true;
                                        break;
                                    }
                                }
                            }
                            if (shouldSwitch) {
                                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                                switching = true;
                                switchCount++;
                            } else {
                                if (switchCount === 0 && dir === "asc") {
                                    dir = "desc";
                                    switching = true;
                                }
                            }
                        }
                    }
                </script>
            </head>
            <body>
                <h1>CD Catalog</h1>
                <div class="search-bar">
                    <input type="text" id="searchInput" onkeyup="searchTable()" placeholder="Search for titles, artists, or countries..">
                </div>
                <table id="cdTable">
                    <thead>
                        <tr>
                            <th onclick="sortTable(0)">Title</th>
                            <th onclick="sortTable(1)">Artist</th>
                            <th onclick="sortTable(2)">Country</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Apply templates to each cd element -->
                        <xsl:apply-templates select="catalog/cd"/>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>

    <!-- Template to match cd elements and generate table rows -->
    <xsl:template match="cd">
        <tr>
            <td><xsl:value-of select="title"/></td>
            <td><xsl:value-of select="artist"/></td>
            <td><xsl:value-of select="country"/></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
