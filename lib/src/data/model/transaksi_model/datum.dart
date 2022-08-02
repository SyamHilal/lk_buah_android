import 'package:collection/collection.dart';

import 'detail_transaksi.dart';
import 'status_order.dart';

class DataTransaksi {
  int? id;
  String? invoice;
  int? userId;
  int? subtotal;
  dynamic noResi;
  int? statusOrderId;
  String? metodePembayaran;
  int? ongkir;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? noHp;
  dynamic buktiPembayaran;
  String? pesan;
  String? urlMidtrans;
  dynamic cityId;
  dynamic cityName;
  dynamic type;
  dynamic provinceId;
  dynamic provinceName;
  dynamic detailAlamat;
  List<DetailTransaksi>? detailTransaksi;
  StatusOrder? statusOrder;

  DataTransaksi({
    this.id,
    this.invoice,
    this.userId,
    this.subtotal,
    this.noResi,
    this.statusOrderId,
    this.metodePembayaran,
    this.ongkir,
    this.createdAt,
    this.updatedAt,
    this.noHp,
    this.buktiPembayaran,
    this.pesan,
    this.urlMidtrans,
    this.cityId,
    this.cityName,
    this.type,
    this.provinceId,
    this.provinceName,
    this.detailAlamat,
    this.detailTransaksi,
    this.statusOrder,
  });

  @override
  String toString() {
    return 'DataTransaksi(id: $id, invoice: $invoice, userId: $userId, subtotal: $subtotal, noResi: $noResi, statusOrderId: $statusOrderId, metodePembayaran: $metodePembayaran, ongkir: $ongkir, createdAt: $createdAt, updatedAt: $updatedAt, noHp: $noHp, buktiPembayaran: $buktiPembayaran, pesan: $pesan, urlMidtrans: $urlMidtrans, cityId: $cityId, cityName: $cityName, type: $type, provinceId: $provinceId, provinceName: $provinceName, detailAlamat: $detailAlamat, detailTransaksi: $detailTransaksi, statusOrder: $statusOrder)';
  }

  factory DataTransaksi.fromJson(Map<String, dynamic> json) => DataTransaksi(
        id: json['id'] as int?,
        invoice: json['invoice'] as String?,
        userId: json['user_id'] as int?,
        subtotal: json['subtotal'] as int?,
        noResi: json['no_resi'] as dynamic,
        statusOrderId: json['status_order_id'] as int?,
        metodePembayaran: json['metode_pembayaran'] as String?,
        ongkir: json['ongkir'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        noHp: json['no_hp'] as String?,
        buktiPembayaran: json['bukti_pembayaran'] as dynamic,
        pesan: json['pesan'] as String?,
        urlMidtrans: json['url_midtrans'] as String?,
        cityId: json['city_id'] as dynamic,
        cityName: json['city_name'] as dynamic,
        type: json['type'] as dynamic,
        provinceId: json['province_id'] as dynamic,
        provinceName: json['province_name'] as dynamic,
        detailAlamat: json['detail_alamat'] as dynamic,
        detailTransaksi: (json['detail_transaksi'] as List<dynamic>?)
            ?.map((e) => DetailTransaksi.fromJson(e as Map<String, dynamic>))
            .toList(),
        statusOrder: json['status_order'] == null
            ? null
            : StatusOrder.fromJson(
                json['status_order'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'invoice': invoice,
        'user_id': userId,
        'subtotal': subtotal,
        'no_resi': noResi,
        'status_order_id': statusOrderId,
        'metode_pembayaran': metodePembayaran,
        'ongkir': ongkir,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'no_hp': noHp,
        'bukti_pembayaran': buktiPembayaran,
        'pesan': pesan,
        'url_midtrans': urlMidtrans,
        'city_id': cityId,
        'city_name': cityName,
        'type': type,
        'province_id': provinceId,
        'province_name': provinceName,
        'detail_alamat': detailAlamat,
        'detail_transaksi': detailTransaksi?.map((e) => e.toJson()).toList(),
        'status_order': statusOrder?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DataTransaksi) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      invoice.hashCode ^
      userId.hashCode ^
      subtotal.hashCode ^
      noResi.hashCode ^
      statusOrderId.hashCode ^
      metodePembayaran.hashCode ^
      ongkir.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      noHp.hashCode ^
      buktiPembayaran.hashCode ^
      pesan.hashCode ^
      urlMidtrans.hashCode ^
      cityId.hashCode ^
      cityName.hashCode ^
      type.hashCode ^
      provinceId.hashCode ^
      provinceName.hashCode ^
      detailAlamat.hashCode ^
      detailTransaksi.hashCode ^
      statusOrder.hashCode;
}
