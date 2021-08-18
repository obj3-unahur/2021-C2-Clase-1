class ParqueDiversion
  CAPACIDAD_MAXIMA = 100

  attr_reader :atracciones, :visitantes

  def initialize
    @atracciones = []
    @visitantes = []
  end

  def agregar(atraccion)
    @atracciones.push(atraccion)
  end

  def ingresar(visitante)
    if visitantes.length < CAPACIDAD_MAXIMA
      visitantes.push(visitante)
    else
      raise StandardError.new "Parque lleno"
    end
  end

  def redituable?
    ganancia > 1000
  end

  def nuevo_monto_maximo_atracciones(nuevo_monto)
    Atraccion.monto_maximo = nuevo_monto
  end

  private

  def ganancia
    atracciones.map { |atraccion| atraccion.ganancia }.sum
    # total = 0
    # atracciones.each do |atraccion|
    #   total += atraccion.ganancia
    # end
    # total
  end
end

class Atraccion
  @@monto_maximo = 500
  attr_reader :monto, :usos

  def initialize(monto, parque)
    @monto = monto
    @usos = 0
    parque.agregar(self)
  end

  def usar(visitante)
    @usos += 1
    visitante.dinero -= monto
  end

  def ganancia
    usos * monto
  end

  def self.monto_maximo
    @@monto_maximo
  end

  def self.monto_maximo=(nuevo_monto)
    @@monto_maximo = nuevo_monto
  end
end

class Visitante
  attr_accessor :dinero
  attr_reader :sabe_nadar

  def initialize(dinero, sabe_nadar = false)
    @dinero = dinero
    @sabe_nadar = sabe_nadar
  end
end

class AtraccionAcuatica < Atraccion
  def usar(visitante)
    # raise StandardError.new "No sabe nadar" if !visitante.sabe_nadar
    # super
    if visitante.sabe_nadar
      super # visitante va implicito
    else
      raise StandardError.new "El Visitante no sabe nadar"
    end
  end
end