<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
                xmlns:html="http://www.w3.org/TR/REC-html40"
                xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>XML Sitemap | EUNOIA Technologies</title>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<style type="text/css">
					body {
						font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
						background-color: #050508;
						color: #cbd5e1;
						margin: 0;
						padding: 40px;
						line-height: 1.6;
					}
					.container {
						max-width: 1000px;
						margin: 0 auto;
						background: rgba(15, 23, 42, 0.6);
						border: 1px solid rgba(0, 212, 255, 0.2);
						border-radius: 20px;
						padding: 40px;
						backdrop-filter: blur(10px);
						box-shadow: 0 20px 50px rgba(0,0,0,0.5);
					}
					h1 {
						color: #00d4ff;
						margin: 0 0 10px;
						font-weight: 700;
						letter-spacing: -1px;
					}
					.stats {
						margin-bottom: 30px;
						padding: 15px;
						background: rgba(0, 212, 255, 0.05);
						border-radius: 10px;
						border: 1px solid rgba(0, 212, 255, 0.1);
						font-size: 0.9em;
					}
					table {
						width: 100%;
						border-collapse: collapse;
						margin-top: 20px;
					}
					th {
						text-align: left;
						border-bottom: 2px solid rgba(0, 212, 255, 0.2);
						padding: 12px;
						color: #8338ec;
						font-weight: 600;
						text-transform: uppercase;
						font-size: 0.8em;
						letter-spacing: 1px;
					}
					td {
						padding: 12px;
						border-bottom: 1px solid rgba(255, 255, 255, 0.05);
						font-size: 0.9em;
					}
					tr:hover td {
						background: rgba(0, 212, 255, 0.02);
					}
					a {
						color: #00d4ff;
						text-decoration: none;
						transition: all 0.3s ease;
					}
					a:hover {
						color: #ff006e;
						text-decoration: underline;
					}
					.lastmod {
						color: #64748b;
						font-family: monospace;
					}
					.priority-high { color: #22c55e; }
					.priority-mid { color: #f59e0b; }
					.footer {
						margin-top: 40px;
						text-align: center;
						font-size: 0.8em;
						color: #64748b;
					}
				</style>
			</head>
			<body>
				<div class="container">
					<h1>XML Sitemap</h1>
					<p>Technical directory for search engines, styled for human eyes.</p>
					
					<div class="stats">
						Total URLs in this sitemap: <xsl:value-of select="count(sitemap:urlset/sitemap:url)"/>
					</div>

					<table>
						<thead>
							<tr>
								<th>URL</th>
								<th>Priority</th>
								<th>Change Freq</th>
								<th>Last Modified</th>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="sitemap:urlset/sitemap:url">
								<tr>
									<td>
										<xsl:variable name="itemURL">
											<xsl:value-of select="sitemap:loc"/>
										</xsl:variable>
										<a href="{$itemURL}">
											<xsl:value-of select="sitemap:loc"/>
										</a>
									</td>
									<td>
										<span class="priority">
											<xsl:choose>
												<xsl:when test="sitemap:priority &gt; 0.7">
													<xsl:attribute name="class">priority-high</xsl:attribute>
												</xsl:when>
												<xsl:otherwise>
													<xsl:attribute name="class">priority-mid</xsl:attribute>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:value-of select="sitemap:priority"/>
										</span>
									</td>
									<td>
										<xsl:value-of select="sitemap:changefreq"/>
									</td>
									<td class="lastmod">
										<xsl:value-of select="sitemap:lastmod"/>
									</td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>

					<div class="footer">
						&copy; <xsl:value-of select="substring(sitemap:urlset/sitemap:url[1]/sitemap:lastmod, 1, 4)"/> EUNOIA Technologies. All rights reserved.
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
