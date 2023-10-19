import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/models/commande.dart';
import 'package:flutter_web/widgets/custom_text.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

List<Commande> commandeList = [
  Commande(
    numpiece: "12345",
    date: "2023-10-17",
    client: "John Doe",
    etat: "Pending",
    saisie: true,
    commercial: true,
    control1: false,
    control2: true,
    ver: false,
  ),
  Commande(
    numpiece: "67890",
    date: "2023-10-18",
    client: "Jane Smith",
    etat: "Approved",
    saisie: false,
    commercial: true,
    control1: true,
    control2: true,
    ver: true,
  ),
  Commande(
    numpiece: "13579",
    date: "2023-10-19",
    client: "Bob Johnson",
    etat: "Delivered",
    saisie: true,
    commercial: false,
    control1: true,
    control2: false,
    ver: true,
  ),
  Commande(
    numpiece: "24680",
    date: "2023-10-20",
    client: "Sally Davis",
    etat: "Pending",
    saisie: true,
    commercial: true,
    control1: false,
    control2: false,
    ver: false,
  ),
  Commande(
    numpiece: "10101",
    date: "2023-10-21",
    client: "Mike Brown",
    etat: "Approved",
    saisie: true,
    commercial: true,
    control1: true,
    control2: true,
    ver: true,
  ),
];



