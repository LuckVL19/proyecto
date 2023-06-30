program Sudoku;

const
  T = 9;

type
  SudokuTabla = array[1..T, 1..T] of Integer;

procedure Iniciartabla(var Tabla: SudokuTabla);
var
  i, j: Integer;
begin
  for i := 1 to T do
    for j := 1 to T do
      Tabla[i, j] := 0;
end;

procedure Imprimirtabla(const Tabla: SudokuTabla);
var
  i, j: Integer;
begin
  for i := 1 to T do
  begin
    for j := 1 to T do
    begin
      if Tabla[i, j] = 0 then
        write('_ ')
      else
        write(Tabla[i, j], ' ');
      if j mod 3 = 0 then
        write(' ');
    end;
    writeln();
    if i mod 3 = 0 then
      writeln();
  end;
end;

function Comprobar(const Tabla: SudokuTabla; fila, columna, num: Integer): Boolean;
var
  i, j, startfil, startCol: Integer;
begin
  // aca va a verificar si el numero ya existe en la fila o columna
  for i := 1 to T do
  begin
    if (Tabla[fila, i] = num) or (Tabla[i, columna] = num) then
      Exit(False);
  end;

  // aca verificar si el numero ya existe en el bloque 3x3
  startfil := 3 * ((fila - 1) div 3) + 1;
  startCol := 3 * ((columna - 1) div 3) + 1;

  for i := startfil to startfil + 2 do
    for j := startCol to startCol + 2 do
      if Tabla[i, j] = num then
        Exit(False);

  // y si es seguro el numero para colocarlo en esta posición
  Exit(True);
end;

function Espaciovacio(const Tabla: SudokuTabla; var fila, columna: Integer): Boolean;
var
  i, j: Integer;
begin
  for i := 1 to T do
    for j := 1 to T do
      if Tabla[i, j] = 0 then
      begin
        fila := i;
        columna := j;
        Exit(True);
      end;

  // si no hay espacio vacios en el tablero
  Exit(False);
end;

function Resolversudoku(var Tabla: SudokuTabla): Boolean;
var
  fila, columna, num: Integer;
begin
  if not Espaciovacio(Tabla, fila, columna) then
    Exit(True); 
    // aca muestra el sudoku resuelto

  for num := 1 to T do
  begin
    if Comprobar(Tabla, fila, columna, num) then
    begin
      Tabla[fila, columna] := num;

      if Resolversudoku(Tabla) then
        Exit(True);

     
      Tabla[fila, columna] := 0;
    end;
  end;

  // aca es cuando no hay solucion
  Exit(False);
end;

procedure Generartabla(var Tabla: SudokuTabla);
begin
  // aca van las pistas del tablero

  Tabla[1, 2] := 3;
  Tabla[1, 3] := 7;
  Tabla[1, 5] := 4;
  Tabla[1, 6] := 1;
  Tabla[1, 7] := 8;
  Tabla[2, 4] := 1;
  Tabla[2, 5] := 9;
  Tabla[2, 9] := 5;
  Tabla[3, 1] := 4;
  Tabla[3, 3] := 5;
  Tabla[3, 4] := 8;
  Tabla[3, 7] := 2;
  Tabla[3, 9] := 9;
  Tabla[4, 2] := 9;
  Tabla[4, 3] := 1;
  Tabla[4, 6] := 7;
  Tabla[5, 1] := 8;
  Tabla[5, 2] := 2;
  Tabla[5, 5] := 3;
  Tabla[5, 8] := 6;
  Tabla[6, 4] := 6;
  Tabla[6, 7] := 9;
  Tabla[6, 8] := 5;
  Tabla[7, 1] := 7;
  Tabla[7, 3] := 8;
  Tabla[7, 6] := 3;
  Tabla[7, 7] := 1;
  Tabla[8, 1] := 3;
  Tabla[8, 5] := 6;
  Tabla[8, 6] := 2;
  Tabla[8, 9] := 4;
  Tabla[9, 3] := 9;
  Tabla[9, 4] := 4;
  Tabla[9, 6] := 6;
  Tabla[9, 8] := 3;
  
end;

procedure Jugar(var Tabla: SudokuTabla);
var
  fila, columna, num: Integer;
  nombre: String;
  opcion: Char;
begin
  writeln('Bienvenido al juego de Sudoku!');
  writeln('Por favor, ingresa tu nombre:');
  readln(nombre);
  writeln('Hola, ', nombre, '! Este es el tablero inicial:');
  Iniciartabla(Tabla);
  Generartabla(Tabla);
  Imprimirtabla(Tabla);

  repeat
    writeln('Ingresa las coordenadas de la casilla (fila y columna) donde quieres colocar un numero (1-9).');
    writeln('Para terminar el juego, ingresa una fila o columna fuera del rango (por ejemplo, 0).');
    writeln('Para rendirte y salir del juego, ingresa "R".');
    write('Fila: ');
    readln(fila);

    if fila = 0 then
      Break; 

    write('Columna: ');
    readln(columna);

    if columna = 0 then
      Break; 

    if (fila < 1) or (fila > T) or (columna < 1) or (columna > T) then
    begin
      writeln('Coordenadas invalidas. Intenta nuevamente.');
      continue;
    end;

    write('Numero: ');
    readln(num);

    if (num < 1) or (num > T) then
    begin
      writeln('Numero invalido. Intenta nuevamente.');
      continue;
    end;

    if not Comprobar(Tabla, fila, columna, num) then
    begin
      writeln('Numero no valido en esta posicion. Intenta nuevamente.');
      continue;
    end;

    Tabla[fila, columna] := num;
    writeln('Numero colocado correctamente.');
    Imprimirtabla(Tabla);

    writeln('¿Deseas colocar otro numero? (S/N)');
    readln(opcion);
  until (opcion = 'N') or (opcion = 'n') or (opcion = 'R') or (opcion = 'r');

  if (opcion = 'R') or (opcion = 'r') then
  begin
    writeln('Te has rendido. ¡Mejor suerte la proxima vez!');
  end
  else
  begin
    writeln('¡Felicidades, ', nombre, '! Has completado el Sudoku.');
  end;
end;

var
  Tabla: SudokuTabla;

begin
  Jugar(Tabla);
end.


 // Constante T <- 9

 //Tipo SudokuTabla: Matriz[T, T] de Entero

 //Procedimiento Iniciartabla(Var Tabla: SudokuTabla)
    //Llenar Tabla con ceros
 //Fin Procedimiento

 //Procedimiento Imprimirtabla(Con Tabla: SudokuTabla)
   // Para cada fila en Tabla hacer
        //Para cada columna en fila hacer
            //Si el valor en Tabla[fila, columna] es 0 entonces
                //Escribir "_ "
            //Sino
                //Escribir Tabla[fila, columna] + " "
            //Fin Si
            //Si columna mod 3 = 0 entonces
                //Escribir " "
            //Fin Si
        //Fin Para
        //Escribir NuevaLínea
        //Si fila mod 3 = 0 entonces
            //Escribir NuevaLínea
        //Fin Si
    //Fin Para
 //Fin Procedimiento

 //Función Comprobar(Con Tabla: SudokuTabla, fila, columna, num: Entero): Booleano
    //Para cada i en [1, T] hacer
        //Si (Tabla[fila, i] = num) o (Tabla[i, columna] = num) entonces
            //Retornar Falso
        //Fin Si
    //Fin Para
    //startfil <- 3 * ((fila - 1) / 3) + 1
    //startCol <- 3 * ((columna - 1) / 3) + 1
    //Para cada i en [startfil, startfil + 2] hacer
        //Para cada j en [startCol, startCol + 2] hacer
            //Si Tabla[i, j] = num entonces
                //Retornar Falso
            //Fin Si
        //Fin Para
    //Fin Para
    //Retornar Verdadero
 //Fin Función

 //Función Espaciovacio(Con Tabla: SudokuTabla, Var fila, columna: Entero): Booleano
    //Para cada fila en Tabla hacer
        //Para cada columna en fila hacer
            //Si Tabla[fila, columna] = 0 entonces
                //fila <- fila
                //columna <- columna
                //Retornar Verdadero
            //Fin Si
        //Fin Para
    //Fin Para
    //Retornar Falso
 //Fin Función

 //Función Resolversudoku(Var Tabla: SudokuTabla): Booleano
    //Entero fila, columna, num
    //Si No Espaciovacio(Tabla, fila, columna) entonces
        //Retornar Verdadero
    //Fin Si
    //Para cada num en [1, T] hacer
        //Si Comprobar(Tabla, fila, columna, num) entonces
            //Tabla[fila, columna] <- num
            //Si Resolversudoku(Tabla) entonces
                //Retornar Verdadero
            //Fin Si
            //Tabla[fila, columna] <- 0
        //Fin Si
    //Fin Para
    //Retornar Falso
 //Fin Función

 //Procedimiento Generartabla(Var Tabla: SudokuTabla)
    //Asignar valores iniciales a Tabla
 //fin Procedimiento

 //Procedimiento Jugar(Var Tabla: SudokuTabla)
    //Iniciartabla(Tabla)
    //Generartabla(Tabla)
    //Imprimirtabla(Tabla)
    //Mientras haya casillas vacías en Tabla hacer
        //Leer fila, columna, num
        //Si el valor es válido en la posición (fila, columna) según las reglas del Sudoku entonces
            //Tabla[fila, columna] <- num
            //Imprimirtabla(Tabla)
        //Sino
            //Escribir "Número no válido en esta posición. Intenta nuevamente."
        //Fin Si
    //Fin Mientras
    //Escribir "¡Felicidades! Has completado el Sudoku."
 //Fin Procedimiento

 //SudokuTabla Tabla

 //Jugar(Tabla)
