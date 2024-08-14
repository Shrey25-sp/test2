<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE books [
    <!ENTITY xslt "
        <xsl:stylesheet version='1.0'
            xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
            <!-- Template to match the root element and generate HTML -->
            <xsl:template match='/'>
                <html>
                    <head>
                        <title>Book List</title>
                        <style>
                            table { border-collapse: collapse; width: 100%; }
                            th, td { border: 1px solid black; padding: 8px; text-align: left; }
                            th { background-color: #f2f2f2; }
                        </style>
                    </head>
                    <body>
                        <h1>Book List</h1>
                        <table>
                            <tr>
                                <th>Title</th>
                                <th>Author</th>
                                <th>Year</th>
                            </tr>
                            <!-- Apply templates to each book element -->
                            <xsl:apply-templates select='books/book'/>
                        </table>
                    </body>
                </html>
            </xsl:template>
            
            <!-- Template to match book elements and generate table rows -->
            <xsl:template match='book'>
                <tr>
                    <td><xsl:value-of select='title'/></td>
                    <td><xsl:value-of select='author'/></td>
                    <td><xsl:value-of select='year'/></td>
                </tr>
            </xsl:template>
        </xsl:stylesheet>
    "/>
]>

<books>
    <book>
        <title>Introduction to XSLT</title>
        <author>John Doe</author>
        <year>2024</year>
    </book>
    <book>
        <title>Advanced XSLT Techniques</title>
        <author>Jane Smith</author>
        <year>2023</year>
    </book>
</books>
