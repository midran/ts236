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
			<assert 
				id="IS-R-001"
				test=""
				flag="warning">Ef reikningur inniheldur virðisaukaskattsnúmer seljanda (BT-31) og það byrjar á IS en annars ef landakóti seljanda (BT-40) er IS þá ætti gerð reiknings (BT-3) að vera sölureikningur (380) eða kreditreikningur (381), sjá grein 5.5.</assert>

			<assert 
				id="IS-R-002"
				test=""
				flag="fatal">Ef reikningur inniheldur virðisaukaskattsnúmer seljanda (BT-31) og það byrjar á IS en annars ef landakóti seljanda (BT-40) er IS þá skal reikningur innihalda íslenska kennitölu seljanda (BT-30).</assert>				

			<assert 
				id="IS-R-003"
				test=""
				flag="fatal">Ef reikningur inniheldur virðisaukaskattsnúmer seljanda (BT-31) og það byrjar á IS en annars ef landakóti seljanda (BT-40) er IS þá skulu schemeID eigindi kennitölu seljanda (BT-30-1) vera 0196 .</assert>

			<assert 
				id="IS-R-004"
				test=""
				flag="fatal">Ef reikningur inniheldur virðisaukaskattsnúmer seljanda (BT-31) og það byrjar á IS en annars ef landakóti seljanda (BT-40) er IS þá skal heimilisfang seljanda innihalda götuheiti og póstnúmer (BT-35 og BT-38).</assert>

			<assert 
				id="IS-R-005"
				test=""
				flag="fatal">Ef reikningur inniheldur virðisaukaskattsnúmer seljanda (BT-31) og það byrjar á IS en annars ef landakóti seljanda (BT-40) er IS þá skal reikningurinn innihalda íslenska kennitölu kaupanda (BT-47) þegar landakóti kaupanda (BT-55) er IS.</assert>
			<assert 
				id="IS-R-006"
				test=""
				flag="fatal">Ef reikningur inniheldur virðisaukaskattsnúmer seljanda (BT-31) og það byrjar á IS en annars ef landakóti seljanda (BT-40) er IS þá skulu schemeID eigindi kennitölu kaupanda vera 0196 (BT-47-1) þegar landakóti kaupanda (BT-55) er IS.</assert>

			<assert 
				id="IS-R-007"
				test=""
				flag="fatal">Ef reikningur inniheldur virðisaukaskattsnúmer seljanda (BT-31) og það byrjar á IS en annars ef landakóti seljanda (BT-40) er IS þá skal heimilisfang kaupanda innihalda götuheiti og póstnúmer (BT-50 og BT-53) þegar landakóti kaupanda (BT-55) er IS.</assert>

			<assert 
				id="IS-R-008"
				test=""
				flag="fatal">Ef reikningur inniheldur virðisaukaskattsnúmer seljanda (BT-31) og það byrjar á IS en annars ef landakóti seljanda (BT-40) er IS þá skal Kröfustrengur vera 12 tölustafir þegar greiðslumáti er millifærsla.</assert>

			<assert 
				id="IS-R-009"
				test=""
				flag="fatal">Ef reikningur inniheldur virðisaukaskattsnúmer seljanda (BT-31) og það byrjar á IS en annars ef landakóti seljanda (BT-40) er IS þá skal koma fram kröfunúmer (BT-84) þegar greiðslumáti (BT-81) er krafa (kóti 9).</assert>

			<assert 
				id="IS-R-010"
				test=""
				flag="fatal">Ef reikningur inniheldur virðisaukaskattsnúmer seljanda (BT-31) og það byrjar á IS en annars ef landakóti seljanda (BT-40) er IS þá skal reikningnúmer (BT-84)  vera 12 tölustafir þegar greiðslumáti (BT-81) er millifærsla (kóti 42).</assert>

			<assert 
				id="IS-R-011"
				test=""
				flag="fatal">Ef reikningur inniheldur virðisaukaskattsnúmer seljanda (BT-31) og það byrjar á IS en annars ef landakóti seljanda (BT-40) er IS þá skal þá skal tilvísun (BT-122) vera á forminu YYYY-MM-DD þegar tegund skjals (BT-122) er eindagi (kóti 71).</assert>

			<assert 
				id="IS-R-012"
				test=""
				flag="fatal">Ef reikningur inniheldur virðisaukaskattsnúmer seljanda (BT-31) og það byrjar á IS en annars ef landakóti seljanda (BT-40) er IS þá skal reikningur sem inniheldur eindaga (BT-122, DocumentTypeCode = 71) einnig hafa gjalddaga (BT-9).</assert>

			<assert 
				id="IS-R-013"
				test=""
				flag="fatal">Ef reikningur inniheldur virðisaukaskattsnúmer seljanda (BT-31) og það byrjar á IS en annars ef landakóti seljanda (BT-40) er IS þá skal eindagi (BT-122, DocumentTypeCode = 71) skal vera sami eða síðar en gjalddagi (BT-9) ef eindagi er til staðar.</assert>

		</rule>
	</pattern>
</schema>
