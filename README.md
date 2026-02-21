
# Parcial 1 — Organización de Computadores  
## Microarquitectura de una ALU de 32 bits  
**Equipo:** William Villa Carmona, Daniela Álvarez Acevedo  
**Bus:** 32 bits  
**Entradas:** X, Y, Z  

---

# 1️. Descripción General

Se diseñó una ALU de 32 bits implementada de manera jerárquica,
utilizando bloques de 16 bits (Add16) para construir un sumador de 32 bits.

La arquitectura sigue las 4 etapas solicitadas:

1. Pre-condicionamiento  
2. Procesamiento  
3. Selección  
4. Generación de Flags  

---

# 2. Funciones Implementadas

##  Operación 1
X + Y + Z  

Implementación:
(X + Y) + Z

##  Operación 2
Z - X + Y  

Usando complemento a 2:
Z - X = Z + (~X + 1)

Entonces:
(Z + (~X + 1)) + Y

---

# 3️. Arquitectura Jerárquica

Componentes utilizados:

- Add16  
- Adder32 (2 Add16)  
- Not32 (2 Not16)  
- Mux4Way32  
- Lógica de Flags  

---

# 4️. Diagrama de Arquitectura

##  ETAPA 1 — PRE-CONDICIONAMIENTO

Entradas directas:
X, Y, Z

Para Z - X + Y:
X → Not32 → +1 → (-X)

---

##  ETAPA 2 — PROCESAMIENTO

### X + Y
Adder32(X, Y) → XY

### X + Y + Z
Adder32(XY, Z) → XYZ

### Z - X
Not32(X) → +1 → (-X)  
Adder32(Z, -X) → ZX

### Z - X + Y
Adder32(ZX, Y) → ZXY

Cada Adder32 está compuesto por: 

Add16 (bits 0–15)  
Add16 (bits 16–31)  

---

##  ETAPA 3 — SELECCIÓN

Mux4Way32 controla la salida final:

sel = 01 → XYZ  
sel = 10 → ZXY  

---

##  ETAPA 4 — FLAGS

### Zero Flag (zr)
OUT → Or32Way → NOT → zr  

### Negative Flag (ng)
ng = OUT[31]  

### Overflow (ov)

Definición formal:

ov = carry_into_bit31 XOR carry_out_bit31

Implementación:

ov = carryIntoMSB XOR carryOut

---

# 5️. Tabla de Control

| sel[1] | sel[0] | Operación     | Descripción |
|--------|--------|--------------|-------------|
| 0      | 0      | Reservado    | — |
| 0      | 1      | X + Y + Z    | (X + Y) + Z |
| 1      | 0      | Z - X + Y    | (Z + (~X + 1)) + Y |
| 1      | 1      | Reservado    | — |

La selección final se realiza mediante un Mux4Way32.

---
# 6. Validación Funcional

Se validó el funcionamiento mediante el Hardware Simulator ejecutando archivos .tst con los siguientes casos:

- Valores positivos

- Valores negativos

- Resultado cero

- Casos con overflow

- Valores límite

El chip compila y ejecuta correctamente sin errores.

---

# 7. Justificación Técnica

- Diseño jerárquico  
- Uso de bloques de 16 bits  
- Separación clara en 4 etapas  
- Overflow matemáticamente correcto  
- Modular y escalable  

---

# 8. Conclusión

La ALU32 implementa correctamente las funciones solicitadas
para equipo de 2 personas, cumpliendo con los requerimientos
del parcial tanto a nivel funcional como arquitectónico.
