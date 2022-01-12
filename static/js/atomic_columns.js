function Column(type, size, ucd, unit) {
    this.datatype = type;
    this.arraysize = size;
    this.ucd = ucd;     
    this.unit = unit;                   
}

var columns_fields = { 
    c1 : new Column('', '', '', ''),  
    c2 : new Column('char', '*', '', ''),           // species + ion
    c3 : new Column('char', '*', '', ''),           // radTrans references    
    c4 : new Column('double', '', '', 'A'),         // wl
    c5 : new Column('char', '*', '', ''),           // wl refeences
    c6 : new Column('double', '', '', ''),          // wavenumber
    c7 : new Column('char', '*', '', ''),           // wavenumber references
    c8 : new Column('double', '', '', ''),          // energy
    c9 : new Column('char', '*', '', ''),           // energy references
    c10 : new Column('double', '', '', ''),         // frequency
    c11 : new Column('char', '*', '', ''),          // frequency references
    c12 : new Column('double', '', '', ''),         // A
    c13 : new Column('double', '', '', ''),         // oscillator strength
    c14 : new Column('double', '*', '', ''),        // weighted oscillator strength
    c15 : new Column('double', '*', '', ''),        // log 10 weighted oscillator strength   
    c16 : new Column('char', '*', '', ''),          // lower state description
    c17 : new Column('char', '*', '', ''),          // lower state reference
    c18 : new Column('double', '', '', ''),         // lower energy
    c19 : new Column('double', '', '', ''),         // lower ionization
    c20 : new Column('double', '', '', ''),         // lower lifetime
    c21 : new Column('double', '', '', ''),         // lower statistical weight
    c22 : new Column('char', '*', '', ''),          // lower parity
    c23 : new Column('double', '', '', ''),         // lower total angular momentum
    c24 : new Column('double', '', '', ''),         // lower kappa
    c25 : new Column('double', '', '', ''),         // lower hyperfine momentum
    c26 : new Column('double', '', '', ''),         // lower magnetic qn
    c27 : new Column('double', '', '', ''),         // lower mixing coefficient
    c28 : new Column('char', '*', '', ''),          // lower configuration
    c29 : new Column('char', '*', '', ''),          // lower term
    c30 : new Column('char', '*', '', ''),          // lower coupling
    c31 : new Column('char', '*', '', ''),          // upper state description
    c32 : new Column('char', '*', '', ''),          // upper state reference
    c33 : new Column('double', '', '', ''),         // upper state energy
    c34 : new Column('double', '', '', ''),         // upper ionization
    c35 : new Column('double', '', '', ''),         // upper lifetime
    c36 : new Column('double', '', '', ''),         // upper statistical weight
    c37 : new Column('char', '*', '', ''),          // upper parity
    c38 : new Column('double', '', '', ''),         // upper total angular momentum
    c39 : new Column('double', '', '', ''),         // upper kappa
    c40 : new Column('double', '', '', ''),         // upper hyperfine momentum
    c41 : new Column('double', '', '', ''),         // upper magnetic qn
    c42 : new Column('double', '', '', ''),         // upper mixing coefficient
    c43 : new Column('char', '*', '', ''),          // upper configuration
    c44 : new Column('char', '*', '', ''),          // upper term label
    c45 : new Column('char', '*', '', '')           // upper coupling    
};
