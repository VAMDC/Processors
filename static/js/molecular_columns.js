function Column(type, size, ucd, unit) {
    this.datatype = type;
    this.arraysize = size;
    this.ucd = ucd;     
    this.unit = unit;                   
}

var columns_fields = { 
    c1 : new Column('', '', '', ''),                // 
    c2 : new Column('char', '*', '', ''),           // species
    c3 : new Column('double', '', '', ''),          // ion charge
    c4 : new Column('char', '*', '', ''),           // stoichiometric formula
    c5 : new Column('char', '*', '', ''),           // ordinary structural formula
    c6 : new Column('double', '', '', ''),          // wavelength
    c7 : new Column('char', '*', '', ''),           // wavelength reference
    c8 : new Column('char', '*', '', ''),           // transition reference
    c9 : new Column('double', '', '', ''),          // wavenumber
    c10 : new Column('char', '*', '', ''),          // wavenumber reference
    c11 : new Column('double', '', '', ''),         // energy
    c12 : new Column('char', '*', '', ''),          // energy reference
    c13 : new Column('double', '', '', ''),         // frequency 
    c14 : new Column('char', '*', '', ''),          // frequency reference
    c15 : new Column('double', '', '', ''),         // A
    c16 : new Column('double', '', '', ''),         // oscillator strength
    c17 : new Column('double', '', '', ''),         // weighted oscillator strength
    c18 : new Column('double', '', '', ''),         // lower energy
    c19 : new Column('double', '', '', ''),         // lower total statistical weight
    c20 : new Column('double', '', '', ''),         // lower nuclear statistical weight
    c21 : new Column('char', '*', '', ''),          // lower parity
    c22 : new Column('char', '*', '', ''),          // lower qns
    c23 : new Column('double', '', '', ''),         // upper energy
    c24 : new Column('double', '', '', ''),         // upper total statistical weight
    c25 : new Column('double', '', '', ''),         // upper nuclear statistical weight
    c26 : new Column('char', '*', '', ''),          // upper parity
    c27 : new Column('char', '*', '', ''),          // upper QNs
    
};
