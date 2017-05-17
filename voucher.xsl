<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:gvl="urn:ietf:params:xml:ns:vts-lang">
	<xsl:output method="html" version="1.0" encoding="UTF-8"
		indent="yes" />
	<xsl:template match="gvl:Voucher">
		<html lang="en">
			<head>
				<title>Contract</title>
				<meta charset="utf-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<link rel="stylesheet"
					href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
				<link rel="stylesheet" href="ricardianContract.css" />
				<script
					src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"
					type="text/javascript"></script>
				<script
					src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
					type="text/javascript"></script>
				<script type="text/javascript" src="web3.js"></script>
				<script type="text/javascript" src="bignumber.js"></script>
				<script type="text/javascript" src="ricardianToken.js"></script>
				<script type="text/javascript">
				</script>
				<style>
					.navbar {
					margin-bottom: 0;
					border-radius: 0;
					}
					/* Custom, iPhone
					Retina */
					@media only screen and (min-width : 320px) {
					}
				</style>
				<link rel="stylesheet" type="text/css" href="cc.css" />
			</head>
			<body>
				<div class="container bg-3">
					<div class="row">
						<div class="panel panel-default col-sm-6" align="left">
							<div class="panel-heading"><h2>ethereum</h2></div>
							<div class="panel-body">Panel Content</div>
						</div>
						<div class="panel panel-default col-sm-6" align="left">
							<div class="panel-heading"><h2>swarm</h2></div>
							<div class="panel-body">
								<h1>CONTRACT</h1>
								<strong>The following sample contract is provided with proof of concept purposes only. It does not pretend to represent a complete or legally valid document</strong>
								<h2>
									<xsl:value-of select="gvl:Title" />
								</h2>
								<p>PREAMBLE

WHEREAS, the Cooperative is organized and operated as a cooperative association under the [name of Act governing the Cooperative] for the mutual benefit of all members of the Cooperative. The Cooperative is organized with the intent of developing, owning, and operating [type of facility] processing facility (“Facility”); and

WHEREAS, this Agreement records legal relations between Member as seller and the Cooperative as buyer of the [commodity] and is a contract between Member and the Cooperative as authorized by and under [provide reference to statutory authority for marketing agreement].  Member has entered into this Agreement as a condition to becoming a member of the Cooperative in accordance with and subject to the Articles of Incorporation (“Articles”) and Bylaws of the Cooperative.  Member acknowledges that this Agreement includes as part of its terms each provision of the Articles, Bylaws and other reasonable policies, rules and regulations adopted by the Cooperative’s Board of Directors (“the Board”) pursuant thereto, as fully as though each provision was expressly set forth in this Agreement.  By signing this Agreement, Member acknowledges receipt of a copy of the Articles and the Bylaws.

WHEREAS, this Agreement has been entered into by Member and the Cooperative because the Cooperative desires to protect its interests by ensuring access to an adequate supply of [commodity], and Member desires to establish and protect its right to market a specified amount of [commodity] with the Cooperative on a patronage basis in accordance with the Articles and Bylaws.
								</p>
								<h2>
									The entity
								</h2>

								<p>
									(name as normally known by in the street)
									<strong>
										<xsl:value-of select="gvl:Issuer/gvl:name" />
									</strong>
									, (full legal name)
									<strong>
										<xsl:value-of select="gvl:Issuer/gvl:longname" />
									</strong>
									, (name as displayed by trading)
									<strong>
										<xsl:value-of select="gvl:Issuer/gvl:shortname" />
									</strong>

									, with postal address
									<strong>
										<xsl:value-of select="gvl:Issuer/gvl:postaddress" />
									</strong>
									, country
									<strong>
										<xsl:value-of select="gvl:Issuer/gvl:country" />
									</strong>
									, commercial registration number 
									<strong>
										<xsl:value-of select="gvl:Issuer/gvl:registration" />
									</strong>
									, account
									<strong>
										<xsl:value-of select="gvl:Issuer/gvl:account" />
									</strong>
									, contract hash 
									<strong>
										<xsl:value-of select="gvl:Issuer/gvl:Bzz" />
									</strong>
									
								</p>
								<h2>
									The voucher
								</h2>
								<p>Issues the following token or voucher that can be redeemed against its products
								</p>
								<table>
									<tr>
										<td>currency</td>
										<td>
											<strong>
												<xsl:value-of select="gvl:Value/gvl:Fixed/gvl:currency" />
											</strong>
										</td>
									</tr>
									<tr>
										<td>voucherTokenSymbol</td>
										<td>
											<strong>
												<xsl:value-of select="gvl:Value/gvl:Fixed/gvl:voucherTokenSymbol" />
											</strong>
										</td>
									</tr>
									<tr>
										<td>voucherTokenLogoBzz</td>
										<td>
											<strong>
												<xsl:value-of select="gvl:Value/gvl:Fixed/gvl:voucherTokenLogoBzz" />
											</strong>
										</td>
									</tr>
									<tr>
										<td>amount</td>
										<td></td>
										<strong>
											<xsl:value-of select="gvl:Value/gvl:Fixed/gvl:amount" />
										</strong>
									</tr>
									<tr>
										<td>decimalPower</td>
										<td>
											<strong>
												<xsl:value-of select="gvl:Value/gvl:Fixed/gvl:decimalPower" />
											</strong>
										</td>
									</tr>
									<tr>
										<td>ETHEREUM Token Address</td>
										<td>
											<strong>0x67c846bc78f0ca5f19252d7aa24a055811b71d4a</strong>
										</td>
									</tr>
								</table>
								<h3>Valid Period</h3>
								<table class="table-bordered">
									<tr>
										<th>Sart</th>
										<th>End</th>
									</tr>
									<tr>
										<td>
											<xsl:value-of select="gvl:ValidPeriod/@start" />
										</td>
										<td>
											<xsl:value-of select="gvl:ValidPeriod/@end" />
										</td>
									</tr>
								</table>
								<h2>Definitions</h2>
								<p>Term of Agreement

 	a. Five Year Initial Term; Subsequent Three Year Evergreen Terms - The initial term of this Agreement commences as of the date it is approved and accepted by the Cooperative and shall continue for five (5) consecutive years after the date Member’s obligation to deliver [commodity] under this Agreement begins. Member’s obligation to deliver [commodity] under this Agreement shall begin upon receipt of written notice from the Cooperative, as determined by the Cooperative’s Board of Directors. This date is referred to as the “Starting Delivery Date.” Until the Starting Delivery Date, the Cooperative has no obligation to accept [commodity] from Member.

On the third anniversary of the Starting Delivery Date, this Agreement will automatically renew for a three-year term unless either party gives notice of termination as provided below. Each succeeding year this Agreement will be renewed in the same manner so that, unless notice of termination is given, there will always be a three year ongoing obligation for Member and the Cooperative under this Agreement.
b. Notice Termination. Either party has the right to terminate this Agreement at the end of the initial term and each three-year renewal term by giving written notice to the other party of such termination as follows: 

 	(1)  Notice of termination of the initial 5-year term must be given not more than 180 days nor less than 30 days before the third anniversary of the Starting Delivery Date. If such notice is given, Member and the Cooperative will have two years remaining under this Agreement instead of the three-year renewal term.
(2) Notice of termination after each renewal term must be given not more than 180 days nor less than 30 days before the next anniversary of the Starting Delivery Date. If Member gives notice after any number of renewal terms, Member and the Cooperative will have two years remaining under this Agreement.

c. Automatic Termination. This Agreement shall terminate automatically upon the occurrence of any one or more than one of the following events: the Cooperative ceases operations permanently; the Cooperative files a petition, either voluntarily or involuntarily, for protection under the bankruptcy laws; the Cooperative makes an assignment of its assets for the benefit of creditors, or is adjudged insolvent, or has a receiver appointed for it, or has a private or public foreclosure action brought against it or a majority of its personal or real property; or the Cooperative otherwise enters into an agreement with its lender or lenders to surrender a majority of its personal or real property assets.
								</p>

								<ul>
									<xsl:for-each select="gvl:Description">
										<li>
											<i>
												<xsl:value-of select="." />
											</i>
										</li>
									</xsl:for-each>
								</ul>
								<h2>Goods, Products and Merchandises</h2>
								<p>The Cooperative has the sole and complete discretion in all phases of the use of the [commodity], including any accepting, processing and marketing activity including, but not limited to, commingling, pooling or pledging [commodity] once accepted and pledging any products of the [commodity] as security for loans to any lending institution or other lender.

The Cooperative may, in its sole discretion, market any [commodity] delivered under this Agreement on an open market basis if the Facility cannot handle all of the [commodity] committed under Agreements. The proceeds from the [commodity] sold on the open market will be added to all other proceeds of the Cooperative and allocated to members as provided in the Bylaws.
								</p>
								<p>Member agrees to commit and deliver annually to the Cooperative or its designated grain handling agent, at the Cooperative’s facility(ies) or at locations designated by the Cooperative, one bushel of [commodity] for each share of Class A preferred stock held by the Member (the “Committed Bushels”), in accordance with the delivery periods and delivery schedules established in accordance with this Agreement. Member understands and agrees that the Cooperative may procure additional [commodity] for and on behalf of Member to market through the Cooperative (in addition to the one bushel per share of Class A preferred stock committed by Member hereunder), provided that any such additional procurement and marketing shall be done uniformly on behalf of all Members pro rata based on their Committed Bushels, and provided further that any such additional procurement shall be done at no out-of-pocket costs or charges to Member.

If Member’s production is reduced so that Member is unable to deliver the Committed Bushels under this Agreement, Member is required to obtain the [commodity] from another source, if available, and deliver the Committed Bushels to the Cooperative, as if the [commodity] had been produced by Member. Member will be excused from delivery without penalty only in the event of force majeure conditions beyond Member’s control consisting of drought, hail, uncontrollable infestation or other natural conditions specifically determined by the Board of Directors. If Member cannot deliver the Committed Bushels, Member agrees that the Cooperative, at its option, may act as Member’s agent for the purpose of obtaining the [commodity] in Member’s name and may charge to Member all expenses and incidental costs in obtaining and delivering the [commodity] to the Cooperative’s designated locations.

The Cooperative has no obligation to accept for marketing any [commodity] in an amount greater than that specified above, regardless of whether Member’s total [commodity] production has increased.</p>

								<ul>
									<xsl:for-each select="gvl:Merchandise">
										<li>
											<i>
												<xsl:value-of select="." />
											</i>
										</li>
									</xsl:for-each>
								</ul>
								<h2>Conditions</h2>
								<p>All [commodity] to be delivered by Member to the Cooperative shall be “commercially acceptable product” in accordance with Federal and State standards and in accordance with the standards set by the Cooperative. The Board has the right to establish production, variety, genetic and other quality requirements that must be met in order for [commodity] to meet the quality standards of the Cooperative. Product of substandard quality, as determined by the Cooperative, will, at the Cooperative’s option, be either:

 	a. rejected and returned to Member with all costs relating to the rejection and return charged to Member; or
 	b. accepted with deductions and allowances made and charged against Member because of the inferior grade, quality or condition at delivery.
If, in the Cooperative’s sole opinion, Member continually fails to deliver commercially acceptable [commodity], the Cooperative may terminate this Agreement and Member’s membership in the Cooperative in accordance with the Cooperative’s Articles and Bylaws.

The Cooperative will make rules and regulations for grading the quality of [commodity] and to standardize applicable discounts and premiums and the manner of handling and shipping [commodity]. Member agrees to observe any such rules and regulations and accept the grading established by the Cooperative. All disputed samples will be submitted to an official laboratory for grading and such official grade will become the determining grade. If there is a grade change in favor of the Member, the Company will pay for the sample. If the grade is not changed, Member will pay for the sample.
								</p>
								<ul>
									<xsl:for-each select="gvl:Condition">
										<li>
											<i>
												<xsl:value-of select="." />
											</i>
										</li>
									</xsl:for-each>
								</ul>
								<p align="right">
									signed
									<strong>
										<xsl:value-of select="gvl:Issuer/gvl:name" />
									</strong>
								</p>
								<p align="right">
									at
									<xsl:value-of select="gvl:Issuer/gvl:country" />
								</p>
							</div>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
