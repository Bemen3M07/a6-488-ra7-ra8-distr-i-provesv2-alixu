double calculaPreuSamarretes(int numero, String talla) {
  double precioUnitario = 0;
  switch (talla) {
    case 'S': precioUnitario = 10.0; break;
    case 'M': precioUnitario = 12.0; break;
    case 'L': precioUnitario = 15.0; break;
    case 'XL': precioUnitario = 18.0; break;
  }
  return numero * precioUnitario;
}

double calculaDescompte(double preu, int tipusDescompte) {
  if (tipusDescompte == 1) {
    return preu * 0.10;
  } else if (tipusDescompte == 2) {
    return (preu > 100) ? 20.0 : 0.0;
  }
  return 0.0;
}

double preuDefinitiu(int numero, String talla, int descompte) {
  double base = calculaPreuSamarretes(numero, talla);
  double ahorro = calculaDescompte(base, descompte);
  return base - ahorro;
}