-- rekap service
create view rekap_service as select s.nama_service, count(s.idservice) as jumlah_service
from service s
group by s.nama_service
order by jumlah_service desc;

-- kamar best seller
create view kamar_best_seller as 
select dr.kamar_nomor_kamar as nomor_kamar, count(dr.kamar_nomor_kamar) as jumlah_kamar_dipesan
from detail_reservasi dr
group by dr.kamar_nomor_kamar
order by jumlah_kamar_dipesan desc;

-- STRUK PEMBAYARAN --
CREATE VIEW view_tamu AS
SELECT 
    CONCAT(t.nama_depan, ' ', t.nama_belakang) AS nama_lengkap,
    dt.kamar_nomor_kamar AS nomor_kamar,
    k.tipe_kamar,
    r.date_checkin,
    r.date_checkout,
    CONCAT(DATEDIFF(r.date_checkout, r.date_checkin), ' hari') AS lama_menginap,
    k.price,
    p.total_harga,
    p.metode_payment_idmetode_payment AS metode_payment
FROM tamu t
JOIN reservation r ON r.tamu_idtamu = t.idtamu
JOIN detail_reservasi dt ON dt.Reservation_idReservation = r.idReservation
JOIN kamar k ON k.nomor_kamar = dt.kamar_nomor_kamar
JOIN payment p ON p.idpayment = r.payment_idpayment;

-- PEGAWAI GAJI TERTINGGI --
create view gaji_tertinggi as
select 
    concat(p.nama_depan, ' ', p.nama_belakang) as nama_lengkap,
    p.idpegawai,
    p.posisi,
    max(sh.gaji_bulanan) as gaji_tertinggi
from perhotelan.pegawai p
join salary_history sh on sh.pegawai_idpegawai = p.idpegawai
order by sh.gaji_bulanan desc;

-- pegawai yang bekerja paling lama --
create view pegawai_paling_lama as
select 
    pegawai_idpegawai as "id pegawai",
    concat(p.nama_depan, " ", p.nama_belakang) as "nama pegawai",
    p.posisi as "posisi",
    max(month(end_date)) - min(month(start_date)) as "lama bekerja (bulan)"
from salary_history sh
join pegawai p on sh.pegawai_idpegawai = p.idpegawai
group by pegawai_idpegawai
having max(month(end_date)) - min(month(start_date)) = (
    select max(month(end_date)) - min(month(start_date))
    from salary_history
);

-- pegawai baru --
create view pegawai_baru as
select pegawai_idpegawai as "id pegawai",
concat(p.nama_depan, " ", p.nama_belakang) as "nama pegawai",
p.posisi as "posisi",
max(month(end_date)) - min(month(start_date)) as lama
from salary_history sh
join pegawai p on sh.pegawai_idpegawai = p.idpegawai
group by pegawai_idpegawai
having max(month(end_date)) - min(month(start_date)) = (
  select min(lama) from (
    select max(month(end_date)) - min(month(start_date)) as lama
    from salary_history
    group by pegawai_idpegawai
  ) as terkecil
);

-- URUTAN GAJI PEGAWAI BERDASARKAN ID PEGAWAI
CREATE VIEW urutan_gaji_pegawai AS
SELECT sh.pegawai_idpegawai, CONCAT(p.nama_depan, ' ', p.nama_belakang) AS nama_lengkap,
       sh.start_date, sh.end_date, sh.gaji_bulanan
FROM salary_history sh
JOIN pegawai p ON sh.pegawai_idpegawai = p.idpegawai
ORDER BY pegawai_idpegawai;

-- keseluruhan data dari tamu hotel --
create view data_tamu as
select
    r.idReservation as "nomor reservasi",
    concat(t.nama_depan, " ", t.nama_belakang) as "nama panjang",
    t.alamat as "Alamat",
    t.nomer_telepon as "nomor telepon",
    t.nomer_ktp as "nomor KTP",
    concat(p.nama_depan, " ", p.nama_belakang) as "nama pegawai",
    k.nomer_kamar as "nomor kamar",
    k.tipe_kamar as "tipe kamar",
    r.reservation_date as "tanggal reservasi",
    r.date_checkin as "tanggal check-in",
    r.date_checkout as "tanggal check-out",
    py.total_harga as "total pembayaran",
    py.tanggal_payment as "tanggal pembayaran",
    mp.jenis_metode as "metode pembayaran"
from tamu t
join reservation r on t.idtamu = r.tamu_idtamu
join pegawai p on r.pegawai_idpegawai = p.idpegawai
join detail_reservasi dr on r.idReservation = dr.Reservation_idReservation
join kamar k on dr.kamar_nomer_kamar = k.nomor_kamar
join payment py on r.payment_idpayment = py.idpayment
join metode_payment mp on py.metode_payment_idmetode_payment = mp.idmetode_payment;


-- LANTAI YANG PALING BANYAK DIPESAN
CREATE VIEW most_booked_floor_view AS SELECT k.lantai AS 'Lantai',
 COUNT(*) AS 'Jumlah Pemesanan' FROM kamar k JOIN detail_reservasi dr ON
 k.nomor_kamar = dr.kamar_nomor_kamar JOIN reservation r ON
 dr.Reservation_idReservation = r.idReservation GROUP BY k.lantai ORDER BY
 COUNT(*) DESC LIMIT 1;

