📄 README — ALU32 (Equipo 2 Personas)
📌 Parcial 1 — Organización de Computadores

Microarquitectura de una ALU de 32 bits
Equipo: 2 personas
Bus: 32 bits
Entradas: X, Y, Z

1️⃣ Descripción General

Se diseñó una ALU de 32 bits implementada de manera jerárquica, utilizando bloques de 16 bits (Add16) para construir un sumador de 32 bits.

La arquitectura sigue estrictamente las 4 etapas solicitadas:

Pre-condicionamiento

Procesamiento

Selección

Generación de Flags

2️⃣ Funciones Implementadas
🔹 Operación 1
𝑋
+
𝑌
+
𝑍
X+Y+Z

Se implementa en dos etapas de suma:

(
𝑋
+
𝑌
)
+
𝑍
(X+Y)+Z
🔹 Operación 2
𝑍
−
𝑋
+
𝑌
Z−X+Y

Recordando complemento a 2:

𝑍
−
𝑋
=
𝑍
+
(
∼
𝑋
+
1
)
Z−X=Z+(∼X+1)

Entonces:

(
𝑍
+
(
∼
𝑋
+
1
)
)
+
𝑌
(Z+(∼X+1))+Y
3️⃣ Arquitectura Jerárquica

La ALU32 está compuesta por:

Add16

Adder32 (2 Add16)

Not32 (2 Not16)

Mux4Way32

Lógica de flags

4️⃣ Diagrama de Arquitectura
🔵 ETAPA 1 — PRE-CONDICIONAMIENTO

En esta etapa se reciben las entradas X, Y, Z.

        X --------\
                    \
        Y -----------  (Entradas)
                    /
        Z --------/

Para la operación Z - X + Y se aplica:

X → Not32 → +1 → (-X)
🟢 ETAPA 2 — PROCESAMIENTO
🔹 Cálculo X + Y
        X ──────┐
                │
                ▼
           ┌──────────┐
           │ Adder32  │
           └──────────┘
                │
                ▼
               XY
🔹 Cálculo X + Y + Z
        XY ─────┐
                │
                ▼
           ┌──────────┐
           │ Adder32  │
           └──────────┘
                │
                ▼
               XYZ
🔹 Cálculo Z - X + Y
X → Not32 → +1 → (-X)

Z ─────┐
       │
       ▼
  ┌──────────┐
  │ Adder32  │  → ZX
  └──────────┘

ZX ─────┐
        │
        ▼
   ┌──────────┐
   │ Adder32  │  → ZXY
   └──────────┘

Cada Adder32 está compuesto por:

Add16 (bits 0–15)
Add16 (bits 16–31)

Con propagación de carry entre bloques.

🟡 ETAPA 3 — SELECCIÓN

Se utiliza un Mux4Way32 controlado por sel[1..0].

          XYZ ─────┐
                   │
          ZXY ─────┼──► Mux4Way32 ───► OUT
                   │
       sel[1..0] ──┘
🔴 ETAPA 4 — FLAGS
🔹 Zero Flag (zr)
OUT → Or32Way → NOT → zr

Si todos los bits son 0 → zr = 1

🔹 Negative Flag (ng)
ng = OUT[31]

Bit más significativo del resultado.

🔹 Overflow (ov)

Definición formal utilizada:

𝑜
𝑣
=
𝑐
𝑎
𝑟
𝑟
𝑦
_
𝑖
𝑛
𝑡
𝑜
_
𝑏
𝑖
𝑡
31
⊕
𝑐
𝑎
𝑟
𝑟
𝑦
_
𝑜
𝑢
𝑡
_
𝑏
𝑖
𝑡
31
ov=carry_into_bit31⊕carry_out_bit31

Implementación:

ov = carryIntoMSB XOR carryOut

Donde:

carryIntoMSB: acarreo que entra al bit más significativo

carryOut: acarreo que sale del bit más significativo

5️⃣ Tabla de Control
sel[1]	sel[0]	Operación	Descripción
0	0	Reservado	—
0	1	X + Y + Z	(X + Y) + Z
1	0	Z - X + Y	(Z + (~X + 1)) + Y
1	1	Reservado	—
6️⃣ Justificación Arquitectónica

✔ Diseño completamente jerárquico
✔ Uso de bloques de 16 bits para construir 32 bits
✔ Separación clara en 4 etapas
✔ Cálculo formal del overflow
✔ Implementación modular y escalable

7️⃣ Conclusión

Se implementó una ALU de 32 bits para equipo de 2 personas cumpliendo:

Bus de 32 bits

Entradas X, Y, Z

Operaciones especiales requeridas

Arquitectura jerárquica

Flags correctamente calculadas

Overflow definido formalmente

El diseño compila correctamente en el Hardware Simulator y pasa los casos de prueba definidos.
