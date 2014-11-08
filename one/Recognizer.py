__author__ = 'William Kinderman'
__class__ = 'CSc 135'
__section__ = '1'
__assignment__ = 'Assignment 1, Recognizer/Parser'
__valid_strings__ = ['PBE$', 'P_0123456789:V;BE$', 'P_0,X1,Y2,Z3456789:V;BE$', 'PBX~1;E$', 'PBI(3>2)@&E$', 'P_X:V;BE$',
                     'PBRX;E$', 'PBOX;E$', 'PZ:V;BOX;E$', 'PBW(9>3)LTE$', 'PBI(3>2)@%&E$', 'PX:V;BRZ;E$', 'PX,Y:V;BRZ;E$']

"""

__valid_strings__ contains a list of each valid string that I tested.

to run:
    python Recognizer.py

EBNF:
    program ::= P {declare} B {statemt} E
    declare ::= ident {, ident} : V ;
    statemt ::= assnmt | ifstmt | loop | read | output
    assnmt  ::= ident ~ exprsn ;
    ifstmt  ::= I comprsn @ {statemt} [% {statemt}] &
    loop    ::= W comprsn L {statemt} T
    read    ::= R ident {, ident } ;
    output  ::= O ident {, ident } ;
    comprsn ::= ( oprnd opratr oprnd )
    exprsn  ::= factor {+ factor}
    factor  ::= oprnd {* oprnd}
    oprnd   ::= integer | ident | ( exprsn )
    opratr  ::= < | = | > | !
    ident   ::= letter {char}
    char    ::= letter | digit
    integer ::= digit {digit}
    letter  ::= _ | X | Y | Z
    digit   ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

The tokens are: P B E ; , : V ~ I @ % & W L T R O ( ) + * < = > ! _ X Y Z 0 1 2 3 4 5 6 7 8 9

"""

class Recognizer(object):
    def __init__(self, s, m=False):
        self.s = s
        self.MATCH = m
        self.position = 0
        self.length = len(s)
        self.error_condition = None
        self.t = s[self.position]
        self.OPRATR = ['<', '=', '>', '!']
        self.LETTER = ['_', 'X', 'Y', 'Z']
        self.DIGIT = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

    def advance(self):
        if self.position < (self.length - 1):
            self.position += 1
            if self.length != self.position:
                self.t = self.s[self.position]
        elif self.position > self.length:
            print('Illegal string.')
            exit(-1)

    def error(self):
        print('Error at position: %d' % self.position)
        self.error_condition = 1
        self.advance()

    def match(self, s):
        if self.t == s:
            if self.MATCH:
                print('Matched %s' % self.t)
            self.advance()
        else:
            self.error()

    def program(self):
        self.match('P')

        while self.t != 'B':
            self.declare()

        self.match('B')

        while self.t != 'E':
            self.statemt()

        self.match('E')
        self.match('$')

        if self.error_condition:
            print('Illegal string.')
        else:
            print('Legal string.')

    def integer(self):
        while self.t in self.DIGIT:
            self.digit()

    def char(self):
        if self.t in self.LETTER:
            self.letter()
        elif self.t in self.DIGIT:
            self.digit()

    def oprnd(self):
        if self.t in self.DIGIT:
            self.integer()
        elif self.t in self.LETTER:
            self.ident()
        elif self.t == '(':
            self.match('(')
            self.exprsn()
            self.match(')')

    def factor(self):
        while True:
            self.oprnd()
            if self.t == '*':
                self.match('*')
            else:
                break

    def exprsn(self):
        while True:
            self.factor()
            if self.t == '+':
                self.match('*')
            else:
                break

    def comprsn(self):
        self.match('(')
        self.oprnd()
        self.opratr()
        self.oprnd()
        self.match(')')

    def output(self):
        self.match('O')
        while True:
            self.ident()
            if (self.t == ','):
                self.match(',')
                break
            if (self.t == ';'):
                self.match(';')
                break

    def read(self):
        self.match('R')
        while True:
            self.ident()
            if self.t == ',':
                self.match(',')
            else:
                break
        self.match(';')

    def loop(self):
        self.match('W')
        self.comprsn()
        self.match('L')
        while self.t != 'T':
            self.statemt()
        self.match('T')

    def ifstmt(self):
        self.match('I')
        self.comprsn()
        self.match('@')
        while self.t not in ['%', '&']:
            self.statemt()
        if self.t == '%':
            self.match('%')
            while self.t != '&':
                self.statemt()
        self.match('&')

    def assnmt(self):
        self.ident()
        self.match('~')
        self.exprsn()
        self.match(';')

    def statemt(self):
        if self.t in self.LETTER:
            self.assnmt()
        elif self.t == 'I':
            self.ifstmt()
        elif self.t == 'W':
            self.loop()
        elif self.t == 'R':
            self.read()
        elif self.t == 'O':
            self.output()
        else:
            self.error()

    def declare(self):
        self.ident()
        while self.t == ',':
            if self.t == ',':
                self.match(',')
            self.ident()
        self.match(':')
        self.match('V')
        self.match(';')

    def ident(self):
        self.letter()
        while (self.t in self.DIGIT) or (self.t in self.LETTER):
            self.char()

    def digit(self):
        if self.t in self.DIGIT:
            self.match(self.t)
        else:
            self.error()

    def letter(self):
        if self.t in self.LETTER:
            self.match(self.t)
        else:
            self.error()

    def opratr(self):
        if self.t in self.OPRATR:
            self.match(self.t)
        else:
            self.error()

if __name__ == '__main__':
    s = raw_input("Enter a string to verify: ")
    if s == '':
        print('Illegal string.')
        exit(-1)
    r = Recognizer(s)
    r.program()
