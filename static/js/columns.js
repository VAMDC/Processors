function Column(type, size, ucd, unit) {
    this.datatype = type;
    this.arraysize = size;
    this.ucd = ucd;     
    this.unit = unit;                   
}

var columns_fields = { 
    c1 : new Column('', '', '', ''),  
    c2 : new Column('char', '*', '', ''),  
    c3 : new Column('double', '', '', 'A'),  
    c4 : new Column('double', '', '', ''),  
    c5 : new Column('double', '', '', ''),  
    c6 : new Column('double', '', '', ''),  
    c7 : new Column('double', '', '', ''),  
    c8 : new Column('double', '', '', ''),  
    c9 : new Column('double', '', '', ''),  
    c10 : new Column('char', '*', '', ''),  
    c11 : new Column('double', '', '', 'Ry'),  
    c12 : new Column('double', '', '', 'Ry'),  
    c13 : new Column('double', '', '', ''),  
    c14 : new Column('double', '', '', ''),  
    c15 : new Column('char', '*', '', ''),  //lower parity
    c16 : new Column('double', '', '', ''),  
    c17 : new Column('double', '', '', ''),  
    c18 : new Column('double', '', '', ''),  
    c19 : new Column('double', '', '', ''),  
    c20 : new Column('double', '', '', ''),  
    c21 : new Column('char', '*', '', ''),  
    c22 : new Column('char', '*', '', ''),  
    c23 : new Column('char', '*', '', ''),  
    c24 : new Column('double', '', '', 'Ry'),  
    c25 : new Column('double', '', '', 'Ry'),  
    c26 : new Column('double', '', '', ''),  
    c27 : new Column('double', '', '', ''),  
    c28 : new Column('char', '*', '', ''),  
    c29 : new Column('double', '', '', ''),  
    c30 : new Column('double', '', '', ''),  
    c31 : new Column('double', '', '', ''),  
    c32 : new Column('double', '', '', ''),  
    c33 : new Column('double', '', '', ''),  
    c34 : new Column('char', '*', '', ''),  
    c35 : new Column('char', '*', '', ''),  
};
