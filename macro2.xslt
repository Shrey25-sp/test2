<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:html="http://www.w3.org/1999/xhtml">

    <!-- Template to match the root element and generate HTML -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Employee List</title>
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
                        table = document.getElementById("employeeTable");
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
                        table = document.getElementById("employeeTable");
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
                <h1>Employee List</h1>
                <div class="search-bar">
                    <input type="text" id="searchInput" onkeyup="searchTable()" placeholder="Search for names, positions, or departments..">
                </div>
                <table id="employeeTable">
                    <thead>
                        <tr>
                            <th onclick="sortTable(0)">Name</th>
                            <th onclick="sortTable(1)">Position</th>
                            <th onclick="sortTable(2)">Department</th>
                            <th onclick="sortTable(3)">Salary</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Apply templates to each employee element -->
                        <xsl:apply-templates select="employees/employee"/>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>

    <!-- Template to match employee elements and generate table rows -->
    <xsl:template match="employee">
        <tr>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="position"/></td>
            <td><xsl:value-of select="department"/></td>
            <td><xsl:value-of select="salary"/></td>
        </tr>
    </xsl:template>

    <!-- Sample XML data included for demonstration purposes -->
    <xsl:template match="/">
        <employees>
            <employee>
                <name>John Doe</name>
                <position>Software Engineer</position>
                <department>Development</department>
                <salary>80000</salary>
            </employee>
            <employee>
                <name>Ja
