double calculaPreuSamarretes(int numero, String talla) {
  double precioUnitario = 0; // Preu base segons la talla
  switch (talla) {
    case 'S': precioUnitario = 10.0; break; // Preu per a talla S
    case 'M': precioUnitario = 12.0; break; // Preu per a talla M
    case 'L': precioUnitario = 15.0; break; // Preu per a talla L
    case 'XL': precioUnitario = 18.0; break; // Preu per a talla XL
  } 
  return numero * precioUnitario; // Preu total abans del descompte
}

double calculaDescompte(double preu, int tipusDescompte) {
  if (tipusDescompte == 1) { // Descompte del 10%
    return preu * 0.10; //  Descompte del 10% si el preu és superior a 50
  } else if (tipusDescompte == 2) { 
    return (preu > 100) ? 20.0 : 0.0; // Descompte de 20€ si el preu és superior a 100
  }
  return 0.0;
}

double preuDefinitiu(int numero, String talla, int descompte) {
  double base = calculaPreuSamarretes(numero, talla); // Preu total abans del descompte
  double ahorro = calculaDescompte(base, descompte); // Quantitat de descompte a aplicar
  return base - ahorro;
}