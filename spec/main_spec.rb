require_relative '../src/main'

describe "Parque de Diversiones Tests" do
  before(:each) do
    @parque = ParqueDiversion.new
    @atraccion = Atraccion.new(400, @parque)
    @atraccion_acuatica = AtraccionAcuatica.new(500, @parque)
    @visitante = Visitante.new(2000)
  end

  it 'New parque should be empty' do
    expect(@parque.visitantes.length).to eq 0
  end

  it 'Parque debe ser redituable' do
    @atraccion.usar(@visitante)
    @atraccion.usar @visitante
    @atraccion.usar @visitante

    expect(@parque.redituable?).to eq(true)
  end

  it 'AtraccionAcuativa debe tirar error si visitante no sabe nadar' do
    expect { @atraccion_acuatica.usar(@visitante) }.to raise_exception(StandardError)
  end
end