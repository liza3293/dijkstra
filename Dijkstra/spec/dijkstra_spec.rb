require_relative '../dijkstra.rb'

RSpec.describe 'Алгоритм Дейкстри' do
  before do
    @graph = Graph.new
    @graph.add_edge("A", "B", 4)
    @graph.add_edge("A", "C", 2)
    @graph.add_edge("B", "C", 5)
    @graph.add_edge("B", "D", 10)
    @graph.add_edge("C", "D", 3)
  end

  context 'Пошук найкоротшого шляху' do
    it 'знаходить найкоротший шлях між двома вершинами' do
      result = @graph.shortest_path("A", "D")
      expect(result[:path]).to eq(["A", "C", "D"])
      expect(result[:distance]).to eq(5)
    end

    it 'повертає nil, якщо шляху немає' do
      result = @graph.shortest_path("A", "E")
      expect(result).to be_nil
    end

    it 'знаходить шлях, коли початкова і кінцева вершини однакові' do
      result = @graph.shortest_path("A", "A")
      expect(result[:path]).to eq(["A"])
      expect(result[:distance]).to eq(0)
    end
  end

  context 'Робота з розєднаними графами' do
    it 'повертає nil для вершин у розєднаній частині графа' do
    @graph.add_edge("E", "F", 1) # Додаємо відокремлену частину графа
    result = @graph.shortest_path("A", "F")
    expect(result).to be_nil
  end
end

context 'Вибір найкоротшого шляху з кількох варіантів' do
  it 'вибирає найкоротший шлях навіть за наявності довшого альтернативного' do
    @graph.add_edge("A", "D", 7) # Альтернативний довший шлях
    result = @graph.shortest_path("A", "D")
    expect(result[:path]).to eq(["A", "C", "D"])
    expect(result[:distance]).to eq(5)
  end
end
end
