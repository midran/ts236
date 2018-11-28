<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils" schemaVersion="iso"
  queryBinding="xslt2">

	<title>Icelandic invoice rules</title>
  
	<ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" prefix="cbc"/>
	<ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" prefix="cac"/>
	<ns uri="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2" prefix="ubl-creditnote"/>
	<ns uri="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" prefix="ubl-invoice"/>
	<ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
	<ns uri="utils" prefix="u"/>

	<let name="supplierCountry"
		value="
			if (/*/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID, 1, 2)) then
				upper-case(normalize-space(/*/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID, 1, 2)))
			else
			if (/*/cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID, 1, 2)) then
				upper-case(normalize-space(/*/cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID, 1, 2)))
			else
				if (/*/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode) then
					upper-case(normalize-space(/*/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode))
			else
				'XX'"/>

  <!-- ICELAND -->
	<pattern>

		<rule context="cac:AccountingSupplierParty/cac:Party[$supplierCountry = 'IS']">

<!-- status verify -->
		<assert 
				id="IS-R-001"
				test="string-length(normalize-space(cbc:InvoiceTypeCode)) = '380 381'"
				flag="warning">Ef seljandi er íslenskur 
					þá ætti gerð reiknings (BT-3) að vera sölureikningur (380) eða kreditreikningur (381).</assert>
<!-- status draft -->
			<assert 
				id="IS-R-002"
				test="exists(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID) and cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID = '0196'"
				flag="fatal">Ef seljandi er íslenskur þá skal reikningur innihalda íslenska kennitölu seljanda (BT-30).</assert>

<!-- status draft -->
			<assert 
				id="IS-R-003"
				test="exists(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName) and exists(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone)"
				flag="fatal">Ef seljandi er íslenskur þá skal heimilisfang seljanda innihalda götuheiti og póstnúmer (BT-35 og BT-38).</assert>

<!-- status draft -->				
			<assert 
				id="IS-R-006"
				test="exists(cac:PaymentMeans[cbc:PaymentMeansCode = &apos;9&apos;]/cac:PayeeFinancialAccount/cbc:ID) 
					  and string-length(normalize-space(cac:PaymentMeans[cbc:PaymentMeansCode = &apos;9&apos;]/cac:PayeeFinancialAccount/cbc:ID)) = 12"
				flag="fatal">Ef seljandi er íslenskur og greiðslumáti (BT-81) er millifærsla (kóti 9)
					þá skal koma fram 12 stafa reikningnúmer (BT-84)</assert>

<!-- status draft -->
			<assert 
				id="IS-R-007"
				test="exists(cac:PaymentMeans[cbc:PaymentMeansCode = &apos;42&apos;]/cac:PayeeFinancialAccount/cbc:ID) 
					  and string-length(normalize-space(cac:PaymentMeans[cbc:PaymentMeansCode = &apos;42&apos;]/cac:PayeeFinancialAccount/cbc:ID)) = 12"
				flag="fatal">Ef seljandi er íslenskur og greiðslumáti (BT-81) er millifærsla (kóti 42) þá skal koma fram 12 stafa reikningnúmer (BT-84)</assert>

		</rule>

		<rule context="cac:AccountingSupplierParty/cac:Party[$supplierCountry = 'IS'] and cac:AdditionalDocumentReference/cbc:DocumentTypeCode = '71'">
<!-- status draft -->
			<assert 
				id="IS-R-008"
				test="string-length(cac:AdditionalDocumentReference/cbc:ID) = 10 and (string(.) castable as xs:date)"
				flag="fatal">Ef seljandi er íslenskur þá skal eindagi (BT-122, tegundarkóti 71) vera á forminu YYYY-MM-DD.</assert>
<!-- status draft -->
			<assert 
				id="IS-R-009"
				test="exist(cbc:DueDate)"
				flag="fatal">Ef seljandi er íslenskur þá skal reikningur sem inniheldur eindaga (BT-122, DocumentTypeCode = 71) einnig hafa gjalddaga (BT-9).</assert>
<!-- status draft -->
			<assert 
				id="IS-R-010"
				test="(cbc:DueDate) &lt;= (cac:AdditionalDocumentReference/cbc:ID)"
				flag="fatal">Ef seljandi er íslenskur þá skal eindagi (BT-122, DocumentTypeCode = 71) skal vera sami eða síðar en gjalddagi (BT-9) ef eindagi er til staðar.</assert>
					
		</rule>

		<rule context="cac:AccountingSupplierParty/cac:Party[$supplierCountry = 'IS'] and cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode = 'IS']">
<!-- status draft -->
			<assert 
				id="IS-R-004"
				test="exists(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID) and cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID = '0196'"
				flag="fatal">Ef seljandi og kaupandi eru íslenskir þá skal reikningurinn innihalda íslenska kennitölu kaupanda (BT-47).</assert>

<!-- status draft -->
			<assert 
				id="IS-R-005"
				test="exists(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName) and exists(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone)"
				flag="fatal">Ef seljandi og kaupandi eru íslenskir þá skal heimilisfang kaupanda innihalda götuheiti og póstnúmer (BT-50 og BT-53)</assert>

		</rule>
	</pattern>
</schema>
