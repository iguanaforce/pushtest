USE [BCAKartuKredit_ExportText]
GO
/****** Object:  StoredProcedure [dbo].[spGenerateISACC]    Script Date: 8/30/2021 4:37:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Procedure [dbo].[spGenerateISACC]

AS
/******************************************************************************
**		File: 
**		Name: spGenerateISACC
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: WL
**		Date: 20190911
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		20200131	Galih				Initial Change for ISACC App
*******************************************************************************/

BEGIN
Select 
t_SourceCode, 
CASE WHEN c1_SmartCash = 'Yes' THEN t2_NamaTanpaSingkatan
	ELSE t2_NamaDiKartu 
END t2_NamaDiKartu,
--Perubahan Visa Platinum / MC Platinum
CASE WHEN (c1_Platinum = 'Yes' OR c1_MasterCardPlatinum = 'Yes' OR c1_BCACard = 'Yes') THEN  'Plat'
	ELSE c1_JenisKartu
end as c1_JenisKartu, 

Case when c1_SmartCash = 'Yes' then 'SMARTCASH'  
	else '' 
end +  
Case when c1_Corporate = 'Yes' then 'VISA CORPORATE'  
	else '' 
end +  
Case when c1_BLIBLICOM = 'Yes' then 'BLIBLI'  
	else '' 
end +  
Case when c1_TIKET = 'Yes' then 'TIKET'  
	else '' 
end +  
Case when c1_AMEX = 'Yes' then 'AMEX'  
	else '' 
end +  
Case when c1_BCAUnion = 'Yes' then 'BCA Union Pay'  
	else ''
	--tambahin
end + 
Case when ((c1_BCAMaster = 'Yes') or (c1_BCAVisa = 'Yes') or (c1_BCAMc2 = 'Yes') or (c1_BCAVisaBatman = 'Yes') or (c1_JCB = 'Yes') OR (c1_BCACard = 'Yes') or (c1_Everyday = 'Yes') OR (c1_Platinum = 'Yes') OR (c1_MasterCardPlatinum = 'Yes') OR (c1_World = 'Yes') or (c1_Matahari = 'Yes') or (c1_BCAUnion = 'Yes') or (c1_BLIBLICOM = 'Yes') or (c1_TIKET = 'Yes')or (c1_AMEX = 'Yes')) then ';' 
	else ''
	--
end +  
Case when c1_BCAMaster = 'Yes' then 'MASTERCARD PLATINUM'  
	else '' 
end +  
Case when (c1_BCAMaster = 'Yes') and (c1_BCAMc2 = 'Yes') then ';'  
	else '' 
end +  
Case when c1_BCAMc2 = 'Yes' then 'MASTERCARD GLOBE' 
	else '' 
end + 
Case when ((c1_BCAMaster = 'Yes') or (c1_BCAMc2 = 'Yes')) and (c1_BCAVisa = 'Yes') then ';' 
	else '' 
end + 
Case when c1_BCAVisa = 'Yes' then 'BCA VISA PLATINUM' 
	else '' 
end + 
Case when ((c1_BCAMaster = 'Yes') or (c1_BCAVisa = 'Yes') or (c1_BCAMc2 = 'Yes')) and (c1_BCAVisaBatman = 'Yes') then ';' 
	else '' 
end + 
Case when c1_BCAVisaBatman = 'Yes' then 'BCA VISA BATMAN' 
	else '' 
end + 
Case when ((c1_BCAMaster = 'Yes') or (c1_BCAVisa = 'Yes') or (c1_BCAMc2 = 'Yes') or (c1_BCAVisaBatman = 'Yes')) and (c1_JCB = 'Yes') then ';' 
	else '' 
end + 
Case when c1_JCB = 'Yes' then 'JCB' 
	else '' 
end + 
Case when ((c1_BCAMaster = 'Yes') or (c1_BCAVisa = 'Yes') or (c1_BCAMc2 = 'Yes') or (c1_BCAVisaBatman = 'Yes') or (c1_JCB = 'Yes') or (c1_BCAUnion = 'Yes') or (c1_BLIBLICOM = 'Yes') or (c1_TIKET = 'Yes') or (c1_AMEX = 'Yes')) and (c1_BCACard = 'Yes') then ';' 
	else '' 
end + 

Case when c1_BCACard = 'Yes' THEN 'BCA Plat_inum'
	ELSE ''
END +

--Perubahan BCA Platinum / EVD
--Case when c1_BCACard = 'Yes' AND ((c1_MasterCardPlatinum = 'Yes') OR (c1_Platinum = 'Yes') ) then 'BCAPLAT' 
--	else ''
--END + 
--
--
--Case when c1_BCACard = 'Yes' AND ((c1_MasterCardPlatinum) = 'No' AND (c1_Platinum = 'No')) then 'BCACARD' 
--	else ''
--END + 

-----
Case when ((c1_BCAMaster = 'Yes') or (c1_BCAVisa = 'Yes') or (c1_BCAMc2 = 'Yes') or (c1_BCAVisaBatman = 'Yes') or (c1_JCB = 'Yes') OR (c1_BCACard = 'Yes') or (c1_BCAUnion = 'Yes') or (c1_BLIBLICOM = 'Yes') or (c1_TIKET = 'Yes') or (c1_AMEX = 'Yes')) and (c1_Everyday = 'Yes') then ';' 
	else '' 
end + 
Case when c1_Everyday = 'Yes' then 'BCA Everyday Card' 
	else ''
END + 
Case when ((c1_BCAMaster = 'Yes') or (c1_BCAVisa = 'Yes') or (c1_BCAMc2 = 'Yes') or (c1_BCAVisaBatman = 'Yes') or (c1_JCB = 'Yes') OR (c1_BCACard = 'Yes') or (c1_Everyday = 'Yes') or (c1_BCAUnion = 'Yes') or (c1_BLIBLICOM = 'Yes') or (c1_TIKET = 'Yes') or (c1_AMEX = 'Yes')) and (c1_Platinum = 'Yes') then ';' 
	else '' 
end + 
Case when (c1_Platinum = 'Yes' and c1_Carrefour = 'No')  then 'BCA VISA PLATINUM' 
	 when (c1_Platinum = 'Yes' and c1_Carrefour = 'Yes')  then 'BCA VISA BLACK' 
	else ''
END +
Case when ((c1_BCAMaster = 'Yes') or (c1_BCAVisa = 'Yes') or (c1_BCAMc2 = 'Yes') or (c1_BCAVisaBatman = 'Yes') or (c1_JCB = 'Yes') OR (c1_BCACard = 'Yes') or (c1_Everyday = 'Yes') OR (c1_Platinum = 'Yes') or (c1_BCAUnion = 'Yes') or (c1_BLIBLICOM = 'Yes') or (c1_TIKET = 'Yes') or (c1_AMEX = 'Yes'))and (c1_MasterCardPlatinum = 'Yes') then ';' 
	else '' 
end + 
Case when (c1_MasterCardPlatinum = 'Yes' and c1_Carrefour = 'No') then 'BCA MasterCard PLATINUM'  
	 when (c1_MasterCardPlatinum = 'Yes' and c1_Carrefour = 'Yes') then 'BCA MasterCard Black'  
	else '' 
end +  
Case when ((c1_BCAMaster = 'Yes') or (c1_BCAVisa = 'Yes') or (c1_BCAMc2 = 'Yes') or (c1_BCAVisaBatman = 'Yes') or (c1_JCB = 'Yes') OR (c1_BCACard = 'Yes') or (c1_Everyday = 'Yes') OR (c1_Platinum = 'Yes') OR (c1_MasterCardPlatinum = 'Yes') or (c1_BCAUnion = 'Yes') or (c1_BLIBLICOM = 'Yes') or (c1_TIKET = 'Yes') or (c1_AMEX = 'Yes')) AND (c1_World = 'Yes') then ';' 
	else '' 
end + 
Case when c1_World = 'Yes' THEN 'World'
	else '' 
end +
Case when ((c1_BCAMaster = 'Yes') or (c1_BCAVisa = 'Yes') or (c1_BCAMc2 = 'Yes') or (c1_BCAVisaBatman = 'Yes') or (c1_JCB = 'Yes') OR (c1_BCACard = 'Yes') or (c1_Everyday = 'Yes') OR (c1_Platinum = 'Yes') OR (c1_MasterCardPlatinum = 'Yes') OR (c1_World = 'Yes') or (c1_BCAUnion = 'Yes') or (c1_BLIBLICOM = 'Yes') or (c1_TIKET = 'Yes') or (c1_AMEX = 'Yes')) AND (c1_Indomaret = 'Yes') then ';' 
	else '' 
end + 
Case when c1_Indomaret = 'Yes' then 'BCA Indomaret'  
	else '' 
end +  
Case when ((c1_BCAMaster = 'Yes') or (c1_BCAVisa = 'Yes') or (c1_BCAMc2 = 'Yes') or (c1_BCAVisaBatman = 'Yes') or (c1_JCB = 'Yes') OR (c1_BCACard = 'Yes') or (c1_Everyday = 'Yes') OR (c1_Platinum = 'Yes') OR (c1_MasterCardPlatinum = 'Yes') OR (c1_World = 'Yes') or (c1_Indomaret = 'Yes') or (c1_BCAUnion = 'Yes') or (c1_BLIBLICOM = 'Yes') or (c1_TIKET = 'Yes') or (c1_AMEX = 'Yes')) AND (c1_Matahari = 'Yes') then ';' 
	else '' 
end + 
Case when c1_Matahari = 'Yes' then 'BCA Matahari'  
	else '' 
end + 
Case when c1_BWS = 'Yes' then 'BWS'  
	else ''
 
--END +
--Case when ((c1_BCAMaster = 'Yes') or (c1_BCAVisa = 'Yes') or (c1_BCAMc2 = 'Yes') or (c1_BCAVisaBatman = 'Yes') or (c1_JCB = 'Yes') OR (c1_BCACard = 'Yes') or (c1_Everyday = 'Yes') OR (c1_Platinum = 'Yes') OR (c1_MasterCardPlatinum = 'Yes') OR (c1_World = 'Yes')) AND (c1_Corporate = 'Yes') then ';' 
--	else '' 
--end + 
--Case when c1_Corporate = 'Yes' THEN 'VISACORPORATE'
--	else '' 

--tambah SQ
end +  
Case when ((c1_BCAMaster = 'Yes') or (c1_BCAVisa = 'Yes') or (c1_BCAMc2 = 'Yes') or (c1_BCAVisaBatman = 'Yes') or (c1_JCB = 'Yes') OR (c1_BCACard = 'Yes') or (c1_Everyday = 'Yes') OR (c1_Platinum = 'Yes') OR (c1_MasterCardPlatinum = 'Yes') OR (c1_World = 'Yes') or (c1_Matahari = 'Yes') or (c1_BCAUnion = 'Yes') or (c1_BLIBLICOM = 'Yes') or (c1_TIKET = 'Yes') or (c1_AMEX = 'Yes')) AND (t11_JenisKartu <>'')  then ';' 
	else '' 

end + 
Case when t11_JenisKartu = 'Infinite' then 'SINGAPORE PPS INFINITE'  
	else ''
end + 
Case when t11_JenisKartu = 'Signature' then 'SINGAPORE SIGNATURE'  
	else ''
end + 
Case when t11_JenisKartu = 'Infinite Non PPS ' then 'SINGAPORE INFINITE'  
	else ''


end as c1_JenisProduk,

t2_NamaTanpaSingkatan, 
case when t2_Kewarganegaraan = '' then t2_Kewarganegaraan else left(t2_Kewarganegaraan,2) end t2_Kewarganegaraan, 
case when t2_IDIdentitas = '' then t2_IDIdentitas else Left(t2_IDIdentitas,1) end t2_IDIdentitas, 
case when t2_IDIdentitas = '2 - Pasport' then REPLACE(t2_KTP, ' ', '')
	 when t2_IDIdentitas = '1 - KTP' then t2_KTP 
end t2_KTP, 
-- case when t2_ktp like '%0' then right(t2_ktp,8) 
	-- end t2_ktp,
t2_NamaIbuKandung, 
t2_TempatLahir, 
case when t2_TanggalLahir = '' then t2_TanggalLahir 
	else right(t2_TanggalLahir,2) + '-' + right(left(t2_TanggalLahir,6),2) + '-' + left(t2_TanggalLahir,4)
	end t2_TanggalLahir, 
case when c2_JenisKelamin = '' then c2_JenisKelamin else cast(Left(c2_JenisKelamin,2) as int)-1 end c2_JenisKelamin, 
t2_AlamatRumah,
t2_AlamatRumah2, 
t2_KodePos, 
case 
	--when CHARINDEX('jakarta barat', LOWER(t2_Kota)) > 0 then 'JAKARTA'
	--when CHARINDEX('jakarta pusat', LOWER(t2_Kota)) > 0 then 'JAKARTA'
	--when CHARINDEX('jakarta selatan', LOWER(t2_Kota)) > 0 then 'JAKARTA'
	--when CHARINDEX('jakarta timur', LOWER(t2_Kota)) > 0 then 'JAKARTA'
	--when CHARINDEX('jakarta utara', LOWER(t2_Kota)) > 0 then 'JAKARTA'
	when t2_Kota = '' then UPPER(t2_Kota) 
	else UPPER(t2_Kota)
	end t2_Kota
	, 
'01' t2_Negara, 
case when t2_TeleponRumahKodeArea='' then t2_TeleponRumah 
     when t2_TeleponRumahKodeArea <> '' then t2_TeleponRumahKodeArea + t2_TeleponRumah 
end t2_TeleponRumah, 
t2_NoHPKodeProvider + t2_NoHP t2_NoHP, 
case when c2_AlamatPenagihan = '' then '0'
	 when c2_AlamatPengirimanKartu = '' then '0' --changes corr_pref_mail_addr = 3 maka pref_card_addr harus ada isinya 09/08/2020
else Left(c2_AlamatPenagihan,1) end c2_AlamatPenagihan, 
case when c2_StatusRumah = '' then c2_StatusRumah
	 --when left(c2_StatusRumah,2) = '04' then '03'
	 else Left(c2_StatusRumah,2) end c2_StatusRumah, 
case when c2_StatusPerkawinan = '' then c2_StatusPerkawinan else Left(c2_StatusPerkawinan,2) end c2_StatusPerkawinan, 
right('00' + t2_JumlahTanggungan, 2) t2_JumlahTanggungan, 
right('00' + t2_LamaMenempatiTahun,2) t2_LamaMenempatiTahun, 
right('00' + t2_LamaMenempatiBulan,2) t2_LamaMenempatiBulan, 
case when c1_SmartCash = 'Yes' THEN Left(c2_PendidikanSmartCash,2) 
else Left(c2_Pendidikan,2) end c2_Pendidikan, 

t3_NamaPerusahaan, 
case when t3_BidangUsaha = '' then t3_BidangUsaha else Left(t3_BidangUsaha,2) end t3_BidangUsaha, 
t3_NPWP, 
t3_AlamatPerusahaan, 
t3_AlamatPerusahaan2, 
right('00' + t3_LamaBekerjaTahun,2) t3_LamaBekerjaTahun, 

CASE WHEN c1_SmartCash = 'Yes' THEN ''
	ELSE right('00' + t3_LamaBekerjaBulan,2) 
END t3_LamaBekerjaBulan, 

t3_KodePos, 
t3_Kota, 
case when t3_TeleponKodeArea='' then t3_Telepon 
     when t3_TeleponKodeArea <> '' then t3_TeleponKodeArea+t3_Telepon 
end t3_Telepon, 
t3_TeleponExtension, 

t3_AlamatEmail, 
case when t3_Jabatan = '' then t3_Jabatan else Left(t3_Jabatan,2) end t3_Jabatan, 
t3_PenghasilanPerBulan, 
t3_PenghasilanTambahan, 
t3_NamaPerusahaanSebelumnya, 

CASE WHEN c1_SmartCash = 'Yes' THEN ''
	ELSE right('00' + t3_LamaBekerjaTahunSebelumnya,2) 
END t3_LamaBekerjaTahunSebelumnya, 

CASE WHEN c1_SmartCash = 'Yes' THEN ''
	ELSE right('00' + t3_LamaBekerjaBulanSebelumnya,2) 
END t3_LamaBekerjaBulanSebelumnya, 

CASE WHEN c1_SmartCash = 'Yes' THEN left(t16_NamaBankTabungan,2) 
	WHEN t4_NamaBank = '' THEN t4_NamaBank
	ELSE left(t4_NamaBank,2) 
end t4_NamaBank,

CASE WHEN c1_SmartCash = 'Yes' THEN left(c4_JenisRekening,3) 
	WHEN c4_JenisRekening = '' THEN c4_JenisRekening
	ELSE left(c4_JenisRekening,3) 
end c4_JenisRekening,

--case when t4_NamaBank = '' then t4_NamaBank else left(t4_NamaBank,2) end t4_NamaBank, 
--case when c4_JenisRekening = '' then c4_JenisRekening else Left(c4_JenisRekening,3) end c4_JenisRekening, 

CASE WHEN c1_SmartCash = 'Yes' THEN left(t16_NoRekeningTabungan,15)
	--WHEN cast(t4_NoRekening as bigint) = 0 THEN ''
	WHEN t4_NoRekening = '00000000000000000000' THEN t4_NoRekening+NULL
	ELSE left(t4_NoRekening,15)
END t4_NoRekening, 

Case when c5_MasterCard = 'Yes' then 'MASTERCARD'  
	else '' 
end +  
Case when (c5_MasterCard = 'Yes') and (c5_Lainnya = 'Yes') then ';'  
	else '' 
end +  
Case when c5_Lainnya = 'Yes' then 'LAINNYA' 
	else '' 
END +
Case when ((c5_MasterCard = 'Yes') or (c5_Lainnya = 'Yes')) AND(t5_BCACard = 'Yes') then ';'  
	else '' 
end + 
Case when t5_BCACard = 'Yes' then 'B' 
	else '' 
END +
Case when ((c5_MasterCard = 'Yes') or (c5_Lainnya = 'Yes') or(t5_BCACard = 'Yes')) AND (t5_VisaCard='Yes') then ';'  
	else '' 
end + 
Case when t5_VisaCard = 'Yes' then 'V' 
	else '' 
end c5_JenisKartu, 
t5_NoMasterCard + t5_NoMasterCard2 + t5_NoMasterCard3 + t5_NoMasterCard4 t5_NoMasterCard, 
case when t5_ExpiredMasterCardBulan = '' then t5_ExpiredMasterCardBulan 
	else t5_ExpiredMasterCardBulan + t5_ExpiredMasterCardTahun 
end t5_ExpiredMasterCard, 
t5_NoLainnya + t5_NoLainnya2 + t5_NoLainnya3 + t5_NoLainnya4 t5_NoLainnya, 
case when t5_ExpiredLainnyaBulan = '' then t5_ExpiredLainnyaBulan 
	else t5_ExpiredLainnyaBulan + t5_ExpiredLainnyaTahun 
end t5_ExpiredLainnya, 

t6_Nama, 
case when t6_Hubungan = '' then t6_Hubungan
when left(t6_hubungan,2) = '01' then '5'
when left(t6_hubungan,2) = '02' then '2'
when left(t6_hubungan,2) = '05' then '1'
when left(t6_hubungan,2) = '15' then '15'
when left(t6_hubungan,2) = '19' then '79'
when left(t6_hubungan,2) = '20' then '80'
--when left(t6_hubungan,2) = '80' then '80'
else left(t6_hubungan,2) end t6_Hubungan, 
CONCAT(t6_Alamat,'',t6_Alamat2) as t6_Alamat,
t6_Alamat2, 
t6_BCACard + t6_BCACard2 + t6_BCACard3 + t6_BCACard4 t6_BCACard, 
case when t6_TeleponRumahKodeArea='' then t6_TeleponRumah 
     when t6_TeleponRumahKodeArea <> '' then t6_TeleponRumahKodeArea + t6_TeleponRumah 
end t6_TeleponRumah, 
t6_NoHPKodeProvider + t6_NoHP t6_NoHP, 
case when t6_TeleponKantorKodeArea='' then t6_TeleponKantor 
     when t6_TeleponKantorKodeArea <> '' then t6_TeleponKantorKodeArea + t6_TeleponKantor 
end t6_TeleponKantor, 
t6_TeleponKantorExtension, 

case when c7_DebetRekening='Ya' then 'Y' 
     when c7_DebetRekening='Tidak' then 'N' 
     when c7_DebetRekening= '' then 'N' 
end as c7_DebetRekening, 
t7_NoRekeningBCA, 
case when c7_Sebesar = '' then c7_Sebesar 
     when c7_Sebesar = '10' then 1
     when c7_Sebesar = '30' then 2
     when c7_Sebesar = '50' then 3
     when c7_Sebesar = '100' then 4
     else Left(c7_Sebesar,1) 
end c7_Sebesar, 

case when c8_BCALife='Ya' then 'Y' 
     when c8_BCALife='Tidak' then 'N' 
     when c8_BCALife= '' then 'N' 
end as c8_BCALife, 

case when c9_PIN='Ya' then 'Y' 
     when c9_PIN='Tidak' then 'N' 
     when c9_PIN= '' then 'N' 
end as c9_PIN, 

case when len(t10_Nama) < 1 then NULL 
	when t10_Nama = '' then NULL 
	else t10_Nama end t10_Nama , 
case when t10_TanggalLahir = '' then t10_TanggalLahir 
    else right(t10_TanggalLahir,2) + '-' + right(left(t10_TanggalLahir,6),2) + '-' + left(t10_TanggalLahir,4)
end t10_TanggalLahir, 
case when t10_Hubungan = '' then t10_Hubungan 
when left(t10_hubungan,2) = '01' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '02' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '03' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '04' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '05' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '06' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '07' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '08' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '09' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '10' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '11' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '12' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '13' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '14' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '15' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '16' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '17' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '18' then left(t10_hubungan,2)
when left(t10_hubungan,2) = '19' then left(t10_hubungan,2)
    else '19' 
end t10_Hubungan, 
t10_Limit, 

t11_Catatan, 
t11_KreditLimit, 
t11_NoBCACard + t11_NoBCACard2 + t11_NoBCACard3 + t11_NoBCACard4 t11_NoBCACard,
t11_KodeKCU, 
t11_KodeKCP, 
t11_BesarJaminan, 
t11_JenisJaminan, 
t11_NoRekening, 
t11_JatuhTempo, 
t11_CIS, 

case when c1_SmartCash = 'Yes' THEN t12_NamaReferral
	else t12_nama end t12_nama,
case when c1_SmartCash = 'Yes' THEN t12_NoRekBCAReferral
	when (t12_NoRekeningBCA = '')and(c1_SmartCash = 'No') THEN t16_NoRekeningTabungan
	else t12_NoRekeningBCA end t12_NoRekeningBCA,
case when c1_SmartCash = 'Yes' THEN t12_NIPReferral
	else t12_NIP end t12_NIP,

-- Implementasi untuk pusat jadi 0960
-- when t12_KCU = '' then t12_KCU else right(t12_KCU,4) end t12_KCU, 
('0960') as t12_KCU,
case when t12_KCP = '' then t12_KCP else right(t12_KCP,4) end t12_KCP, 

t13_NomorKartu + t13_NomorKartu2 + t13_NomorKartu3 + t13_NomorKartu4 t13_NomorKartu, 
t13_AtasNama, 
case when t13_BankPenerbit = '' then t13_BankPenerbit 
    else left(t13_BankPenerbit,2) 
end t13_BankPenerbit, 
case when t13_AnggotaBulan = '' then '' 
         when t13_AnggotaBulan = '00' then '12'	
    else t13_AnggotaBulan 
end t13_AnggotaBulan, 
case when t13_AnggotaTahun = '' OR t13_AnggotaTahun = '0' then '' 
         when t13_AnggotaTahun = '0000' then '1999'
    else t13_AnggotaTahun 
end t13_AnggotaTahun, 
t13_Jumlah, 
case when t13_Tanggal = '' then t13_Tanggal 
	else right(t13_Tanggal,2) + '/' + right(left(t13_Tanggal,6),2) + '/' + right(left(t13_Tanggal,4),2)
end t13_Tanggal, 
t13_NamaJelas, 

Case when t11_isApprove = 'Ya' then 'Y' else 'N' end t11_isApprove,
OperatorName,
ApplicationID,

request_attempt,
('') as t10_Jabatan,
('') as t10_BidangUsaha,
('') as t10_Hp,
('') as t10_Gender,
('') as t10_Card,
('') as t_SelTypeCard,
('') as Is_AtmOverseas,

Sisipan,
case when isAKKIBlackList = '1' then 1 else 0 end isAKKIBlackList,
ScanNumber,
left(Aging + '                                                                                                                                                                                              ',182) as Aging,
left(CancelDate + '                                                                                                                                                                                                        ', 200) as CancelDate,
left(Amount + '                                                                                                                                                                                                        ',200) as Amount,
replace(ScanDate, '/', '-') as ScanDate,
BatchBundle,

--Tambahan
--World
t15_Nama,
t15_ID,
t15_Alamat,
t15_Alamat2,
t15_NoHPKodeProvider + t15_NoHP t15_NoHP,
case when t15_TelpKantorKodeArea='' then t15_TelpKantorKodeArea 
     when t15_TelpKantorKodeArea <> '' then t15_TelpKantorKodeArea + '-' + t15_TelpKantor 
end t15_TelpKantor, 
t15_TeleponKantorExtension,
t15_AlamatEmail,

--Corporate
t_CorporateID,
case when t3_JumlahKaryawan = '' then t3_JumlahKaryawan else left(t3_JumlahKaryawan,2) end t3_JumlahKaryawan,
t3_NamaPIC,
case when t3_TeleponPICKodeArea='' then t3_TeleponPICKodeArea 
     when t3_TeleponPICKodeArea <> '' then t3_TeleponPICKodeArea + t3_TeleponPIC 
end t3_TeleponPIC, 
t3_AlamatEmailPIC,
t3_NamaPIC2,
case when t3_TeleponPIC2KodeArea='' then t3_TeleponPIC2KodeArea 
     when t3_TeleponPIC2KodeArea <> '' then t3_TeleponPIC2KodeArea + t3_TeleponPIC2 
end t3_TeleponPIC2, 
t3_AlamatEmailPIC2,
t6_KodePos,

--Hartono
t2_MasaBerlakuKTP,

--SmartCash
case when c2_PendidikanSmartCash = '' then c2_PendidikanSmartCash 
	else Left(c2_PendidikanSmartCash,2) 
end c2_PendidikanSmartCash, 

t2_NoRekeningBCA,
case when t3_JumlahKaryawanSmartCash = '' then t3_JumlahKaryawanSmartCash 
	else left(t3_JumlahKaryawanSmartCash,2) 
end t3_JumlahKaryawanSmartCash,
t3_AlamatPerusahaanSebelumnya1,
t3_AlamatPerusahaanSebelumnya2,
t16_JumlahPinjaman,
t16_Terbilang1,
t16_Terbilang2,

Case when t16_PinjamanDiBCA = 'Yes' then '01'  
	else '' 
end +  
Case when (t16_PinjamanDiBCA = 'Yes') and (t16_PinjamanDiBankLain = 'Yes') then ';'  
	else '' 
end +  
Case when t16_PinjamanDiBankLain = 'Yes' then '02' 
	else '' 
END +
Case when ((t16_PinjamanDiBCA = 'Yes') or (t16_PinjamanDiBankLain = 'Yes')) AND(t16_TidakAdaPinjaman = 'Yes') then ';'  
	else '' 
end + 
Case when t16_TidakAdaPinjaman = 'Yes' then '03' 
	else '' 
end t16_PinjamanDi, 

t16_PinjamanCabangBCA,
t16_JenisPinjamanBCA,
t16_JumlahPinjamanBCA,

case when t16_PinjamanBankLain = '' then t16_PinjamanBankLain 
    else left(t16_PinjamanBankLain,2) 
end t16_PinjamanBankLain, 
t16_PinjamanCabangBankLain,
t16_JenisPinjamanBankLain,
t16_JumlahPinjamanBankLain,

case when t16_NamaBankTabungan = '' then t16_NamaBankTabungan 
    else left(t16_NamaBankTabungan,2) 
end t16_NamaBankTabungan, 
t16_NoRekeningTabungan,

CASE WHEN c1_SmartCash = 'Yes' THEN right('00' + t16_NasabahSejakTahun,2) 
	ELSE ''
END t16_NasabahSejakTahun, 


CASE WHEN c1_SmartCash = 'Yes' THEN right('00' + t16_NasabahSejakBulan,2)
	ELSE ''
END t16_NasabahSejakBulan, 

case when t16_NamaBankTabungan2 = '' then t16_NamaBankTabungan2 
    else left(t16_NamaBankTabungan2,2) 
end t16_NamaBankTabungan2, 
t16_NoRekeningTabungan2,

CASE WHEN c1_SmartCash = 'Yes' THEN right('00' + t16_NasabahSejakTahun2,2)
	ELSE ''
END t16_NasabahSejakTahun2, 


CASE WHEN c1_SmartCash = 'Yes' THEN right('00' + t16_NasabahSejakBulan2,2)
	ELSE ''
END t16_NasabahSejakBulan2, 


t5_NoBCACard1 + t5_NoBCACard2 + t5_NoBCACard3 + t5_NoBCACard4 t5_NoBCACard, 
case when t5_ExpiredBCACardBulan = '' then t5_ExpiredBCACardBulan 
	else t5_ExpiredBCACardBulan + t5_ExpiredBCACardTahun 
end t5_ExpiredBCACard, 

t5_NoVisaCard1 + t5_NoVisaCard2 + t5_NoVisaCard3 + t5_NoVisaCard4 t5_NoVisaCard, 
case when t5_ExpiredVisaCardBulan = '' then t5_ExpiredVisaCardBulan 
	else t5_ExpiredVisaCardBulan + t5_ExpiredVisaCardTahun 
end t5_ExpiredVisaCard, 


t6_Kota,
t12_NamaReferral,
t12_NIPReferral,
t12_NoRekBCAReferral,
t12_NamaAO,
t12_NIPAO,
t12_NoRekeningBCAAO,
t12_NamaPejabat1,
t12_NIPPejabat1,
t12_NamaPejabat2,
t12_NIPPejabat2,
t12_Cabang,

t17_NamaPerusahaan,
t17_NoCustomer,
t17_Alamat1,
t17_Alamat2,

CASE WHEN c1_SmartCash = 'Yes' THEN right('00' + t17_LamaRekananTahun,2)
	ELSE ''
END t17_LamaRekananTahun, 


CASE WHEN c1_SmartCash = 'Yes' THEN right('00' + t17_LamaRekananBulan,2)
	ELSE ''
END t17_LamaRekananBulan,


--tambahan Field Baru Everyday
--t2_NamaTanpaSingkatan,
--t2_NamaDiKartu,
--t10_NoHPKodeProvider + t10_NoHP t10_NoHP

--tambahan Persetujuan

case when c7_Persetujuan = 'Ya' then '10000' 
when c7_Persetujuan = 'Tidak' then '00000'
    else '00000' 
end c7_Persetujuan,

c_Verifikasi,

---***
--CASE WHEN c_Urgent = '1' THEN '0'
	--ELSE c_Verifikasi
--END c_Verifikasi,
----***

CASE WHEN len(c_Stamp) > 0 THEN c_Stamp
else ' '
end c_Stamp,


-- tambahan field Alamat pengiriman kartu

case when c2_AlamatPengirimanKartu = '' then c2_AlamatPengirimanKartu else Left(c2_AlamatPengirimanKartu,1) end c2_AlamatPengirimanKartu ,
t_IsBarCode,
--CASE WHEN cast(t_BarcodeValue as bigint) = 0 THEN '' 
--END t_BarcodeValue,
t_BarcodeValue,
t2_nama,
--t2_NamaTanpaSingkatan,
left(t2_NamaTanpaSingkatan,30) t2_NamaTanpaSingkatan,

-- tambah Urgent
CASE WHEN len(c_Urgent) > 0 THEN c_Urgent
	else ' '
end c_Urgent

from  
(  
	SELECT  
	CollectionName,  
	t_SourceCode, 
	t2_NamaDiKartu,
	c1_JenisKartu, 
	c1_BCAMaster, 
	c1_BCAMc2, 
	c1_BCAVisa, 
	c1_BCAVisaBatman, 
	c1_JCB, 
	c1_BCACard, 
	c1_Carrefour,
	c1_Platinum,
	c1_MasterCardPlatinum,
	c1_World,
	c1_Corporate,
	--tambahan Everyday
	c1_Everyday,
	t2_Nama, 
	t2_Kewarganegaraan, 
	t2_IDIdentitas, 
	t2_KTP, 
	t2_NamaIbuKandung, 
	t2_TempatLahir, 
	t2_TanggalLahir, 
	c2_JenisKelamin, 
	t2_AlamatRumah, 
	t2_AlamatRumah2, 
	t2_KodePos, 
	t2_Kota, 
	t2_TeleponRumahKodeArea, 
	t2_TeleponRumah, 
	t2_NoHPKodeProvider, 
	t2_NoHP, 
	c2_AlamatPenagihan, 
	c2_StatusRumah, 
	c2_StatusPerkawinan, 
	t2_JumlahTanggungan, 
	t2_LamaMenempatiTahun, 
	t2_LamaMenempatiBulan, 
	c2_Pendidikan, 

	t3_NamaPerusahaan, 
	t3_BidangUsaha, 
	t3_NPWP, 
	t3_AlamatPerusahaan, 
	t3_AlamatPerusahaan2, 
	t3_LamaBekerjaTahun, 
	t3_LamaBekerjaBulan, 
	t3_KodePos, 
	t3_Kota, 
	t3_TeleponKodeArea, 
	t3_Telepon, 
	t3_TeleponExtension, 
	t3_AlamatEmail, 
	t3_Jabatan, 
	t3_PenghasilanPerBulan, 
	t3_PenghasilanTambahan, 
	t3_NamaPerusahaanSebelumnya, 
	t3_LamaBekerjaTahunSebelumnya, 
	t3_LamaBekerjaBulanSebelumnya, 

	t4_NamaBank, 
	c4_JenisRekening, 
	t4_NoRekening, 

	c5_MasterCard, 
	c5_Lainnya, 
	t5_NoMasterCard, 
	t5_NoMasterCard2, 
	t5_NoMasterCard3, 
	t5_NoMasterCard4, 
	t5_ExpiredMasterCardBulan, 
	t5_ExpiredMasterCardTahun, 
	t5_NoLainnya, 
	t5_NoLainnya2, 
	t5_NoLainnya3, 
	t5_NoLainnya4, 
	t5_ExpiredLainnyaBulan, 
	t5_ExpiredLainnyaTahun, 

	t6_Nama, 
	t6_Hubungan, 
	t6_Alamat, 
	t6_Alamat2, 
	t6_BCACard, 
	t6_BCACard2, 
	t6_BCACard3, 
	t6_BCACard4, 
	t6_TeleponRumahKodeArea, 
	t6_TeleponRumah, 
	t6_NoHPKodeProvider, 
	t6_NoHP, 
	t6_TeleponKantorKodeArea, 
	t6_TeleponKantor, 
	t6_TeleponKantorExtension, 

	c7_DebetRekening, 
	t7_NoRekeningBCA, 
	c7_Sebesar, 

	c8_BCALife, 

	c9_PIN, 

	t10_Nama, 
	t10_TanggalLahir, 
	t10_Hubungan, 
	t10_Limit, 

	t11_Catatan, 
	t11_KreditLimit, 
	t11_NoBCACard, 
	t11_NoBCACard2, 
	t11_NoBCACard3, 
	t11_NoBCACard4, 
	t11_KodeKCU, 
	t11_KodeKCP, 
	t11_BesarJaminan, 
	t11_JenisJaminan, 
	t11_NoRekening, 
	t11_JatuhTempo, 
	t11_CIS, 
	t11_isApprove, 

	t12_Nama, 
	t12_NoRekeningBCA, 
	t12_NIP, 
	t12_KCU, 
	t12_KCP, 

	t13_NomorKartu, 
	t13_NomorKartu2, 
	t13_NomorKartu3, 
	t13_NomorKartu4, 
	t13_AtasNama, 
	t13_BankPenerbit, 
	t13_AnggotaBulan, 
	t13_AnggotaTahun, 
	t13_Jumlah, 
	t13_Tanggal, 
	t13_NamaJelas,
	OperatorName,
	ApplicationID,

	request_attempt,
	('') as t10_Jabatan,
	('') as t10_BidangUsaha,
	('') as t10_Hp,
	('') as t10_Gender,
	('') as t10_Card,
	('') as t_SelTypeCard,
	('') as Is_AtmOverseas,

	Sisipan,
	isAKKIBlackList,
	ScanNumber,
	Aging,
	CancelDate,
	Amount,
	ScanDate,
	BatchBundle,

	--World
	t15_Nama,
	t15_ID,
	t15_Alamat,
	t15_Alamat2,
	t15_NoHPKodeProvider,
	t15_NoHP,
	t15_TelpKantorKodeArea,
	t15_TelpKantor,
	t15_TeleponKantorExtension,
	t15_AlamatEmail,

	--Corporate
	t_CorporateID,
	t3_JumlahKaryawan,
	t3_NamaPIC,
	t3_TeleponPICKodeArea,
	t3_TeleponPIC,
	t3_AlamatEmailPIC,
	t3_NamaPIC2,
	t3_TeleponPIC2KodeArea,
	t3_TeleponPIC2,
	t3_AlamatEmailPIC2,
	t6_KodePos,

	--Hartono
	t2_MasaBerlakuKTP,


	--Smart Cash
	c1_SmartCash,
	c2_PendidikanSmartCash,
	t2_NoRekeningBCA,
	t3_JumlahKaryawanSmartCash,
	t3_AlamatPerusahaanSebelumnya1,
	t3_AlamatPerusahaanSebelumnya2,

	t16_JumlahPinjaman,
	t16_Terbilang1,
	t16_Terbilang2,

	t16_PinjamanDiBCA,
	t16_PinjamanDiBankLain,
	t16_TidakAdaPinjaman,

	t16_PinjamanCabangBCA,
	t16_JenisPinjamanBCA,
	t16_JumlahPinjamanBCA,

	t16_PinjamanBankLain,
	t16_PinjamanCabangBankLain,
	t16_JenisPinjamanBankLain,
	t16_JumlahPinjamanBankLain,

	t16_NamaBankTabungan,
	t16_NoRekeningTabungan,
	t16_NasabahSejakBulan,
	t16_NasabahSejakTahun,

	t16_NamaBankTabungan2,
	t16_NoRekeningTabungan2,
	t16_NasabahSejakBulan2,
	t16_NasabahSejakTahun2,

	t5_BCACard,
	t5_NoBCACard1,
	t5_NoBCACard2,
	t5_NoBCACard3,
	t5_NoBCACard4,
	t5_ExpiredBCACardBulan,
	t5_ExpiredBCACardTahun,

	t5_VisaCard,
	t5_NoVisaCard1,
	t5_NoVisaCard2,
	t5_NoVisaCard3,
	t5_NoVisaCard4,
	t5_ExpiredVisaCardBulan,
	t5_ExpiredVisaCardTahun,

	t6_Kota,

	t12_NamaReferral,
	t12_NIPReferral,
	t12_NoRekBCAReferral,

	t12_NamaAO,
	t12_NIPAO,
	t12_NoRekeningBCAAO,

	t12_NamaPejabat1,
	t12_NIPPejabat1,
	t12_NamaPejabat2,
	t12_NIPPejabat2,
	t12_Cabang,


	t17_NamaPerusahaan,
	t17_NoCustomer,
	t17_Alamat1,
	t17_Alamat2,
	t17_LamaRekananTahun,
	t17_LamaRekananBulan,


	--tambahan field baru everyday
	--t2_NamaTanpaSingkatan,
	--t2_NamaDiKartu,
	--t10_NoHPKodeProvider,
	--t10_NoHP

	--Tambahan persetujuan
	c7_Persetujuan,
	c_Verifikasi,
	c_Stamp,

	--Tambahan Indomaret & Matahari
	c1_Indomaret,
	c1_Matahari,

	--Tambahan Alamat Pengiriman Kartu
	c2_AlamatPengirimanKartu,

	--Tambahan Barcode
	t_IsBarCode,
	t_BarcodeValue,

	-- CBAS Content Text
	

	--pengiriman ke CCMS t2_NamaTanpaSingkatan menggantikan t2_nama
	t2_NamaTanpaSingkatan,
	t11_JenisKartu,
	c1_BWS,
	c_Urgent,
	c1_BCAUnion,
	c1_BLIBLICOM,
	c1_TIKET,
	c1_AMEX

	FROM  
	DataCompletion
	where FlowName = 'KartuKredit' --and isAKKIBlackList is not NULL
	and t2_nama <> '' --and AKKIUpdateStatus = 1
	--and (t11_jeniskartu is null or t11_jeniskartu = '')  
	--and (t11_IsCabangBlackList <> 'YES' or t11_IsCabangBlackList is null or t11_IsCabangBlackList = '') AND CBASUpdateStatus=1 
	AND (status != 1) AND (winform_get != 1)
) as detil
--order by scannumber, scandate, batchbundle asc
order by batchbundle,CollectionName asc

set nocount off
END

BEGIN
update DataCompletion
set winform_get = 1
where FlowName = 'KartuKredit' --and isAKKIBlackList is not NULL
	and t2_nama <> '' --and AKKIUpdateStatus = 1
	--and (t11_jeniskartu is null or t11_jeniskartu = '')  
	--and (t11_IsCabangBlackList <> 'YES' or t11_IsCabangBlackList is null or t11_IsCabangBlackList = '') AND CBASUpdateStatus=1 
	AND (status != 1)
END