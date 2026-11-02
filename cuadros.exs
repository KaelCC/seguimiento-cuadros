
defmodule Cuadrados do

  @moduledoc """
  Este modulo permite generar cuadrados mediante recursividad
  y representarlos utilizando el formato SVG.

  Cada cuadrado generado tiene una reduccion en la longitud
  de sus lados respecto al cuadrado anterior, manteniendo
  su posicion centrada.

  Finalmente, los cuadrados generados se almacenan en un
  archivo llamado cuadrados.svg.
  """

  @doc """
  Genera una secuencia de cuadrados utilizando recursividad.

  ## Parametros

    - x: coordenada inicial del cuadrado en el eje horizontal.
    - y: coordenada inicial del cuadrado en el eje vertical.
    - lado: longitud de los lados del cuadrado.
    - cuantos: cantidad de cuadrados que se desean generar.
    - reduccion: cantidad de pixeles que se reducen en los lados
      del siguiente cuadrado.

  ## Funcionamiento

  En cada llamada se genera un cuadrado utilizando la etiqueta
  rect de SVG.

  Posteriormente, se calculan nuevas coordenadas para mantener
  el siguiente cuadrado centrado y se reduce su longitud.

  La funcion se ejecuta recursivamente hasta que la cantidad
  de cuadrados llega a cero.

  ## Ejemplo

      crearCuadro(0, 0, 200, 3, 20)

  Genera tres cuadrados con lados de 200, 180 y 160 pixeles.
  """

  def crearCuadro(_x, _y, _lado, 0, _reduccion) do
    ""
  end

  def crearCuadro(x, y, lado, cuantos, reduccion) do

    cuadrados = """
      <rect
        width="#{lado}"
        height="#{lado}"
        x="#{x}"
        y="#{y}"
        fill="none"
        stroke="black"
        stroke-width="2"
      />
    """

    nuevo_x = x + reduccion / 2
    nuevo_Y = y + reduccion / 2
    nuevo_lado = lado - reduccion
    cuantos_restantes = cuantos - 1

    siguiente = if cuantos > 1 do
      crearCuadro(nuevo_x, nuevo_Y, nuevo_lado, cuantos_restantes, reduccion)
    else
      ""
    end

    cuadrados <> siguiente
  end


  @doc """
  Ejecuta el programa principal y solicita los datos necesarios
  para generar los cuadrados.

  ## Datos solicitados

    - Coordenada inicial en X.
    - Coordenada inicial en Y.
    - Longitud de los lados.
    - Cantidad de cuadrados.
    - Reduccion aplicada en cada llamada recursiva.

  ## Funcionamiento

  Utiliza crearCuadro/5 para generar los elementos SVG
  y posteriormente construye el documento SVG completo.

  Finalmente, guarda el resultado en el archivo cuadrados.svg.
  """

  def main do

    coordenada_x = IO.gets("ingrese coordenada en X: ")
        |> String.trim()
        |> String.to_integer()

    coordenada_y = IO.gets("ingrese coordenada en y: ")
        |> String.trim()
        |> String.to_integer()

    lado = IO.gets("que tan largo quiere los lados: ")
        |> String.trim()
        |> String.to_integer()

    cuanto = IO.gets("cuantos cuadrados quiere hacer: ")
        |> String.trim()
        |> String.to_integer()

    reduccion = IO.gets("cuantos pixeles de longitud le quieres quitar a cada lado en cada recursion: ")
        |> String.trim()
        |> String.to_integer()

    cuadrados = crearCuadro(coordenada_x, coordenada_y, lado, cuanto, reduccion)

    ancho = coordenada_x + lado + 50
    alto = coordenada_y + lado + 50

    svg = """
    <svg xmlns="http://www.w3.org/2000/svg"
    width="#{ancho}" height="#{alto}"
    viewBox="0 0 #{ancho} #{alto}">

    <rect width="100%" height="100%" fill="white"/>

    #{cuadrados}
    </svg>
    """

    File.write("cuadrados.svg", svg)
  end
end


Cuadrados.main()
