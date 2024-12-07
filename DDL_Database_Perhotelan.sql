 create schema db_hotel;
 use db_hotel;
 
 CREATE TABLE pegawai (
 idpegawai INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
 nama_depan VARCHAR(20) NULL,
 nama_belakang VARCHAR(20) NULL,
 posisi VARCHAR(20) NULL,
 alamat VARCHAR(100) NULL,
 nomer_telepon VARCHAR(15) NULL,
 PRIMARY KEY(idpegawai)
 );
 
 CREATE TABLE tamu (
idtamu INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
 nama_depan VARCHAR(20) NULL,
 nama_belakang VARCHAR(20) NULL,
 alamat VARCHAR(100) NULL,
 nomer_telepon VARCHAR(15) NULL,
 nomer_ktp VARCHAR(20) NULL,
 PRIMARY KEY(idtamu)
 );
 
 CREATE TABLE metode_payment (
 idmetode_payment INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
 jenis_metode VARCHAR(20) NULL,
 PRIMARY KEY(idmetode_payment)
 );
 CREATE TABLE kamar (
 nomor_kamar INTEGER UNSIGNED NOT NULL,
 tipe_kamar VARCHAR(20) NULL,
 lantai INTEGER UNSIGNED NULL,
 price INTEGER UNSIGNED NULL,
 PRIMARY KEY(nomor_kamar)
 );
 CREATE TABLE salary_history (
 start_date DATE,
 pegawai_idpegawai INTEGER UNSIGNED NOT NULL,
 end_date DATE NULL,
 gaji_bulanan INTEGER UNSIGNED NULL,
 PRIMARY KEY(start_date),
 INDEX salary_history_FKIndex1(pegawai_idpegawai),
 FOREIGN KEY(pegawai_idpegawai)
 REFERENCES pegawai(idpegawai)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION
 );
 CREATE TABLE service (
 idservice INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
 kamar_nomor_kamar INTEGER UNSIGNED NOT NULL,
 nama_service VARCHAR(45) NULL,
 PRIMARY KEY(idservice),
 INDEX service_FKIndex1(kamar_nomor_kamar),
 FOREIGN KEY(kamar_nomor_kamar)
 REFERENCES kamar(nomor_kamar)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION
);
 CREATE TABLE payment (
 idpayment INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
 metode_payment_idmetode_payment INTEGER UNSIGNED NOT NULL,
 tanggal_payment DATE NULL,
 total_harga INTEGER UNSIGNED NULL,
 PRIMARY KEY(idpayment),
 INDEX payment_FKIndex1(metode_payment_idmetode_payment),
 FOREIGN KEY(metode_payment_idmetode_payment)
 REFERENCES metode_payment(idmetode_payment)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION
 );
 
 CREATE TABLE Reservation (
 idReservation INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
 payment_idpayment INTEGER UNSIGNED NULL,
 pegawai_idpegawai INTEGER UNSIGNED NOT NULL,
 tamu_idtamu INTEGER UNSIGNED NOT NULL,
 reservation_date DATE NULL,
 date_checkin DATE NULL,
 date_checkout DATE NULL,
 PRIMARY KEY(idReservation),
 INDEX Reservation_FKIndex1(tamu_idtamu),
 INDEX Reservation_FKIndex3(pegawai_idpegawai),
 INDEX Reservation_FKIndex4(payment_idpayment),
 FOREIGN KEY(tamu_idtamu)
 REFERENCES tamu(idtamu)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION,
 FOREIGN KEY(pegawai_idpegawai)
 REFERENCES pegawai(idpegawai)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION,
 FOREIGN KEY(payment_idpayment)
 REFERENCES payment(idpayment)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION
 );
 
 CREATE TABLE detail_reservasi (
 Reservation_idReservation INTEGER UNSIGNED NOT NULL,
 kamar_nomor_kamar INTEGER UNSIGNED NOT NULL,
 PRIMARY KEY(Reservation_idReservation, kamar_nomor_kamar),
 INDEX Reservation_has_kamar_FKIndex1(Reservation_idReservation),
INDEX Reservation_has_kamar_FKIndex2(kamar_nomor_kamar),
 FOREIGN KEY(Reservation_idReservation)
 REFERENCES Reservation(idReservation)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION,
 FOREIGN KEY(kamar_nomor_kamar)
 REFERENCES kamar(nomor_kamar)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION
 );