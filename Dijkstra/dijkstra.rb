class Graph
  def initialize
    @edges = {}
  end

  def add_edge(from, to, weight)
    @edges[from] ||= []
    @edges[from] << { node: to, weight: weight }
    @edges[to] ||= []
    @edges[to] << { node: from, weight: weight } # Видалити цей рядок, якщо граф орієнтований
  end

  def shortest_path(start, goal)
    distances = Hash.new(Float::INFINITY)
    distances[start] = 0
    priority_queue = [[0, start]]
    previous_nodes = {}

    until priority_queue.empty?
      current_distance, current_node = priority_queue.shift

      next if current_distance > distances[current_node]

      @edges[current_node]&.each do |edge|
        neighbor, weight = edge[:node], edge[:weight]
        new_distance = current_distance + weight

        if new_distance < distances[neighbor]
          distances[neighbor] = new_distance
          previous_nodes[neighbor] = current_node
          priority_queue << [new_distance, neighbor]
          priority_queue.sort_by!(&:first) # Мінімізуємо вагу
        end
      end
    end

    path = []
    current_node = goal

    while current_node
      path.unshift(current_node)
      current_node = previous_nodes[current_node]
    end

    path.empty? || path.first != start ? nil : { path: path, distance: distances[goal] }
  end
end

# Приклад використання
graph = Graph.new
graph.add_edge("A", "B", 4)
graph.add_edge("A", "C", 2)
graph.add_edge("B", "C", 5)
graph.add_edge("B", "D", 10)
graph.add_edge("C", "D", 3)

result = graph.shortest_path("A", "D")
if result
  puts "Найкоротший шлях: #{result[:path].join(' -> ')}"
  puts "Загальна вага: #{result[:distance]}"
else
  puts "Шлях не знайдено"
end
