import heapq

def greedy_search(graph, start, goal):
    frontier = [(heuristic(start, goal), start)]  # Usamos a heurística como prioridade na fila de prioridade
    explored = set()  # Conjunto de nós já explorados

    while frontier:
        _, current_node = heapq.heappop(frontier)  # Obtemos o nó com a menor heurística
        if current_node == goal:
            return reconstruct_path(start, goal, came_from)
        
        explored.add(current_node)

        for neighbor in graph[current_node]:
            if neighbor not in explored:
                heapq.heappush(frontier, (heuristic(neighbor, goal), neighbor))

    return None  # Caso não encontremos um caminho

def heuristic(node, goal):
    # Implemente sua função de heurística aqui. Ela deve retornar uma estimativa
    # da distância do nó ao objetivo.
    pass

def reconstruct_path(start, goal, came_from):
    # Função para reconstruir o caminho a partir do dicionário came_from.
    pass

# Exemplo de uso:
grafo = {
    'Elvas': {'Alandroal': 40, 'Arrailos': 50, 'Borba': 15},
    'Alendroal': {'Redondo': 25},
    'Redondo': {'Monsaraz': 30},
    'Barreiro': {'Baixa Banheira': 5, 'Palmela': 25},
    'Palmela': {'Álcacer': 35, 'Almada': 25},
    'Baixa Banheira': {'Moita': 7},
    'Moita': {'Alcochete': 20},
    'Arrailos': {'Alcácer': 90},
    'Borba': {'Estremoz': 15},
    'Estremoz': {'Evora': 40},
    'Evora': {'Montemor': 20},
    'Montemor': {'Vendas Novas': 15},
    'Alcochete': {'Lisboa': 20},
    'Almada': {'Lisboa': 20},
    'Vendas Novas': {'Lisboa': 20},
    'Lisboa': {}
}

start_node = 'A'
goal_node = 'G'

path = greedy_search(grafo, start_node, goal_node)
if path:
    print(f'Caminho encontrado: {path}')
else:
    print('Não foi possível encontrar um caminho.')